BEGIN TRANSACTION;

-- Procedure for PLAYERS TRANSACTIONS
-- Buy a player
CREATE OR REPLACE PROCEDURE buy_player(
    name_player VARCHAR(100),
    buyer_name_team VARCHAR(100),
    seller_name_team VARCHAR(100),
    value NUMERIC
    )
LANGUAGE SQL
AS $$
    -- Exec transaction to buyer team
    UPDATE player
    SET team = (SELECT id FROM team WHERE team.name = buyer_name_team), name_team = buyer_name_team
    WHERE player.id = (SELECT id FROM player WHERE player.name = name_player)
    RETURNING *;

    -- Update finance of buyer team
    UPDATE finance
    SET patrimony = (SELECT patrimony FROM finance WHERE finance.id_team = (SELECT id FROM team WHERE team.name = buyer_name_team)) - value
    WHERE finance.id_team = (SELECT id FROM team WHERE team.name = buyer_name_team)
    RETURNING *;

    -- Update finance of seller team
    UPDATE finance
    SET patrimony = (SELECT patrimony FROM finance WHERE finance.id_team = (SELECT id FROM team WHERE team.name = seller_name_team)) + value
    WHERE finance.id_team = (SELECT id FROM team WHERE team.name = seller_name_team)
    RETURNING *;

    -- Add transaction into transaction table
    INSERT INTO transaction(
    id_team_a,
    name_team_a,
    id_team_b,
    name_team_b,
    id_player,
    name_player,
    date,
    type,
    value) VALUES (
    (SELECT team.id FROM team WHERE (team.name = buyer_name_team)),
    buyer_name_team,
    (SELECT team.id FROM team WHERE (team.name = seller_name_team)),
    seller_name_team,
    (SELECT player.id FROM player WHERE (player.name = name_player)),
    name_player,
    now(),
    'buy',
    value
    )
$$;

-- Sell a player
CREATE OR REPLACE PROCEDURE sell_player(
    name_player VARCHAR(100),
    seller_name_team VARCHAR(100),
    buyer_name_team VARCHAR(100),
    value NUMERIC
    )
LANGUAGE SQL
AS $$
    -- Exec transaction to buyer team
    UPDATE player
    SET team = (SELECT id FROM team WHERE team.name = buyer_name_team), name_team = buyer_name_team
    WHERE player.id = (SELECT id FROM player WHERE player.name = name_player)
    RETURNING *;

    -- Update finance of buyer team
    UPDATE finance
    SET patrimony = (SELECT patrimony FROM finance WHERE finance.id_team = (SELECT id FROM team WHERE team.name = buyer_name_team)) - value
    WHERE finance.id_team = (SELECT id FROM team WHERE team.name = buyer_name_team)
    RETURNING *;

    -- Update finance of seller team
    UPDATE finance
    SET patrimony = (SELECT patrimony FROM finance WHERE finance.id_team = (SELECT id FROM team WHERE team.name = seller_name_team)) + value
    WHERE finance.id_team = (SELECT id FROM team WHERE team.name = seller_name_team)
    RETURNING *;

    -- Add transaction into transaction table
    INSERT INTO transaction(
    id_team_a,
    name_team_a,
    id_team_b,
    name_team_b,
    id_player,
    name_player,
    date,
    type,
    value) VALUES (
    (SELECT team.id FROM team WHERE (team.name = seller_name_team)),
    seller_name_team,
    (SELECT team.id FROM team WHERE (team.name = buyer_name_team)),
    buyer_name_team,
    (SELECT player.id FROM player WHERE (player.name = name_player)),
    name_player,
    now(),
    'sell',
    value
    )
$$;

-- Update player's energy after a played match
CREATE OR REPLACE PROCEDURE update_players_energy_after_match()
LANGUAGE SQL
AS $$
    -- Discount player's energy
    UPDATE player
    SET energy = (player.energy - player.age)
    RETURNING *;
$$;

-- Update player's energy before a match
CREATE OR REPLACE PROCEDURE update_players_energy_before_match()
LANGUAGE SQL
AS $$
    -- Increase player's energy before a match
    UPDATE player
    SET energy = (energy + (select avg(age) from player))
    RETURNING *;
$$;



COMMIT TRANSACTION;