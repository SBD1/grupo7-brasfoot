from sqlalchemy import create_engine
import pandas as pd


engine = create_engine("postgresql://brasfoot:brasfoot@localhost:5432/brasfoot")


def init():
    print('Olá, seja bem-vind@ ao jogo Brasfoot!')
    coach_name = input('Escolha o seu nickname de treinador(a): ')

    print('Escolha um time para treinar: ')
    teams = pd.read_sql_query('SELECT name FROM team ORDER BY name ASC', con=engine)
    print(teams)
    n = int(input('Número do time: '))

    choosen_team = str(teams.iloc[n].values)[2:-2]
    print('Você escolheu o time: ', choosen_team)
    insert_coach(coach_name)
    return coach_name, choosen_team


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


if __name__ == '__main__':
    coach_name, choosen_team = init()
    trains(coach_name, choosen_team)
