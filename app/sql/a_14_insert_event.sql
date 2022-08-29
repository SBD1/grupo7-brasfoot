BEGIN TRANSACTION;

INSERT INTO event (
    id_match,
    id_team,
    name_team,
    id_player,
    name_player,
    event_type
)

VALUES (
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    ('Cruzeiro'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Waguininho') LIMIT 1),
    ('Waguininho'),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_host = team.id  AND team.name = 'Cruzeiro') LIMIT 1),
    ('Cruzeiro'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Cruzeiro' AND player.name = 'Gabriel Dias') LIMIT 1),
    ('Gabriel Dias'),
    'y_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Cassio') LIMIT 1),
    ('Cassio'),
    'r_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    ('Willian'),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    ('Willian'),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Balbuena') LIMIT 1),
    ('Balbuena'),
    'disarm'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Adson') LIMIT 1),
    ('Adson'),
    'shot'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '01/01/2023' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Maycon') LIMIT 1),
    ('Maycon'),
    'disarm'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    ('Flamengo'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Flamengo' AND player.name = 'Everton') LIMIT 1),
    ('Everton'),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_host = team.id  AND team.name = 'Flamengo') LIMIT 1),
    ('Flamengo'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Flamengo' AND player.name = 'Gabriel Barbosa') LIMIT 1),
    ('Gabriel Barbosa'),
    'y_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Cassio') LIMIT 1),
    ('Cassio'),
    'r_card'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    ('Willian'),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Willian') LIMIT 1),
    ('Willian'),
    'goal'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Balbuena') LIMIT 1),
    ('Balbuena'),
    'disarm'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Adson') LIMIT 1),
    ('Adson'),
    'shot'
),
(
    (SELECT match.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    (SELECT team.id FROM match, team WHERE (match.date = '02/02/2024' AND match.id_team_visitor = team.id  AND team.name = 'Corinthians') LIMIT 1),
    ('Corinthians'),
    (SELECT player.id FROM player,team WHERE (player.team = team.id AND team.name = 'Corinthians' AND player.name = 'Maycon') LIMIT 1),
    ('Maycon'),
    'disarm'
);


COMMIT TRANSACTION;