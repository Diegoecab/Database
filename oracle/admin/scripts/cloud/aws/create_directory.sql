-- ------------------------------------------------------------------------------
-- File       : create_directory.sql
-- Purpose    : AWS/RDS/DMS Oracle administration helper: create directory.
-- Category   : cloud/aws
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_directory.sql
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
exec rdsadmin.rdsadmin_util.create_directory(p_directory_name=> 'product_descriptions');
select directory_path from dba_directories where directory_name='PRODUCT_DESCRIPTIONS';     

