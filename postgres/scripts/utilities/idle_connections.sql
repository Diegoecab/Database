-- ------------------------------------------------------------------------------
-- File       : idle_connections.sql
-- Purpose    : postgres utilities helper: idle connections.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: idle_connections.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--You can run the following query to list all connections in idle in transaction state and to order them by duration:


SELECT now() - state_change as idle_in_transaction_duration, now() - xact_start as xact_duration,* 
FROM  pg_stat_activity 
WHERE state  = 'idle in transaction'
AND   xact_start is not null
ORDER BY 1 DESC;
