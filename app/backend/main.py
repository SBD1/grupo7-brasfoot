from time import time
import pandas as pd

from sqlalchemy import create_engine
from datetime import datetime, timedelta
from consolemenu import *
from consolemenu.items import *
from tabulate import tabulate

engine = create_engine("postgresql://brasfoot:brasfoot@localhost:5432/brasfoot")

def insert_coach(coach_name):
    sql = f"""
    BEGIN TRANSACTION;
    INSERT INTO coach (name, country)
    VALUES ('{coach_name}', 'Brazil');
    COMMIT TRANSACTION;
    """
    engine.execute(sql)


def trains(coach_name, choosen_team):
    sql = f"""BEGIN TRANSACTION;
    INSERT INTO trains(coach, team, name_team)
    VALUES(
    (SELECT id FROM public.coach WHERE coach.name = '{coach_name}'),
    (SELECT id FROM public.team WHERE team.name = '{choosen_team}'),
    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = '{choosen_team}'))
    );
    COMMIT
    TRANSACTION;"""
    engine.execute(sql)


def create_rounds():
    players = list(pd.read_sql_query('SELECT name FROM team ORDER BY name ASC', con=engine)["name"].values)
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
            engine.execute(
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


def get_calendar(choosen_team):
    df = pd.read_sql_query("""
    SELECT
        date,
        name_team_host,
        name_team_visitor
    FROM
        match
    WHERE
        name_team_host = '{}' OR name_team_visitor = '{}'""".format(choosen_team,choosen_team), con=engine)

    menu = ConsoleMenu(tabulate(df, headers='keys', tablefmt='psql'), exit_option_text=False)
    function_item = FunctionItem("Voltar", main_menu, [choosen_team])
    menu.append_item(function_item)
    menu.show()

def main_menu(choosen_team, i):

    date = datetime(2022,1,1) + timedelta(i)

    team_id = str(pd.read_sql_query(
    """
        SELECT 
            * 
        FROM 
            team 
        WHERE 
            name = '{}'""".format(choosen_team), con=engine).reset_index(drop=True).id.values[0])
    
    df = pd.read_sql_query(
        """
            SELECT 
                position, 
                name, 
                age, 
                side, 
                strength, 
                energy, 
                salary, 
                market_value, 
                feature1, 
                feature2, 
                contract_due_date 
            FROM 
                player 
            WHERE 
                team = '{}'""".format(team_id), con=engine).sort_values(by="position")

    menu = ConsoleMenu("Brasfoot", "No Brasfoot você comanda um time de futebol, compra e vende jogadores, define o preço dos ingressos, escolhe as táticas e participa dos campeonatos que simulam a realidade. O jogo é super leve, e várias temporadas podem ser jogadas de forma rápida e divertida \n\n\n {}".format(tabulate(df, headers='keys', tablefmt='psql')))
    function_item = FunctionItem("Calendário", get_calendar, [choosen_team])
    function_item2 = FunctionItem("Jogar Partida", create_lineups, [choosen_team, team_id, date, i])
    menu.append_item(function_item)
    menu.append_item(function_item2)
    menu.show()


def create_lineups(choosen_team, team_id, date, i):

    df = pd.read_sql_query(
        """
            SELECT 
                position, 
                name, 
                age, 
                side, 
                strength, 
                energy, 
                salary, 
                market_value, 
                feature1, 
                feature2, 
                contract_due_date 
            FROM 
                player 
            WHERE 
                team = '{}'""".format(team_id), con=engine).sort_values(by="position")

    for x in df.name:
        engine.execute("""
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
                                
                            (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}'  OR match.id_team_visitor = '{}') LIMIT 1),
                            
                            (SELECT id FROM team WHERE name = '{}' LIMIT 1),
                            
                            ('{}'),

                            (SELECT player.id FROM player,team WHERE (player.team = '{}' AND team.name = '{}' AND player.name = '{}')),
                            
                            ('{}'),
                            
                            True,
                            
                            False);""".format(
                                date.strftime("%m/%d/%Y"),
                                team_id,
                                team_id,
                                choosen_team,
                                choosen_team,
                                team_id,
                                choosen_team,
                                x,
                                x
                            ), con=engine)


    visitor_id = str(pd.read_sql_query("""SELECT * FROM match WHERE (match.date = '{}') AND (match.id_team_visitor = '{}' OR match.id_team_host = '{}') """.format(date.strftime("%m/%d/%Y"), team_id, team_id), con=engine)["id_team_visitor"].values[0])
    name_visitor = str(pd.read_sql_query("""SELECT * FROM match WHERE (match.date = '{}') AND (match.id_team_visitor = '{}' OR match.id_team_host = '{}') """.format(date.strftime("%m/%d/%Y"), team_id, team_id), con=engine)["name_team_visitor"].values[0])

    df = pd.read_sql_query(
        """
            SELECT 
                position, 
                name, 
                age, 
                side, 
                strength, 
                energy, 
                salary, 
                market_value, 
                feature1, 
                feature2, 
                contract_due_date 
            FROM 
                player 
            WHERE 
                team = '{}'""".format(visitor_id), con=engine).sort_values(by="position")

    for x in df.name:

        engine.execute("""
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
                                
                            (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}'  OR match.id_team_visitor = '{}') LIMIT 1),
                            
                            (SELECT id FROM team WHERE name = '{}' LIMIT 1),
                            
                            ('{}'),

                            (SELECT player.id FROM player,team WHERE (player.team = '{}' AND team.name = '{}' AND player.name = '{}')),
                            
                            ('{}'),
                            
                            True,
                            
                            False);""".format(
                                date.strftime("%m/%d/%Y"),
                                visitor_id,
                                visitor_id,
                                name_visitor,
                                name_visitor,
                                visitor_id,
                                name_visitor,
                                x,
                                x
                            ), con=engine)
    
    mean_team = pd.read_sql_query(
        """
            SELECT 
                position, 
                name, 
                age, 
                side, 
                strength, 
                energy, 
                salary, 
                market_value, 
                feature1, 
                feature2, 
                contract_due_date 
            FROM 
                player 
            WHERE 
                team = '{}'""".format(team_id), con=engine).sort_values(by="position")["strength"].mean()

    mean_visitor = pd.read_sql_query(
        """
            SELECT 
                position, 
                name, 
                age, 
                side, 
                strength, 
                energy, 
                salary, 
                market_value, 
                feature1, 
                feature2, 
                contract_due_date 
            FROM 
                player 
            WHERE 
                team = '{}'""".format(visitor_id), con=engine).sort_values(by="position")["strength"].mean()

    if mean_team > mean_visitor:

        championship = str(pd.read_sql_query("""SELECT * FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}'  OR match.id_team_visitor = '{}')""".format(date.strftime("%m/%d/%Y"), team_id,team_id), con=engine)["id_championship"].values[0])

        engine.execute("""INSERT INTO played_match (
                                                    id_match,
                                                    id_championship,
                                                    public,
                                                    income
                                                )

                                                VALUES (
                                                    (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}'  OR match.id_team_visitor = '{}') LIMIT 1),
                                                    '{}',
                                                    50000,
                                                    1000000
                                                );""".format(date.strftime("%m/%d/%Y"), team_id, team_id, championship))

        engine.execute("""INSERT INTO event (
                                            id_match,
                                            id_team,
                                            name_team,
                                            id_player,
                                            name_player,
                                            event_type
                                        )

                                        VALUES (
                                            (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}' OR match.id_team_visitor = '{}') LIMIT 1),
                                            '{}'
                                            'Corinthians',
                                            (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Yuri Alberto') LIMIT 1),
                                            'Yuri Alberto',
                                            'goal');""".format(date.strftime("%m/%d/%Y"), team_id, team_id, team_id))

        
    else:
        championship = str(pd.read_sql_query("""SELECT * FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}'  OR match.id_team_visitor = '{}')""".format(date.strftime("%m/%d/%Y"), team_id,team_id), con=engine)["id_championship"].values[0])
        
        engine.execute("""INSERT INTO played_match (
                                            id_match,
                                            id_championship,
                                            public,
                                            income
                                        )

                                        VALUES (
                                            (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}' OR match.id_team_visitor = '{}') LIMIT 1),
                                            '{}',
                                            50000,
                                            1000000
                                        );""".format(date.strftime("%m/%d/%Y"), visitor_id, visitor_id, championship))

        engine.execute("""INSERT INTO event (
                                            id_match,
                                            id_team,
                                            name_team,
                                            id_player,
                                            name_player,
                                            event_type
                                        )

                                        VALUES (
                                            (SELECT match.id FROM match WHERE (match.date = '{}') AND (match.id_team_host = '{}' OR match.id_team_visitor = '{}') LIMIT 1),
                                            '{}',
                                            'Palmeiras',
                                            (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Palmeiras' AND player.name = 'Rafael Navarro') LIMIT 1),
                                            'Rafael Navarro',
                                            'goal');""".format(date.strftime("%m/%d/%Y"), visitor_id, visitor_id, visitor_id))




    i += 7
    menu = ConsoleMenu(exit_option_text=False)
    function_item = FunctionItem("Voltar", main_menu, [choosen_team, i])
    menu.append_item(function_item)
    menu.show()



def init():
    print('Olá, seja bem-vind@ ao jogo Brasfoot!')
    coach_name = input('Escolha o seu nickname de treinador(a): ')

    print('Escolha um time para treinar: ')
    teams = pd.read_sql_query('SELECT name FROM team ORDER BY name ASC', con=engine)
    print(teams)
    n = int(input('Número do time: '))

    choosen_team = str(teams.iloc[n].values)[2:-2]
    print('\n Você escolheu o time: ', choosen_team)
    insert_coach(coach_name)

    team_id = str(pd.read_sql_query(
    """
        SELECT 
            * 
        FROM 
            team 
        WHERE 
            name = '{}'""".format(choosen_team), con=engine).reset_index(drop=True).id.values[0])

    return coach_name, choosen_team, team_id
if __name__ == '__main__':
    
    i = 0

    coach_name, choosen_team, team_id = init()
    
    trains(coach_name, choosen_team)
    
    create_rounds()

    main_menu(choosen_team, i)