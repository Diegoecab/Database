-- ------------------------------------------------------------------------------
-- File       : get_view_text.sql
-- Purpose    : Oracle administration helper: get view text.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @get_view_text.sql
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
prompt 
prompt Las vistas se pueden generar con espacios o con campos cortados
prompt

accept spoolname   prompt "Enter spool: "
accept owner       prompt "Enter owner: "
accept viewname    prompt "Enter view name: "


SET HEAD OFF VERIFY OFF
set long 100000
set longc 100000
set linesize 1000
set trimS on
set tab off
spool &spoolname
select 'create view '||owner||'.'||view_name||' as ',text,';'  vtext
from   dba_views 
where  owner like upper('&owner')
and    view_name like upper('&viewname')
ORDER BY VIEW_NAME
/ 
spool off 