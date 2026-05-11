-- ------------------------------------------------------------------------------
-- File       : dba_users_x.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba users x.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_users_x.sql
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
set verify off
accept usuario prompt 'Ingrese usuario:  '
col account_status for a20
col username for a15
col password for a20
col account_status for a16
col default_tablespace for a20
col profile for a15
set linesize 150
select username,password,account_status,lock_date,expiry_date,default_tablespace,created,profile from dba_users where username=upper('&usuario');
PROMPT
PROMPT Para ver la password en oracle 11g, consultar sys.user$
PROMPT