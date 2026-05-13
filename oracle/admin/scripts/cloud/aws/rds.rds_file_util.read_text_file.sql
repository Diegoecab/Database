-- ------------------------------------------------------------------------------
-- File       : rds.rds_file_util.read_text_file.sql
-- Purpose    : AWS/RDS/DMS Oracle administration helper: rds rds file util read text file.
-- Category   : cloud/aws
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rds.rds_file_util.read_text_file.sql
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

SELECT * FROM TABLE
    (rdsadmin.rds_file_util.read_text_file(
        p_directory => 'DATA_PUMP_DIR',
        p_filename  => 'prebkp_expdp_supplier_hub.log'));
		


SELECT * FROM TABLE(rdsadmin.rds_file_util.listdir(p_directory => 'DATA_PUMP_DIR'));


