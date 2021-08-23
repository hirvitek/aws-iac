REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE postgres FROM PUBLIC;

-- Read/write role (You can create as many roles as you want)
CREATE ROLE readwrite;
GRANT CONNECT ON DATABASE postgres TO readwrite;
GRANT USAGE, CREATE ON SCHEMA public TO readwrite;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO readwrite;

-- Users creation (You can create multiple users with different permissions)
CREATE USER developer WITH LOGIN;

-- Grant privileges to users (Note the rds_iam role, that is needed for the IAM authentication)
GRANT rds_iam, readwrite TO developer;