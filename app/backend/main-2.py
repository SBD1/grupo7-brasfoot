from time import time
import pandas as pd

from sqlalchemy import create_engine
from datetime import datetime, timedelta
from consolemenu import *
from consolemenu.items import *
from consolemenu.format import *
from consolemenu.menu_component import Dimension
from tabulate import tabulate

ENGINE = create_engine("postgresql://brasfoot:brasfoot@localhost:5432/brasfoot")


def create_coach(coach_name,choosen_team):
    sql = f"""BEGIN TRANSACTION;
    CALL create_coach('{coach_name}', 'Brazil', '{choosen_team}');
    COMMIT
    TRANSACTION;"""
    ENGINE.execute(sql)


def create_rounds():
    players = list(pd.read_sql_query('SELECT name FROM team ORDER BY name ASC', con=ENGINE)["name"].values)
    s = []
    if len(players) % 2 == 1: players = players + [None]
    # manipulate map (array of indexes for list) instead of list itself
    # this takes advantage of even/odd indexes to determine home vs. away
    n = len(players)
    map = list(range(n))
    mid = n // 2
    for i in range(n-1):
        l1 = map[:mid]
        l2 = map[mid:]
        l2.reverse()
        round = []
        for j in range(mid):
            t1 = players[l1[j]]
            t2 = players[l2[j]]
            if j == 0 and i % 2 == 1:
                # flip the first match only, every other round
                # (this is because the first match always involves the last player in the list)
                round.append((t2, t1))
            else:
                round.append((t1, t2))
        s.append(round)
        # rotate list by n/2, leaving last element at the end
        map = map[mid:-1] + map[:mid] + map[-1:]

    second_turn = []

    for a in s:

        round = []

        for t in a:
            round.append(tuple(reversed(t)))

        second_turn.append(round)

    s = s + second_turn

    date = datetime(2022,1,1)

    for round in s:
        for match in round:
            ENGINE.execute(
                """INSERT INTO match (
                    id_championship,
                    date,
                    id_team_host,
                    name_team_host,
                    id_team_visitor,
                    name_team_visitor,
                    id_stadium
                )
                VALUES (
                    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE LIMIT 1),
                    '{}',
                    (SELECT id FROM team WHERE team.name = '{}' LIMIT 1),
                    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = '{}')),
                    (SELECT id FROM team WHERE team.name = '{}' LIMIT 1),
                    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = '{}')),
                    (SELECT stadium.id FROM stadium,team WHERE stadium.team = team.id AND team.name = '{}' LIMIT 1)
                );""".format(date.strftime("%m/%d/%Y"), match[0], match[0], match[1], match[1], match[0])
            )
        date = date + timedelta(7)


def get_team_table(team_id):
    df = pd.read_sql_query(
            """
                SELECT 
                    position, 
                    name, 
                    age, 
                    strength, 
                    energy,
                    feature1,
                    feature2,
                    salary,
                    market_value,
                    contract_due_date
                FROM 
                    player 
                WHERE 
                    team = '{}'""".format(team_id), con=ENGINE).sort_values(by="position", key=lambda x: x.map({"G":0, "L":1, "Z":2, "M":3, "A":4})).set_index("position")

    df["salary"] = df["salary"].apply(lambda x: '${:,.2f}'.format((x/1000)))
    df["market_value"] = df["market_value"].apply(lambda x: '${:,.2f}'.format((x/1000)))

    return tabulate(df, headers='keys', tablefmt='fancy_grid')


def get_calendar(choosen_team, date):
    df = pd.read_sql_query("""
    SELECT
        date,
        name_team_host,
        name_team_visitor
    FROM
        match
    WHERE
        name_team_host = '{}' OR name_team_visitor = '{}'
    ORDER BY 
        date""".format(
                    choosen_team,
                    choosen_team
                ),
                con=ENGINE)

    thin = Dimension(width=len(tabulate(df, headers='keys', tablefmt='fancy_grid').split("\n")[0])+20, height=len(tabulate(df, headers='keys', tablefmt='fancy_grid').split("\n")[0])+20)

    menu_format = MenuFormatBuilder(max_dimension=thin)
    menu_format.set_title_align('center')   
    menu_format.set_prologue_text_align('center')

    calendar_menu = ConsoleMenu(title="Calendário", subtitle="Data: "+date.strftime("%d/%m/%Y"), prologue_text=tabulate(df, headers='keys', tablefmt='fancy_grid'), exit_option_text="Voltar")
    calendar_menu.formatter = menu_format

    calendar_menu.show()


