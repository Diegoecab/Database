-- ------------------------------------------------------------------------------
-- File       : list_file_content.sql
-- Purpose    : AWS/RDS/DMS Oracle administration helper: list file content.
-- Category   : cloud/aws
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @list_file_content.sql
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
elect * from table
    (rdsadmin.rds_file_util.read_text_file(
		        p_directory => 'PRODUCT_DESCRIPTIONS',
			        p_filename  => 'test.txt'));

