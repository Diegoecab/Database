-- ------------------------------------------------------------------------------
-- File       : top_wait_events.sql
-- Purpose    : postgres diagnostics/sessions helper: top wait events.
-- Engine     : postgres
-- Category   : diagnostics/sessions
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: top_wait_events.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT state, wait_event, wait_event_type, COUNT(*)
FROM pg_stat_activity
GROUP BY 1, 2, 3
ORDER BY COUNT(*)
;
