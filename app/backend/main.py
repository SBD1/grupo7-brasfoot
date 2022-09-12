from time import time
import pandas as pd

from sqlalchemy import create_engine
from datetime import datetime, timedelta
from consolemenu import *
from consolemenu.items import *
from consolemenu.format import *
from consolemenu.menu_component import Dimension
from tabulate import tabulate
from random import randrange

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

    input('Transação efetuada com sucesso!')
    
    menu = ConsoleMenu(show_exit_option=False)
    voltar_item = FunctionItem("Voltar", main_menu, [choosen_team, i])
    menu.append_item(voltar_item)
    menu.show()


def sell_player(choosen_team, i):
    select = f""" SELECT name FROM player WHERE name_team = '{choosen_team}'"""
    df = pd.read_sql_query(select, con=ENGINE)
    print(tabulate(df, headers='keys', tablefmt='psql'))
    num_name_player = int(input('Insira o nome do jogador que você deseja vender: '))
    name_player = str(df.iloc[num_name_player].values)[2:-2]

    select = f""" SELECT name FROM team WHERE name <> '{choosen_team}'"""
    df = pd.read_sql_query(select, con=ENGINE)
    print(tabulate(df, headers='keys', tablefmt='psql'))
    num_buyer_team = int(input(f'Insira o time para vender o jogador {name_player}: '))
    buyer_name_team = str(df.iloc[num_buyer_team].values)[2:-2]
    transaction_value = int(input('Insira o valor da transação: '))

    sql = f"""BEGIN TRANSACTION;
    CALL sell_player('{name_player}', '{choosen_team}', '{buyer_name_team}', '{transaction_value}');
    COMMIT
    TRANSACTION;"""
    ENGINE.execute(sql)

    input('Transação efetuada com sucesso!')
    
    menu = ConsoleMenu(show_exit_option=False)
    voltar_item = FunctionItem("Voltar", main_menu, [choosen_team, i])
    menu.append_item(voltar_item)
    menu.show()


