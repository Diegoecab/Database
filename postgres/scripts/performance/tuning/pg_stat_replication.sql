-- ------------------------------------------------------------------------------
-- File       : pg_stat_replication.sql
-- Purpose    : postgres performance/tuning helper: pg stat replication.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_stat_replication.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select * from pg_stat_replication;

-- To find the xmin of standby/replica servers:
	
SELECT application_name, client_addr, backend_xmin
FROM pg_stat_replication
ORDER BY age(backend_xmin) DESC;
