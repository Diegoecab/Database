-- ------------------------------------------------------------------------------
-- File       : dba_errors_x.sql
-- Purpose    : Oracle administration helper: dba errors x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_errors_x.sql
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
col owner for a20
col text for a20
set pages 1000
col object_name for a40 heading "Nombre|de|Objeto"
accept OBJ_NAME prompt 'Ingrese Nombre de objeto: '
select a.owner,a.type,a.sequence,a.line,a.position,a.text,a.message_number from dba_errors a
where a.name='&OBJ_NAME'
order by owner,type,a.name,message_number
/