def play_round(choosen_team, team_id, i, date):

    date = date.strftime("%Y-%m-%d")

    if date != '2022-01-01':
        sql = f"""BEGIN TRANSACTION;
        CALL update_players_energy_before_match('{date}');
        COMMIT
        TRANSACTION;
        """
        ENGINE.execute(sql)

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
                    team = '{}'""".format(team_id), con=ENGINE).sort_values(by="position", key=lambda x: x.map({"G":0, "L":1, "Z":2, "M":3, "A":4})).reset_index(drop=True)

    df["salary"] = df["salary"].apply(lambda x: '${:,.2f}'.format((x/1000)))
    df["market_value"] = df["market_value"].apply(lambda x: '${:,.2f}'.format((x/1000)))
    df = df.rename(columns={"name":"jogador"})

    print(tabulate(df, headers='keys', tablefmt='fancy_grid'))

    n_players = list(map(int, input("Selecione os jogadores para a partida: ").split()))
    
    lineup_players = df.iloc[n_players].reset_index(drop=True)

    for j in range(len(lineup_players)):

        player = lineup_players.iloc[j]

        ENGINE.execute("""
                    INSERT INTO lineup_match (
                        id_match,
                        id_team,
                        name_team,
                        id_player,
                        name_player,
                        is_starter,
                        is_modified
                        )

                    VALUES (
                            
                        (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}'  OR match.id_team_visitor = '{}')),
                        
                        '{}',
                        
                        '{}',

                        (SELECT player.id FROM player WHERE (player.name = '{}') AND (player.name_team = '{}')),
                        
                        '{}',
                        
                        True,
                        
                        False);""".format(
                            date,
                            team_id,
                            team_id,
                            team_id,
                            choosen_team,
                            player.jogador,
                            choosen_team,
                            player.jogador,


                        ), con=ENGINE)

    print("\nJOGADORES ESCALADOS")

    other_teams = pd.read_sql_query(f""" SELECT team.id, team.name FROM team WHERE name <> '{choosen_team}'""", con=ENGINE)
    
    for id, name in zip(other_teams["id"], other_teams["name"]):
    
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
                        team = '{}'""".format(id), con=ENGINE).sort_values(by="position", key=lambda x: x.map({"G":0, "L":1, "Z":2, "M":3, "A":4})).reset_index(drop=True)

        list_players = [df[df["position"] == "G"].iloc[0].name] + list(df[df["position"] == "L"].iloc[0:2].index) + list(df[df["position"] == "Z"].iloc[0:2].index) + list(df[df["position"] == "M"].iloc[0:4].index) + list(df[df["position"] == "A"].iloc[0:2].index)

        lineup_players = df.iloc[list_players].reset_index(drop=True)
        lineup_players = lineup_players.rename(columns={"name":"jogador"})

        for j in range(len(lineup_players)):

            player = lineup_players.iloc[j]

            ENGINE.execute("""
                        INSERT INTO lineup_match (
                            id_match,
                            id_team,
                            name_team,
                            id_player,
                            name_player,
                            is_starter,
                            is_modified
                            )

                        VALUES (
                                
                            (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}'  OR match.id_team_visitor = '{}')),
                            
                            '{}',
                            
                            '{}',

                            (SELECT player.id FROM player WHERE (player.name = '{}') AND (player.name_team = '{}')),
                            
                            '{}',
                            
                            True,
                            
                            False);""".format(
                                date,
                                id,
                                id,
                                id,
                                name,
                                player.jogador,
                                name,
                                player.jogador,


                            ), con=ENGINE)

    print("GERANDO RESULTADOS")

    for j in range(len(pd.read_sql_query("SELECT * FROM public.match WHERE date = '{}'".format(date), con=ENGINE))):

        host = str(pd.read_sql_query("SELECT * FROM public.match WHERE date = '{}'".format(date), con=ENGINE).iloc[j].id_team_host)
        visitor = str(pd.read_sql_query("SELECT * FROM public.match WHERE date = '{}'".format(date), con=ENGINE).iloc[j].id_team_visitor)

        players_ids = "("

        for j in range(len(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(host), con=ENGINE)["id_player"])):

            if j == (len(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(host), con=ENGINE)["id_player"]) - 1):
                players_ids += "'{}')".format(str(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(host), con=ENGINE)["id_player"][j]))
            else:
                players_ids += "'{}',".format(str(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(host), con=ENGINE)["id_player"][j]))

        host_team_strength = pd.read_sql_query("SELECT * FROM public.player WHERE player.id IN {}".format(players_ids), con=ENGINE)["strength"].mean()
        host_team_energy = pd.read_sql_query("SELECT * FROM public.player WHERE player.id IN {}".format(players_ids), con=ENGINE)["energy"].mean()

        players_ids = "("

        for j in range(len(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(visitor), con=ENGINE)["id_player"])):

            if j == (len(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(visitor), con=ENGINE)["id_player"]) - 1):
                players_ids += "'{}')".format(str(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(visitor), con=ENGINE)["id_player"][j]))
            else:
                players_ids += "'{}',".format(str(pd.read_sql_query("SELECT id_player FROM public.lineup_match WHERE (id_team = '{}')".format(visitor), con=ENGINE)["id_player"][j]))

        visitor_team_strength = pd.read_sql_query("SELECT * FROM public.player WHERE player.id IN {}".format(players_ids), con=ENGINE)["strength"].mean()
        visitor_team_energy = pd.read_sql_query("SELECT * FROM public.player WHERE player.id IN {}".format(players_ids), con=ENGINE)["energy"].mean()

        host_score = host_team_strength * host_team_energy
        visitor_score = visitor_team_strength * visitor_team_energy


        if ((round(host_score) - round(visitor_score)) > 100):

            best_player = str(pd.read_sql_query("SELECT * FROM public.player WHERE team = '{}'".format(host), con=ENGINE).sort_values(by="strength").iloc[-1]["id"])
            capacity = list(pd.read_sql_query("SELECT * FROM stadium WHERE team = '{}'".format(host), con=ENGINE)["capacity"])[0]
            price = list(pd.read_sql_query("SELECT * FROM stadium WHERE team = '{}'".format(host), con=ENGINE)["ticket_price"])[0]
            public = randrange(int(capacity/2), capacity)
            income = public * price
            public = str(public)
            income = str(income)

            ENGINE.execute("""INSERT INTO played_match (
                                                    id_match,
                                                    id_championship,
                                                    public,
                                                    income
                                                )

                                                VALUES (
                                                    (SELECT id FROM public.match WHERE (id_team_host = '{}') AND (id_team_visitor = '{}') AND (date = '{}')),
                                                    (SELECT id FROM public.championship WHERE is_cup = 'False'),
                                                    {},
                                                    {}
                                                );""".format(
                                                    host, 
                                                    visitor,
                                                    date, 
                                                    public,
                                                    income))

            ENGINE.execute("""INSERT INTO event (
                                            id_match,
                                            id_team,
                                            name_team,
                                            id_player,
                                            name_player,
                                            event_type
                                        )

                                        VALUES (
                                            (SELECT id FROM public.match WHERE (id_team_host = '{}') AND (id_team_visitor = '{}') AND (date = '{}')),
                                            '{}',
                                            '{}',
                                            '{}',
                                            '{}',
                                            'goal');""".format(
                                                host,
                                                visitor,
                                                date,
                                                host,
                                                pd.read_sql_query("SELECT name FROM public.team WHERE id = '{}'".format(host), con=ENGINE)["name"][0],
                                                best_player,
                                                pd.read_sql_query("SELECT name FROM public.player WHERE id = '{}'".format(best_player), con=ENGINE)["name"][0]                                      
                                                ))
            name_team = str(pd.read_sql_query("SELECT name FROM public.team WHERE id = '{}'".format(host), con=ENGINE)["name"][0])
            visitor_name = list(pd.read_sql_query(f"""SELECT name FROM team WHERE team.id = '{visitor}'""", con=ENGINE)['name'])[0]
            name_player = str(pd.read_sql_query("SELECT name FROM public.player WHERE id = '{}'".format(best_player), con=ENGINE)["name"][0])
            print(f'\nGOOOOOOOLLLL do {name_player}\nO {name_team} ganha a partida contra o {visitor_name}!!!')

        elif (round(visitor_score) - (round(host_score)) > 100):

            best_player = str(pd.read_sql_query("SELECT * FROM public.player WHERE team = '{}'".format(visitor), con=ENGINE).sort_values(by="strength").iloc[-1]["id"])
            capacity = list(pd.read_sql_query("SELECT * FROM stadium WHERE team = '{}'".format(host), con=ENGINE)["capacity"])[0]
            price = list(pd.read_sql_query("SELECT * FROM stadium WHERE team = '{}'".format(host), con=ENGINE)["ticket_price"])[0]
            public = randrange(int(capacity/2), capacity)
            income = public * price
            public = str(public)
            income = str(income)

            ENGINE.execute("""INSERT INTO played_match (
                                                    id_match,
                                                    id_championship,
                                                    public,
                                                    income
                                                )

                                                VALUES (
                                                    (SELECT id FROM public.match WHERE (id_team_host = '{}') AND (id_team_visitor = '{}') AND (date = '{}')),
                                                    (SELECT id FROM public.championship WHERE is_cup = 'False'),
                                                    {},
                                                    {}
                                                );""".format(
                                                    host, 
                                                    visitor,
                                                    date,
                                                    public,
                                                    income))

            ENGINE.execute("""INSERT INTO event (
                                            id_match,
                                            id_team,
                                            name_team,
                                            id_player,
                                            name_player,
                                            event_type
                                        )

                                        VALUES (
                                            (SELECT id FROM public.match WHERE (id_team_host = '{}') AND (id_team_visitor = '{}') AND (date = '{}')),
                                            '{}',
                                            '{}',
                                            '{}',
                                            '{}',
                                            'goal');""".format(
                                                host,
                                                visitor,
                                                date,
                                                visitor,
                                                pd.read_sql_query("SELECT name FROM public.team WHERE id = '{}'".format(visitor), con=ENGINE)["name"][0],
                                                best_player,
                                                pd.read_sql_query("SELECT name FROM public.player WHERE id = '{}'".format(best_player), con=ENGINE)["name"][0]                                      
                                                ))
            name_team = pd.read_sql_query("SELECT name FROM public.team WHERE id = '{}'".format(visitor), con=ENGINE)["name"][0]
            host_name = list(pd.read_sql_query(f"""SELECT name FROM team WHERE team.id = '{host}'""", con=ENGINE)['name'])[0]
            name_player = pd.read_sql_query("SELECT name FROM public.player WHERE id = '{}'".format(best_player), con=ENGINE)["name"][0]
            print(f'\nGOOOOOOOLLLL do {name_player}\nO {name_team} ganha a partida contra o {host_name}!!!')

        else:
            capacity = list(pd.read_sql_query("SELECT * FROM stadium WHERE team = '{}'".format(host), con=ENGINE)["capacity"])[0]
            price = list(pd.read_sql_query("SELECT * FROM stadium WHERE team = '{}'".format(host), con=ENGINE)["ticket_price"])[0]
            public = randrange(int(capacity/2), capacity)
            income = public * price
            public = str(public)
            income = str(income)

            ENGINE.execute("""INSERT INTO played_match (
                                                    id_match,
                                                    id_championship,
                                                    public,
                                                    income
                                                )

                                                VALUES (
                                                    (SELECT id FROM public.match WHERE (id_team_host = '{}') AND (id_team_visitor = '{}') AND (date = '{}')),
                                                    (SELECT id FROM public.championship WHERE is_cup = 'False'),
                                                    {},
                                                    {}
                                                );""".format(
                                                    host,
                                                    visitor,
                                                    date,
                                                    public,
                                                    income))
            host_name = list(pd.read_sql_query(f"""SELECT name FROM team WHERE team.id = '{host}'""", con=ENGINE)['name'])[0]
            visitor_name = list(pd.read_sql_query(f"""SELECT name FROM team WHERE team.id = '{visitor}'""", con=ENGINE)['name'])[0]
            print(f"\nEmpate entre {host_name} e {visitor_name}")

    input("\nRODADA CONCLUÍDA\n\nAperte enter para finalizar a rodada...")
    
    sql = f"""BEGIN TRANSACTION;
    CALL update_players_energy_after_match('{date}');
    COMMIT
    TRANSACTION;
    """
    ENGINE.execute(sql)

    i = i+7

    menu = ConsoleMenu(show_exit_option=False)
    voltar_item = FunctionItem("Voltar", main_menu, [choosen_team, i])
    menu.append_item(voltar_item)
    menu.show()


