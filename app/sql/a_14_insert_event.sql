BEGIN TRANSACTION;

INSERT INTO event (
    id_match,
    id_team,
    id_player,
    event_type
)

VALUES (
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Rafael Cabral') LIMIT 1),
    'y_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Cassio') LIMIT 1),
    'r_card'
);

COMMIT TRANSACTION;