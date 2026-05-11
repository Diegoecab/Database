-- ------------------------------------------------------------------------------
-- File       : lockedobjects.sql
-- Purpose    : Oracle administration helper: lockedobjects.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @lockedobjects.sql
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

select s.sid,s.serial#,
       s.username,s.osuser,
       s.machine,
       ao.owner,ao.object_name
from   v$locked_object lo,dba_objects ao,v$session s
where  ao.object_id = lo.object_id
and    lo.session_id = s.sid