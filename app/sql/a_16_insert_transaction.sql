BEGIN TRANSACTION;

INSERT INTO transaction (
    id_team_a,
    id_team_b,
    id_player,
    date,
    type,
    value
)

VALUES (
    (SELECT team.id FROM team WHERE (team.name = 'Cruzeiro')),
    (SELECT team.id FROM team WHERE (team.name = 'Corinthians')),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Rafael Cabral')),
    '01/01/2022',
    'sell',
    1750000.00
),
(
    (SELECT team.id FROM team WHERE (team.name = 'Flamengo')),
    (SELECT team.id FROM team WHERE (team.name = 'Corinthians')),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Cassio')),
    '01/01/2022',
    'buy',
    26500000.00
);

COMMIT TRANSACTION;