-- ------------------------------------------------------------------------------
-- File       : pg_stat_activity.sql
-- Purpose    : postgres diagnostics/sessions helper: pg stat activity.
-- Engine     : postgres
-- Category   : diagnostics/sessions
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_stat_activity.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select pid as process_id,
usename as username,
datname as database_name,
client_addr as client_address,
application_name,
backend_start,
state,
state_change,query
from pg_stat_activity;