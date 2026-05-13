-- ------------------------------------------------------------------------------
-- File       : dba_procedures.sql
-- Purpose    : Oracle administration helper: dba procedures.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_procedures.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
col owner for a40 truncate
col object_name for a40 truncate
col procedure_name for a40 truncate
select owner, object_id, subprogram_id, object_name, procedure_name from dba_procedures where object_name like upper('%&object_name%') and PROCEDURE_NAME like upper('%&procedure_name%') and object_id like '%&object_id%' and subprogram_id like '%&subprogram_id%';