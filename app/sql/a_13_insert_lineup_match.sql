BEGIN TRANSACTION;

INSERT INTO lineup_match (
    id_match,
    id_team,
    id_player,
    is_starter,
    is_modified
)

VALUES (
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro')),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro')),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro')),
    True,
    True
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians')),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians')),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro')),
    False,
    True
);

COMMIT TRANSACTION;