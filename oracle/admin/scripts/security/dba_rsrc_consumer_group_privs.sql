-- ------------------------------------------------------------------------------
-- File       : dba_rsrc_consumer_group_privs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba rsrc consumer group privs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_rsrc_consumer_group_privs.sql
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
prompt
prompt Viewing Consumer Groups Granted to Users or Roles
prompt
col grantee for a30
col granted_group for a30

col grant_option for a30
col initial_group for a30

select * from dba_rsrc_consumer_group_privs;