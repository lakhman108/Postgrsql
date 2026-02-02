-- 1. Transactions & ACID
-- a. Write a transaction that:
-- i. Inserts a new user
-- ii. Updates user status
-- iii. Commits only if both operations succeed

BEGIN;

INSERT INTO hc.users (first_name, last_name, email, password, is_active, birth_date, address, mobile_number, role_id)
VALUES ('ajay','rathod','ajay@gmail.com','ajay12',false,'2003-02-04','rajkot','7896321452','b5d7ab6b-8a96-42ac-bcfa-87554c771ad0');

UPDATE hc.users
SET is_active = true
WHERE email = 'ajay@gmail.com';

COMMIT;

-- b. Write a transaction that:
-- i. Inserts data into two tables

BEGIN;

INSERT INTO hc.users (first_name, last_name, email, password, birth_date, address, mobile_number, role_id)
VALUES ('dhruv','rathod','dhruv@gmail.com','dhruv123','2003-09-04','jamnagar','7896344452','b5d7ab6b-8a96-42ac-bcfa-87554c771ad0');

--4f60289c-81f9-48e2-8caf-3cd638935cf4
INSERT INTO hc.user_audit(user_id)
VALUES ('4f60289c-81f9-48e2-8caf-3cd638935cf4');

COMMIT;

-- c. Rolls back if any statement fails

BEGIN;

INSERT INTO hc.users (first_name, last_name, email, password, birth_date, address, mobile_number, role_id)
VALUES ('dhruv','rathod','dhruv@gmail.com','dhruv123','2003-09-04','jamnagar','7896344452','b5d7ab6b-8a96-42ac-bcfa-87554c771ad0');

ROLLBACK;



-- 2. Security Basics
-- a. Create database roles for:
-- i. db_admin

CREATE ROLE db_admin WITH CREATEDB CREATEROLE LOGIN PASSWORD 'admin';

-- ii. app_owner

CREATE ROLE app_owner WITH CREATEDB LOGIN PASSWORD 'owner';

-- iii. app_user

CREATE ROLE app_user WITH LOGIN PASSWORD 'user';

-- iv. app_readonly

CREATE ROLE app_readonly;


-- b. Grant appropriate privileges using: 
-- i. GRANT 
GRANT ALL PRIVILEGES ON DATABASE homecare_db TO db_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA hc TO app_owner;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA hc TO app_user;
GRANT SELECT ON ALL TABLES IN SCHEMA hc TO app_readonly;

-- c. Revoke privileges using: 
-- i. REVOKE
REVOKE DELETE ON ALL TABLES IN SCHEMA hc FROM app_user;

-- d. Demonstrate: 
-- i. Schema-level security 
GRANT USAGE ON SCHEMA hc TO app_user;
GRANT USAGE, CREATE ON SCHEMA hc TO app_owner;

-- ii. Table-level security 
GRANT SELECT, INSERT, UPDATE ON hc.users TO app_user;
GRANT SELECT ON hc.users TO app_readonly;
REVOKE UPDATE ON hc.users FROM app_user;

-- e. Revoke all default privileges from: 
-- i. PUBLIC role on database 
REVOKE ALL ON DATABASE homecare_db FROM PUBLIC;

-- ii. PUBLIC role on schema 
REVOKE ALL ON SCHEMA hc FROM PUBLIC;

 
-- f. Grant appropriate privileges on the schema to: 
-- i. app_user 
GRANT USAGE, CREATE ON SCHEMA hc TO app_user;

-- ii. app_readonly
GRANT USAGE ON SCHEMA hc TO app_readonly;


-- g. Table & Object Privileges 
-- i. Grant permissions to app_user to: 
-- 1. SELECT 
-- 2. INSERT 
-- 3. UPDATE 
-- 4. DELETE 
-- on all tables in schema hc. 

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA hc TO app_user; 

-- ii. Grant permissions to app_readonly to: 
-- 1. SELECT only 
-- on all tables in schema hc. 

GRANT SELECT ON ALL TABLES IN SCHEMA hc TO app_readonly;

-- iii. Prevent app_user from: 
-- 1. Dropping tables 
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA hc TO app_user;

-- 2. Truncating tables
REVOKE TRUNCATE ON ALL TABLES IN SCHEMA hc FROM app_user;



