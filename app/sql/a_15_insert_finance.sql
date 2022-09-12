BEGIN TRANSACTION;

INSERT INTO finance (
    id_team,
    name_team,
    patrimony
)

VALUES (
    (SELECT team.id FROM team WHERE (team.name = 'Cruzeiro')),
    ('Cruzeiro'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Corinthians')),
    ('Corinthians'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Flamengo')),
    ('Flamengo'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'AthleticoPR')),
    ('AthleticoPR'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'AtleticoMG')),
    ('AtleticoMG'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Bragantino')),
    ('Bragantino'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Fluminense')),
    ('Fluminense'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Internacional')),
    ('Internacional'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Palmeiras')),
    ('Palmeiras'),
    1000000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'SaoPaulo')),
    ('SaoPaulo'),
    1000000.00
);

COMMIT TRANSACTION;