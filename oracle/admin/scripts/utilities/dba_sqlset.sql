-- ------------------------------------------------------------------------------
-- File       : dba_sqlset.sql
-- Purpose    : oracle/admin utilities helper: dba sqlset.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: dba_sqlset.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--dba_sqlset.sql

set lines 300

col description for a30

select * from DBA_SQLSET order by created
/