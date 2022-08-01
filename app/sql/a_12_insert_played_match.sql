BEGIN TRANSACTION;

INSERT INTO played_match (
    id_match,
    id_championship,
    public,
    income
)

VALUES (
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro')),
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE),
    50000,
    1000000
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo')),
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE),
    60000,
    2000000
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '03/03/2024' AND match.id_team_host = team.id  AND team.name = 'Corinthians')),
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE),
    70000,
    3000000
);

COMMIT TRANSACTION;