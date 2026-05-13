-- ------------------------------------------------------------------------------
-- File       : list_sessions_active.sql
-- Purpose    : postgres diagnostics/sessions helper: list sessions active.
-- Engine     : postgres
-- Category   : diagnostics/sessions
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: list_sessions_active.sql
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
       state_change,
       wait_event,
       wait_event_type,
       left(query, 100) 
     --  query
from pg_stat_activity where state='active' order by state_change;
