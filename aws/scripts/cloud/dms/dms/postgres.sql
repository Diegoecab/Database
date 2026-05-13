-- ------------------------------------------------------------------------------
-- File       : postgres.sql
-- Purpose    : aws cloud/dms helper: postgres.
-- Engine     : aws
-- Category   : cloud/dms
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: postgres.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--Verify tables
SELECT current_database();
SELECT                    
    table_schema || '.' || table_name
FROM
    information_schema.tables
WHERE
    table_type = 'BASE TABLE'
AND
    table_schema NOT IN ('pg_catalog', 'information_schema');

--Character set
SHOW SERVER_ENCODING;
SELECT datname ,pg_encoding_to_char(encoding) FROM pg_database;
--PG Settings
select name, setting, unit from pg_settings where name like '%repl%';
