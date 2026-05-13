-- ------------------------------------------------------------------------------
-- File       : dba_advisor_actions.sql
-- Purpose    : Oracle administration helper: dba advisor actions.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_advisor_actions.sql
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
--dba_advisor_actions.sql

col status_message for a50
col error_message for a50
col attr1 for a100
col attr2 for a100
col message for a50

set lines 800
set verify off

select * from dba_advisor_actions
where owner like upper('%&owner%')
and task_id = &task_id
and upper(task_name) like upper('%&task_name%')
 order by task_id
/