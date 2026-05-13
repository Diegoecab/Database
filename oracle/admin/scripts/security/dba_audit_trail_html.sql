-- ------------------------------------------------------------------------------
-- File       : dba_audit_trail_html.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba audit trail html.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_audit_trail_html.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
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
col os_username for a20
col userhost for a20
col terminal for a10
col obj_name for a20
col new_name for a20
col comment_text for a20
col sql_bind for a20
col sql_text for a20
col extended_timestamp for a20
SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON
select * from dba_audit_trail order by timestamp
/
select * from dba_audit_session
/

SET MARKUP HTML OFF