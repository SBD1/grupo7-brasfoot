BEGIN TRANSACTION;

INSERT INTO match (
    id_championship,
    date,
    id_team_host,
    id_team_visitor,
    id_stadium
)

VALUES (
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE LIMIT 1),
    '01/01/2023',
    (SELECT id FROM team WHERE team.name = 'Cruzeiro' LIMIT 1),
    (SELECT id FROM team WHERE team.name = 'Corinthians' LIMIT 1),
    (SELECT stadium.id FROM stadium,team WHERE stadium.team = team.id AND team.name = 'Cruzeiro' LIMIT 1)
),
(
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE LIMIT 1),
    '02/02/2024',
    (SELECT id FROM public.team WHERE team.name = 'Flamengo' LIMIT 1),
    (SELECT id FROM public.team WHERE team.name = 'Corinthians' LIMIT 1),
    (SELECT stadium.id FROM stadium,team WHERE stadium.team = team.id AND team.name = 'Flamengo' LIMIT 1)
),
(
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE LIMIT 1),
    '03/03/2024',
    (SELECT id FROM public.team WHERE team.name = 'Corinthians' LIMIT 1),
    (SELECT id FROM public.team WHERE team.name = 'Flamengo' LIMIT 1),
    (SELECT stadium.id FROM stadium,team WHERE stadium.team = team.id AND team.name = 'Corinthians' LIMIT 1)
);

COMMIT TRANSACTION;