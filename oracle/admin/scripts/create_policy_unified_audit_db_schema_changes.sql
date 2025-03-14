--Audit data-management events
CREATE AUDIT POLICY AUDIT_DB_SCHEMA_CHANGES
PRIVILEGES
CREATE EXTERNAL JOB, CREATE JOB, CREATE ANY JOB
ACTIONS
CREATE PACKAGE, ALTER PACKAGE, DROP PACKAGE,
CREATE PACKAGE BODY, ALTER PACKAGE BODY, DROP PACKAGE BODY,
CREATE PROCEDURE, DROP PROCEDURE, ALTER PROCEDURE,
CREATE FUNCTION, DROP FUNCTION, ALTER FUNCTION,
CREATE TRIGGER, ALTER TRIGGER, DROP TRIGGER,
CREATE LIBRARY, ALTER LIBRARY, DROP LIBRARY,
CREATE SYNONYM, DROP SYNONYM, ALTER SYNONYM,
CREATE TABLE, ALTER TABLE, DROP TABLE, TRUNCATE TABLE,
CREATE DATABASE LINK, ALTER DATABASE LINK, DROP DATABASE LINK,
CREATE INDEX, ALTER INDEX, DROP INDEX,
CREATE INDEXTYPE, ALTER INDEXTYPE, DROP INDEXTYPE,
CREATE OUTLINE, ALTER OUTLINE, DROP OUTLINE,
CREATE CONTEXT, DROP CONTEXT,
CREATE ATTRIBUTE DIMENSION, ALTER ATTRIBUTE DIMENSION, DROP ATTRIBUTE DIMENSION,
CREATE DIMENSION, ALTER DIMENSION, DROP DIMENSION,
CREATE MINING MODEL, ALTER MINING MODEL, DROP MINING MODEL,
CREATE OPERATOR, ALTER OPERATOR, DROP OPERATOR,
CREATE JAVA, ALTER JAVA, DROP JAVA,
CREATE TYPE BODY, ALTER TYPE BODY, DROP TYPE BODY,
CREATE TYPE, ALTER TYPE, DROP TYPE,
CREATE VIEW, ALTER VIEW, DROP VIEW,
CREATE MATERIALIZED VIEW, ALTER MATERIALIZED VIEW, DROP MATERIALIZED VIEW,
CREATE MATERIALIZED VIEW LOG, ALTER MATERIALIZED VIEW LOG, DROP MATERIALIZED VIEW LOG,
CREATE MATERIALIZED ZONEMAP, ALTER MATERIALIZED ZONEMAP, DROP MATERIALIZED ZONEMAP,
CREATE ANALYTIC VIEW, ALTER ANALYTIC VIEW, DROP ANALYTIC VIEW,
CREATE SEQUENCE, ALTER SEQUENCE, DROP SEQUENCE,
CREATE CLUSTER, ALTER CLUSTER, DROP CLUSTER, TRUNCATE CLUSTER;
AUDIT POLICY AUDIT_DB_SCHEMA_CHANGES;

