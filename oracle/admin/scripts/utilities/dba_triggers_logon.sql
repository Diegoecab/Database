-- ------------------------------------------------------------------------------
-- File       : dba_triggers_logon.sql
-- Purpose    : Oracle administration helper: dba triggers logon.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_triggers_logon.sql
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
--@dba_triggers_logon
set verify off
set lines 600
set pages 2000
col column_name for a30 truncate
col table_owner for a20 truncate
col description for a50 truncate
col triggering_event for a20 truncate
col trigger_body for a180 truncate
col when_clause for a20 truncate
col ACTION_TYPE   for a20 truncate
col TRIGGER_TYPE  for a20 truncate
col OWNER for a20 truncate
col TRIGGER_NAME for a30 truncate

select owner,trigger_name,trigger_type,triggering_event,trigger_body,status,table_owner,
table_name,when_clause,action_type from dba_triggers 
where owner ='SYS' AND TRIGGERING_EVENT LIKE 'LOGON%'
order by 1,2,3
/
