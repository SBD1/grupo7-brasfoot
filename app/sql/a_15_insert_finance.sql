BEGIN TRANSACTION;

INSERT INTO finance (
    id_team,
    patrimony
)

VALUES (
    (SELECT team.id FROM team WHERE (team.name = 'Cruzeiro')),
    250000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Corinthians')),
    500000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Flamengo')),
    120000000.00
);

COMMIT TRANSACTION;