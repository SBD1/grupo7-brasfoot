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
CREATE OR REPLACE PROCEDURE update_players_energy_after_match(match_date timestamptz)
LANGUAGE SQL
AS $$
    -- Discount player's energy
    UPDATE player
    SET energy = (player.energy - player.age)
    WHERE player.id IN (SELECT DISTINCT id_player
                        FROM lineup_match, match
                        WHERE match.id IN (SELECT id FROM match WHERE date = match_date))
    RETURNING *;
$$;


-- Update player's energy before a match
CREATE OR REPLACE PROCEDURE update_players_energy_before_match(match_date timestamptz)
LANGUAGE SQL
AS $$
    -- Increase player's energy before a match
    UPDATE player
    SET energy = (energy + (select avg(age) from player))
    WHERE player.id IN (SELECT DISTINCT lineup_match.id_player
                        FROM lineup_match, match, player
                        WHERE (player.energy - 100 + (select avg(age) from player) < 0) = True
                        AND player.id = lineup_match.id_player
                        AND (match.date = match_date)
                        AND (match.id IN (SELECT id FROM match WHERE date = match_date)))
    RETURNING *;
$$;

-- Init game inserting coach
CREATE OR REPLACE PROCEDURE insert_coach(
    name VARCHAR(200),
    country nationality_type)
LANGUAGE SQL
AS $$
    INSERT INTO coach(name, country) VALUES (name, country)
    ON CONFLICT ON CONSTRAINT constraint_name
    DO NOTHING;
$$;


-- Update coach's info
CREATE OR REPLACE PROCEDURE update_coach(
    name VARCHAR(200),
    country nationality_type)
LANGUAGE SQL
AS $$
    UPDATE coach
    SET name = name
    RETURNING *;
$$;


-- Insert the relation between coach and team (trains)
CREATE OR REPLACE PROCEDURE insert_trains(
    coach_name VARCHAR(200),
    name_team VARCHAR(200))
LANGUAGE SQL
AS $$
    INSERT INTO trains(coach, team, name_team)
    VALUES(
    (SELECT id FROM public.coach WHERE coach.name = coach_name),
	(SELECT id FROM public.team WHERE team.name = name_team),
    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = name_team))
    );
$$;


-- Function to execute the procedure create coach
CREATE OR REPLACE PROCEDURE create_coach(
    name VARCHAR(200),
    country nationality_type,
    name_team VARCHAR(200))
LANGUAGE SQL
AS $$
    CALL insert_coach(name, country);
    CALL insert_trains(name, name_team)
$$;

COMMIT TRANSACTION;