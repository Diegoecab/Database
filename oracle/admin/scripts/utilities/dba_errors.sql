-- ------------------------------------------------------------------------------
-- File       : dba_errors.sql
-- Purpose    : Oracle administration helper: dba errors.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_errors.sql
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
--DCabrera
--dba_errors
col owner for a20
col text for a100
set pages 1000
col object_name for a50
col name for a40
set verify off
set lines 400
--titulo owner
select owner,a.name,a.type,a.sequence,a.line,a.position,a.text from dba_errors a
where owner like upper('%&owner%')
and name like upper('%&name%')
and type like upper('%&type%')
and upper(text) like upper('%&text%')
order by owner,type,a.name,a.line,message_number
/
