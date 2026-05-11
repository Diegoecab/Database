-- ------------------------------------------------------------------------------
-- File       : cron.sql
-- Purpose    : postgres maintenance helper: cron.
-- Engine     : postgres
-- Category   : maintenance
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: cron.sql
-- Parameters : Review script body before running.
-- Risk       : DESTRUCTIVE
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL_pg_cron.html
CREATE EXTENSION pg_cron;
select * from cron.job;
SELECT * FROM cron.job_run_details;
SELECT * FROM cron.job_run_details WHERE status = 'failed';

--Purging the pg_cron history table
SELECT cron.schedule('0 0 * * *', $$DELETE
    FROM cron.job_run_details
    WHERE end_time < now() - interval '7 days'$$);

SHOW cron.log_run;

--Scheduling a cron job for a database other than the default database
SELECT cron.schedule('database1 manual vacuum', '29 03 * * *', 'vacuum freeze test_table');
UPDATE cron.job SET database = 'database1' WHERE jobid = 106;
