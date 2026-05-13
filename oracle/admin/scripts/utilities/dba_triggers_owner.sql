-- ------------------------------------------------------------------------------
-- File       : dba_triggers_owner.sql
-- Purpose    : Oracle administration helper: dba triggers owner (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_triggers_owner (1).sql
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
set verify off
set linesize 180
set pagesize 2000
col column_name for a20
col table_owner for a10
col description for a20
col triggering_event for a15
col trigger_body for a20
col when_clause for a20
accept OWNER prompt 'Ingrese OWNER: '

select trigger_name,trigger_type,triggering_event,trigger_body,status,table_owner,
table_name,when_clause,action_type from dba_triggers where owner = upper('&OWNER')

/