def buy_player(choosen_team, i):


    select = f""" SELECT name FROM team WHERE name <> '{choosen_team}'"""
    df = pd.read_sql_query(select, con=ENGINE)
    print(tabulate(df, headers='keys', tablefmt='fancy_grid'))
    select = int(input('Insira o time do jogador a ser comprado: '))
    seller_name_team = str(df.iloc[select].values)[2:-2]

    select = f""" SELECT name FROM player WHERE name_team = '{seller_name_team}'"""
    df = pd.read_sql_query(select, con=ENGINE)
    print(tabulate(df, headers='keys', tablefmt='fancy_grid'))
    select = int(input(f'Insira o jogador do {seller_name_team} que você deseja comprar: '))
    name_player = str(df.iloc[select].values)[2:-2]
    transaction_value = int(input('Insira o valor da transação: '))


    sql = f"""BEGIN TRANSACTION;
    CALL buy_player('{name_player}', '{choosen_team}', '{seller_name_team}', '{transaction_value}');
    COMMIT
    TRANSACTION;"""
    ENGINE.execute(sql)

    input('Transação efetuada com sucesso! \nAperte enter para voltar ao menu principal.')
    
    menu = ConsoleMenu()
    voltar_item = FunctionItem("Menu", main_menu, [choosen_team, i])
    menu.append_item(voltar_item)
    menu.show()


def refresh(chosen_team):
    team_id = str(pd.read_sql_query(
    """
        SELECT 
            * 
        FROM 
            team 
        WHERE 
            name = '{}'""".format(choosen_team), con=ENGINE).reset_index(drop=True).id.values[0])

    team_table = get_team_table(team_id)
    patrimony = list(pd.read_sql_query(f"SELECT patrimony FROM FINANCE WHERE name_team = '{choosen_team}'", con=ENGINE)["patrimony"])[0]

    return team_table, patrimony

def main_menu(choosen_team, i):

    date = datetime(2022,1,1) + timedelta(i)

    team_table, patrimony = refresh(choosen_team)

    thin = Dimension(width=len(team_table.split("\n")[0])+20, height=len(team_table.split("\n")[0])+20)

    menu_format = MenuFormatBuilder(max_dimension=thin)
    menu_format.set_title_align('center')   
    menu_format.set_prologue_text_align('center')

    menu = ConsoleMenu(title="Brasfoot 2022", subtitle='Patrimônio: ${:,.2f}          Data: {}'.format(patrimony, date.strftime("%d/%m/%Y")), prologue_text=team_table, exit_option_text="Sair")
    menu.formatter = menu_format

    calendar_item = FunctionItem("Calendário", get_calendar, [choosen_team, date])
    buy_player_item = FunctionItem("Comprar Jogador", buy_player, [choosen_team, i])
    menu.append_item(calendar_item)
    menu.append_item(buy_player_item)


    menu.show()


def init():

    ENGINE.execute("DELETE FROM coach")
    ENGINE.execute("DELETE FROM match")

    print('Olá, seja bem-vind@ ao jogo Brasfoot!')
    coach_name = input('Escolha o seu nickname de treinador(a): ')

    print('Escolha um time para treinar: ')
    teams = pd.read_sql_query('SELECT name FROM team ORDER BY name ASC', con=ENGINE)
    print(teams)
    n = int(input('Número do time: '))

    choosen_team = str(teams.iloc[n].values)[2:-2]
    print('\n Você escolheu o time: ', choosen_team)

    team_id = str(pd.read_sql_query(
    """
        SELECT 
            * 
        FROM 
            team 
        WHERE 
            name = '{}'""".format(choosen_team), con=ENGINE).reset_index(drop=True).id.values[0])

    return coach_name, choosen_team, team_id

if __name__ == '__main__':
    
    i = 0

    coach_name, choosen_team, team_id = init()

    create_coach(coach_name, choosen_team)

    create_rounds()

    main_menu(choosen_team, i)