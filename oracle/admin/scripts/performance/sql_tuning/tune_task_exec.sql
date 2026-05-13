-- ------------------------------------------------------------------------------
-- File       : tune_task_exec.sql
-- Purpose    : Oracle SQL performance and tuning helper: tune task exec.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tune_task_exec.sql
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

declare
taskname varchar2(100):='&task';

begin
DBMS_SQLTUNE.execute_TUNING_TASK( task_name => taskname );
end;
/
