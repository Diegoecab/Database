-- ------------------------------------------------------------------------------
-- File       : trace_onlogon_trigger.sql
-- Purpose    : Oracle RAC or cluster administration helper: trace onlogon trigger.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @trace_onlogon_trigger.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
CREATE OR REPLACE TRIGGER S_PE_QAM_WSINT_DB_ONLOGON
AFTER LOGON ON DATABASE
DECLARE
v_cnt_os        NUMBER        := 0;
v_cnt_ip        NUMBER        := 0;
v_os_username   VARCHAR2 (30);
v_ipaddress     VARCHAR2 (30);

BEGIN
SELECT SYS_CONTEXT ('userenv', 'os_user')
INTO v_os_username
FROM DUAL;

SELECT SYS_CONTEXT ('userenv', 'ip_address')
INTO v_ipaddress
FROM DUAL;

    IF USER = 'S_PE_QAM_WSINT_DB' and v_os_username = 'S_PE_QAM_POSTPAGO'
  THEN

execute immediate 'ALTER SESSION SET tracefile_identifier = dcabrera';
--execute immediate 'alter session set events ''10046 trace name context forever, level 12''';
execute immediate 'ALTER SESSION SET sql_trace = true';
--   execute immediate 'alter session set max_dump_file_size=''UNLIMITED''';

  END IF;
EXCEPTION
WHEN OTHERS THEN
raise_application_error
(-20001,
'There was an error on onlogon trigger'
);
NULL;
END;
/