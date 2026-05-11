-- ------------------------------------------------------------------------------
-- File       : list.sql
-- Purpose    : postgres utilities helper: list.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: list.sql
-- Parameters : Review script body before running.
-- Risk       : REVIEW
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--List of installed extensions
\dx
--List all databases
\l
--List database tables
\dt
-- List all schemas - 
\dn
--List users and their roles
\du
--List all functions
\df
--List all views
\dv