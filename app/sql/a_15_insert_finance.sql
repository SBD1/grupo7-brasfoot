BEGIN TRANSACTION;

INSERT INTO finance (
    id_team,
    name_team,
    patrimony
)

VALUES (
    (SELECT team.id FROM team WHERE (team.name = 'Cruzeiro')),
    ('Cruzeiro'),
    250000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Corinthians')),
    ('Corinthians'),
    500000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Flamengo')),
    ('Flamengo'),
    120000000.00
);

COMMIT TRANSACTION;