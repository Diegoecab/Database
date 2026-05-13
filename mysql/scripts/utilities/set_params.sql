-- ------------------------------------------------------------------------------
-- File       : set_params.sql
-- Purpose    : mysql utilities helper: set params.
-- Engine     : mysql
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: set_params.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
max_connect_errors=10000
log_warnings = 2
max_connections = 950


select @@global.log_warnings
select @@global.max_connect_errors

set @@global.max_connections = 1500;