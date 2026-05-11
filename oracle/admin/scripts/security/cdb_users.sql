-- ------------------------------------------------------------------------------
-- File       : cdb_users.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: cdb users(1).
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cdb_users(1).sql
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
--cdb_users
prompt All Users within CDB
set lines 900
col external_name for a30
col FAULT_COLLATION for a20
col username for a40
col password for a20
set pages 100
select USERNAME                ,USER_ID, PASSWORD             ,ACCOUNT_STATUS  , LOCK_DATE,EXPIRY_DATE,DEFAULT_TABLESPACE  from cdb_users;