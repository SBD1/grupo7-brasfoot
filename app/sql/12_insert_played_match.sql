BEGIN TRANSACTION;

INSERT INTO played_match (
    id_match,
    id_championship,
    public,
    income
)

VALUES (
    (SELECT id FROM public.match WHERE (match.date = '01/01/2023' & match.id_team_host = 'Cruzeiro'),
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE),
    50000,
    1000000
),
(
    (SELECT id FROM public.match WHERE (match.date = '02/02/2024' & match.id_team_host = 'Flamengo'),
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE),
    60000,
    2000000
),
(
    (SELECT id FROM public.match WHERE (match.date = '03/03/2024' & match.id_team_host = 'Corinthians'),
    (SELECT id FROM public.championship WHERE championship.is_cup = FALSE),
    70000,
    3000000
);

COMMIT TRANSACTION;