def get_ranking(date, i):

    if i == 0:
        ranking = pd.read_sql_query("SELECT name FROM public.team", con=ENGINE)
        ranking["Pontos"] = [0] * len(ranking)
        ranking = ranking.rename(columns={"name":"Time"})
        ranking = ranking.sort_values(by="Pontos", ascending=False).reset_index(drop=True)
        ranking.index += 1
        thin = Dimension(width=len(tabulate(ranking, headers='keys', tablefmt='fancy_grid').split("\n")[0])+20, height=len(tabulate(ranking, headers='keys', tablefmt='fancy_grid').split("\n")[0])+20)
        menu_format = MenuFormatBuilder(max_dimension=thin)
        menu_format.set_title_align('center')   
        menu_format.set_prologue_text_align('center')
        ranking_menu = ConsoleMenu(title="Ranking", subtitle="Data: "+date.strftime("%d/%m/%Y"), prologue_text=tabulate(ranking, headers='keys', tablefmt='fancy_grid'), exit_option_text="Voltar")
        ranking_menu.formatter = menu_format
        ranking_menu.show()
    else:
        event = pd.read_sql_query("SELECT * FROM public.event", con=ENGINE)
        match = pd.read_sql_query("SELECT * FROM public.match", con=ENGINE)
        played_match = pd.read_sql_query("SELECT * FROM public.played_match", con=ENGINE)
        matches = pd.merge(match, played_match, how="left", left_on="id", right_on="id_match")
        results = pd.merge(matches, event, how="right", left_on="id_match", right_on="id_match").dropna()

        matches = {}

        for i in range(len(results)):

            if results.iloc[i]["name_team_host"] == results.iloc[i]["name_team"]:
                matches[i] = {"host":results.iloc[i]["name_team_host"],
                            "visitor":results.iloc[i]["name_team_visitor"],
                            "winner":results.iloc[i]["name_team"]}
            else:
                matches[i] = {"host":results.iloc[i]["name_team_host"],
                        "visitor":results.iloc[i]["name_team_visitor"],
                        "winner":results.iloc[i]["name_team"]}

        winners = pd.DataFrame(matches).T
        winners = winners.groupby(['winner'])['winner'].count()
        ranking = pd.read_sql_query("SELECT name FROM public.team", con=ENGINE)
        points = []

        for name in ranking["name"]:
            try:
                points.append(winners[name] * 3)
            except: 
                points.append(0)

        ranking["Pontos"] = points
        ranking = ranking.rename(columns={"name":"Time"})
        ranking = ranking.sort_values(by="Pontos", ascending=False).reset_index(drop=True)
        ranking.index += 1

        thin = Dimension(width=len(tabulate(ranking, headers='keys', tablefmt='fancy_grid').split("\n")[0])+20, height=len(tabulate(ranking, headers='keys', tablefmt='fancy_grid').split("\n")[0])+20)

        menu_format = MenuFormatBuilder(max_dimension=thin)
        menu_format.set_title_align('center')   
        menu_format.set_prologue_text_align('center')

        ranking_menu = ConsoleMenu(title="Ranking", subtitle="Data: "+date.strftime("%d/%m/%Y"), prologue_text=tabulate(ranking, headers='keys', tablefmt='fancy_grid'), exit_option_text="Voltar")
        ranking_menu.formatter = menu_format

        ranking_menu.show()


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
    sell_player_item = FunctionItem("Vender Jogador", sell_player, [choosen_team, i])
    play_match_item = FunctionItem("Jogar Partida", play_round, [choosen_team, team_id, i, date])
    ranking_item = FunctionItem("Classificação", get_ranking, [date, i])

    menu.append_item(calendar_item)
    menu.append_item(buy_player_item)
    menu.append_item(sell_player_item)
    menu.append_item(play_match_item)
    menu.append_item(ranking_item)


    menu.show()


def init():

    ENGINE.execute("DELETE FROM coach")
    ENGINE.execute("DELETE FROM match")
    ENGINE.execute("DELETE FROM lineup_match")
    ENGINE.execute("DELETE FROM played_match")
    ENGINE.execute("DELETE FROM event")

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