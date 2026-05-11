-- ------------------------------------------------------------------------------
-- File       : tune_task_report.sql
-- Purpose    : Oracle SQL performance and tuning helper: tune task report.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tune_task_report.sql
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
set serveroutput on
set long 1000000000
col reco for a190
set lines 195
set pages 400

--define taskname='&task'

select DBMS_SQLTUNE.report_TUNING_TASK( '&taskname' ) as reco
from dual
/
