BEGIN TRANSACTION;

-- Trigger for CREATED_AT and UPDATED_AT fields
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

COMMIT TRANSACTION;