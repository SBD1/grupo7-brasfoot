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
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Waguininho') LIMIT 1),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Gabriel Dias') LIMIT 1),
    'y_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Cassio') LIMIT 1),
    'r_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Balbuena') LIMIT 1),
    'disarm'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Adson') LIMIT 1),
    'shot'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Maycon') LIMIT 1),
    'disarm'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Flamengo' AND player.name = 'Everton') LIMIT 1),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Flamengo' AND player.name = 'Gabriel') LIMIT 1),
    'y_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Cassio') LIMIT 1),
    'r_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Balbuena') LIMIT 1),
    'disarm'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Adson') LIMIT 1),
    'shot'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Maycon') LIMIT 1),
    'disarm'
);


COMMIT TRANSACTION;