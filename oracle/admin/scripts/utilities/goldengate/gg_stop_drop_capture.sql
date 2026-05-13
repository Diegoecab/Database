-- ------------------------------------------------------------------------------
-- File       : gg_stop_drop_capture.sql
-- Purpose    : Oracle administration helper: gg stop drop capture.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @gg_stop_drop_capture.sql
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
set serveroutput on

begin
for r in (
 SELECT CAPTURE_NAME, QUEUE_NAME, RULE_SET_NAME, NEGATIVE_RULE_SET_NAME, STATUS 
   FROM DBA_CAPTURE) loop
dbms_output.put_line('dropping capture '||r.capture_name);
dbms_capture_adm.stop_capture(r.capture_name,true);
 DBMS_CAPTURE_ADM.DROP_CAPTURE(
    capture_name          => r.capture_name,
    drop_unused_rule_sets => true);
end loop;
end;
/