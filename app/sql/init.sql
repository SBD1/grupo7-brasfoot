REVOKE ALL PRIVILEGES ON SCHEMA public FROM brasfoot;
ALTER USER brasfoot WITH NOSUPERUSER;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO brasfoot;