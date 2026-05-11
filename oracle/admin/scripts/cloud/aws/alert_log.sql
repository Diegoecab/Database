-- ------------------------------------------------------------------------------
-- File       : alert_log.sql
-- Purpose    : AWS/RDS/DMS Oracle administration helper: alert log.
-- Category   : cloud/aws
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @alert_log.sql
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
select message_text from ALERTLOG where rownum<=10 order by indx;
SELECT text FROM table(rdsadmin.rds_file_util.read_text_file('BDUMP','alert_ORCL.log')) where rownum<=10;

