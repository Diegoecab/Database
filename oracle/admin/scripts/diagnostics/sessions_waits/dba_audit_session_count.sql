-- ------------------------------------------------------------------------------
-- File       : dba_audit_session_count.sql
-- Purpose    : Oracle diagnostic query/report helper: dba audit session count.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_audit_session_count.sql
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
set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col os_username for a10
col usuario for a25
col userhost for a20
col terminal for a10
col obj_name for a20
col new_name for a20
col comment_text for a20
col sql_bind for a20
col sql_text for a20
col extended_timestamp for a20
select username usuario,to_char(trunc(timestamp),'DD/MM/YYYY') fecha, count(*) conexiones from dba_audit_session
where timestamp > sysdate-5
and ACTION_NAME='LOGON'
group by username,trunc(timestamp)
order by trunc(timestamp),3
/