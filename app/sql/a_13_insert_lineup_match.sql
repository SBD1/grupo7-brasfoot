BEGIN TRANSACTION;

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
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    ('Cruzeiro'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Rafael Cabral')),
    ('Rafael Cabral'),
    True,
    True
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro') LIMIT 1),
    ('Cassio'),
    False,
    True
);

COMMIT TRANSACTION;