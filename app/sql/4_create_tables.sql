BEGIN TRANSACTION;

-- Exclui tabelas se existirem
DROP TABLE IF EXISTS coach CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS trains;
DROP TABLE IF EXISTS stadium;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS championship;
DROP TABLE IF EXISTS match;
DROP TABLE IF EXISTS played_match;



-- Criação tabela e trigger COACH
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


-- Criação tabela e trigger TEAM
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


-- Criação tabela e trigger TRAINS
CREATE TABLE trains (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  coach uuid NOT NULL, CONSTRAINT coach_fk FOREIGN KEY (coach) REFERENCES coach(id) ON DELETE CASCADE,
  team uuid NOT NULL, CONSTRAINT team_fk FOREIGN KEY (team) REFERENCES team(id) ON DELETE CASCADE,
  name_team VARCHAR (100) NOT NULL, CONSTRAINT name_team_fk FOREIGN KEY (name_team) REFERENCES team(name) ON DELETE CASCADE,
  initial_date DATE NOT NULL DEFAULT NOW(),
  final_date DATE,
  public_trust INTEGER NOT NULL, CHECK (public_trust BETWEEN 0 AND 100),
  board_trust INTEGER NOT NULL, CHECK (board_trust BETWEEN 0 AND 100),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON trains
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger STADIUM
CREATE TABLE stadium (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  team uuid NOT NULL, CONSTRAINT team_fk FOREIGN KEY (team) REFERENCES team(id) ON DELETE CASCADE,
  name_team VARCHAR (100) NOT NULL, CONSTRAINT name_team_fk FOREIGN KEY (name_team) REFERENCES team(name) ON DELETE CASCADE,
  capacity INTEGER NOT NULL, CHECK (capacity BETWEEN 0 AND 100000),
  ticket_price NUMERIC,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON stadium
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger PLAYER
CREATE TABLE player (
  id uuid DEFAULT gen_random_uuid () PRIMARY KEY,
  name VARCHAR (100) UNIQUE NOT NULL,
  team uuid NOT NULL, CONSTRAINT team_fk FOREIGN KEY (team) REFERENCES team(id) ON DELETE CASCADE,
  name_team VARCHAR (100) NOT NULL, CONSTRAINT name_team_fk FOREIGN KEY (name_team) REFERENCES team(name) ON DELETE CASCADE,
  age INTEGER NOT NULL, CHECK (age BETWEEN 16 AND 48),
  position player_position_type NOT NULL,
  side player_side_type NOT NULL,
  strength INTEGER NOT NULL, CHECK (strength BETWEEN 0 AND 100),
  energy INTEGER NOT NULL, CHECK (energy BETWEEN 0 AND 100),
  salary NUMERIC NOT NULL, CHECK (salary > 0),
  contract_due_date DATE NOT NULL,
  market_value NUMERIC NOT NULL, CHECK (market_value > 0),
  feature1 player_feature_type NOT NULL,
  feature2 player_feature_type NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON player
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger CHAMPIONSHIP
CREATE TABLE championship (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    is_cup BOOLEAN NOT NULL,
    champion uuid, CONSTRAINT champion_fk FOREIGN KEY (champion) REFERENCES team(id) ON DELETE CASCADE,
    vice uuid, CONSTRAINT vice_fk FOREIGN KEY (vice) REFERENCES team(id) ON DELETE CASCADE,
    best_scorer uuid, CONSTRAINT best_scorer_fk FOREIGN KEY (best_scorer) REFERENCES player(id) ON DELETE CASCADE,
    best_grade uuid, CONSTRAINT best_grade_fk FOREIGN KEY (best_grade) REFERENCES player(id) ON DELETE CASCADE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON championship
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger MATCH
CREATE TABLE match (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    id_championship uuid NOT NULL, CONSTRAINT championship_fk FOREIGN KEY (id_championship) REFERENCES championship(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    id_team_host uuid NOT NULL, CONSTRAINT id_team_host_fk FOREIGN KEY (id_team_host) REFERENCES team(id) ON DELETE CASCADE,
    name_team_host VARCHAR (100) NOT NULL, CONSTRAINT name_team_host_fk FOREIGN KEY (name_team_host) REFERENCES team(name) ON DELETE CASCADE,
    id_team_visitor uuid NOT NULL, CONSTRAINT id_team_visitor_fk FOREIGN KEY (id_team_visitor) REFERENCES team(id) ON DELETE CASCADE,
    name_team_visitor VARCHAR (100) NOT NULL, CONSTRAINT name_team_visitor_fk FOREIGN KEY (name_team_visitor) REFERENCES team(name) ON DELETE CASCADE,
    id_stadium uuid NOT NULL, CONSTRAINT id_stadium_fk FOREIGN KEY (id_stadium) REFERENCES stadium(id) ON DELETE CASCADE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON match
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger PLAYED_MATCH
CREATE TABLE played_match (
    id_match uuid NOT NULL, CONSTRAINT id_match_fk FOREIGN KEY (id_match) REFERENCES match(id) ON DELETE CASCADE,
    id_championship uuid NOT NULL, CONSTRAINT championship_fk FOREIGN KEY (id_championship) REFERENCES championship(id) ON DELETE CASCADE,
    public INT NOT NULL, CHECK ( public > 0 ),
    income NUMERIC NOT NULL, CHECK (income > 0)
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON played_match
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger LINEUP_MATCH
CREATE TABLE lineup_match (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    id_match uuid NOT NULL, CONSTRAINT id_match_fk FOREIGN KEY (id_match) REFERENCES match(id) ON DELETE CASCADE,
    id_team uuid NOT NULL, CONSTRAINT team_fk FOREIGN KEY (id_team) REFERENCES team(id) ON DELETE CASCADE,
    name_team VARCHAR (100) NOT NULL, CONSTRAINT name_team_fk FOREIGN KEY (name_team) REFERENCES team(name) ON DELETE CASCADE,
    id_player uuid NOT NULL, CONSTRAINT player_fk FOREIGN KEY (id_player) REFERENCES player(id) ON DELETE CASCADE,
    name_player VARCHAR (100) NOT NULL, CONSTRAINT name_player_fk FOREIGN KEY (name_player) REFERENCES player(name) ON DELETE CASCADE,
    is_starter BOOLEAN NOT NULL,
    is_modified BOOLEAN NOT NULL
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON lineup_match
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger EVENT
CREATE TABLE event (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    id_match uuid NOT NULL, CONSTRAINT id_match_fk FOREIGN KEY (id_match) REFERENCES match(id) ON DELETE CASCADE,
    id_team uuid NOT NULL, CONSTRAINT team_fk FOREIGN KEY (id_team) REFERENCES team(id) ON DELETE CASCADE,
    name_team VARCHAR (100) NOT NULL, CONSTRAINT name_team_fk FOREIGN KEY (name_team) REFERENCES team(name) ON DELETE CASCADE,
    id_player uuid NOT NULL, CONSTRAINT player_fk FOREIGN KEY (id_player) REFERENCES player(id) ON DELETE CASCADE,
    name_player VARCHAR (100) NOT NULL, CONSTRAINT name_player_fk FOREIGN KEY (name_player) REFERENCES player(name) ON DELETE CASCADE,
    event_type match_event_type NOT NULL
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON event
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger FINANCE
CREATE TABLE finance (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    id_team uuid NOT NULL, CONSTRAINT team_fk FOREIGN KEY (id_team) REFERENCES team(id) ON DELETE CASCADE,
    name_team VARCHAR (100) NOT NULL, CONSTRAINT name_team_fk FOREIGN KEY (name_team) REFERENCES team(name) ON DELETE CASCADE,
    patrimony NUMERIC,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON finance
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


-- Criação tabela e trigger TRANSACTION
CREATE TABLE transaction (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    id_team_a uuid NOT NULL, CONSTRAINT id_team_a_fk FOREIGN KEY (id_team_a) REFERENCES team(id) ON DELETE CASCADE,
    name_team_a VARCHAR (100) NOT NULL, CONSTRAINT name_team_a_fk FOREIGN KEY (name_team_a) REFERENCES team(name) ON DELETE CASCADE,
    id_team_b uuid NOT NULL, CONSTRAINT id_team_b_fk FOREIGN KEY (id_team_b) REFERENCES team(id) ON DELETE CASCADE,
    name_team_b VARCHAR (100) NOT NULL, CONSTRAINT name_team_b_fk FOREIGN KEY (name_team_b) REFERENCES team(name) ON DELETE CASCADE,
    id_player uuid NOT NULL, CONSTRAINT player_fk FOREIGN KEY (id_player) REFERENCES player(id) ON DELETE CASCADE,
    name_player VARCHAR (100) NOT NULL, CONSTRAINT name_player_fk FOREIGN KEY (name_player) REFERENCES player(name) ON DELETE CASCADE,
    date DATE NOT NULL,
    type transaction_type NOT NULL,
    value NUMERIC NOT NULL
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON transaction
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

COMMIT TRANSACTION;
