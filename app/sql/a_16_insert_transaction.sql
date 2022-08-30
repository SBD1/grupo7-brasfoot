BEGIN TRANSACTION;

INSERT INTO transaction (
    id_team_a,
    name_team_a,
    id_team_b,
    name_team_b,
    id_player,
    name_player,
    date,
    type,
    value
)

VALUES (
    (SELECT team.id FROM team WHERE (team.name = 'Cruzeiro')),
    ('Cruzeiro'),
    (SELECT team.id FROM team WHERE (team.name = 'Corinthians')),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Rafael Cabral')),
    ('Rafael Cabral'),
    '01/01/2022',
    'sell',
    1750000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Flamengo')),
    ('Flamengo'),
    (SELECT team.id FROM team WHERE (team.name = 'Corinthians')),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Cassio')),
    ('Cassio'),
    '01/01/2022',
    'buy',
    26500000.00
);

COMMIT TRANSACTION;