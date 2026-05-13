-- ------------------------------------------------------------------------------
-- File       : dba_users_password_changed.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba users password changed.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_users_password_changed.sql
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
set lines 120 set pages 60
col name form a30
col Last_Changed form a12

 
SELECT name,ptime "Last_Changed"
FROM sys.user$ a, dba_users b
where a.name=b.username
and b.username like upper('%&username%')
and ptime > sysdate - &sysdate
order by 1;