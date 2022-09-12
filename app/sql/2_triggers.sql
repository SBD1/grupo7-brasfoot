BEGIN TRANSACTION;

-- Trigger for CREATED_AT and UPDATED_AT fields
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for update finance on new played match
CREATE OR REPLACE FUNCTION trigger_insert_on_played_match()
RETURNS trigger AS $$
BEGIN
  
  UPDATE finance
  SET patrimony = patrimony + NEW.income
  WHERE finance.id_team = (SELECT id_team_host FROM match WHERE match.id = NEW.id_match);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


COMMIT TRANSACTION;