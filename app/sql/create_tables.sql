BEGIN TRANSACTION;

DROP TABLE IF EXISTS coach CASCADE; 
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS trains;
DROP TABLE IF EXISTS stadium;
DROP TABLE IF EXISTS player;

CREATE TABLE coach (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  name VARCHAR (100) UNIQUE NOT NULL,
  country nationality_type NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON coach
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE team (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  name VARCHAR (100) UNIQUE NOT NULL,
  state_br state_br_type NOT NULL,
  country nationality_type NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON team
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE trains (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  coach uuid NOT NULL, 
		CONSTRAINT coach_fk FOREIGN KEY (coach) REFERENCES coach(id) ON DELETE CASCADE,
  team uuid NOT NULL,
       CONSTRAINT team_fk FOREIGN KEY (team) REFERENCES team(id) ON DELETE CASCADE,
  initial_date DATE NOT NULL,
  final_date DATE,
  public_trust INTEGER NOT NULL,
			   CHECK (public_trust BETWEEN 0 AND 100),
  board_trust INTEGER NOT NULL,
	          CHECK (board_trust BETWEEN 0 AND 100),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON trains
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE stadium (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  team uuid NOT NULL,
       CONSTRAINT team_fk FOREIGN KEY (team) REFERENCES team(id) ON DELETE CASCADE,
  capacity INTEGER NOT NULL,
           CHECK (capacity BETWEEN 0 AND 100000),
  ticket_price NUMERIC,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON stadium
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE player (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  name VARCHAR (100) UNIQUE NOT NULL,
  team uuid NOT NULL,
      CONSTRAINT team_fk FOREIGN KEY (team) REFERENCES team(id) ON DELETE CASCADE,
  age INTEGER NOT NULL,
      CHECK (age BETWEEN 16 AND 48),
  position player_position_type NOT NULL,
  side player_side_type NOT NULL,
  strength INTEGER NOT NULL,
           CHECK (strength BETWEEN 0 AND 100),
  energy INTEGER NOT NULL,
         CHECK (energy BETWEEN 0 AND 100),
  salary NUMERIC NOT NULL,
         CHECK (salary > 0),
  contract_due_date DATE NOT NULL,
  market_value NUMERIC NOT NULL,
         CHECK (market_value > 0),
  feature1 player_feature_type NOT NULL,
  feature2 player_feature_type NOT NULL
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON player
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

COMMIT TRANSACTION;