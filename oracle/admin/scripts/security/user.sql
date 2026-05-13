-- ------------------------------------------------------------------------------
-- File       : user.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: user.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @user.sql
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
set linesize 180
col account_status forma a16
select username, account_status, profile,created, expiry_date 
from dba_users 
where username like UPPER('&1')
order by 1
/
