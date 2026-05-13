-- ------------------------------------------------------------------------------
-- File       : create_user_external.sql
-- Purpose    : postgres security helper: create user external.
-- Engine     : postgres
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: create_user_external.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
create user "admin@corp.diegoec.com" with login;
grant rds_ad to "admin@corp.diegoec.com"; 
