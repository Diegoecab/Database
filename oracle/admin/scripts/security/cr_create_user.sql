-- ------------------------------------------------------------------------------
-- File       : cr_create_user.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: cr create user.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cr_create_user.sql
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
CREATE USER "SCOTT" IDENTIFIED BY VALUES 'F894844C34402B67';
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP DEFAULT TABLESPACE USERS;
/

