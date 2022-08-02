-- UPDATE PLAYER
WITH id_player AS (SELECT transaction.id_player FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell'),

buyer AS
(SELECT transaction.id_team_b FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell')

UPDATE player
SET team = (SELECT id_team_b from buyer)
WHERE player.id = (SELECT id_player FROM id_player)
RETURNING *;

WITH id_player AS (SELECT transaction.id_player FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell'),

-- UPDATE BUYER PATRIMONY
buyer AS
(SELECT transaction.id_team_b FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell'),

buyer_patrimony AS
(SELECT finance.patrimony FROM finance WHERE finance.id_team = (SELECT id_team_b from buyer)),

transaction_value AS
(SELECT transaction.value FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell')

UPDATE finance
SET patrimony = ((SELECT * FROM buyer_patrimony) - (SELECT * from transaction_value))
WHERE finance.id_team = (SELECT id_team_b from buyer)
RETURNING *;

-- UPDATE SELLER PATRIMONY
WITH id_player AS (SELECT transaction.id_player FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell'),

seller AS
(SELECT transaction.id_team_a FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell' ),

seller_patrimony AS
(SELECT finance.patrimony FROM finance WHERE finance.id_team = (SELECT id_team_a from seller)),

transaction_value AS
(SELECT transaction.value FROM transaction, team
WHERE transaction.id_team_b = team.id AND team.name = 'Corinthians' AND transaction.date = '2022-01-01' AND transaction.type = 'sell')

UPDATE finance
SET patrimony = ((SELECT * FROM seller_patrimony) + (SELECT * from transaction_value))
WHERE finance.id_team = (SELECT id_team_a from seller)
RETURNING *;