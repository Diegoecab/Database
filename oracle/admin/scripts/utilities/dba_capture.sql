-- ------------------------------------------------------------------------------
-- File       : dba_capture.sql
-- Purpose    : Oracle administration helper: dba capture.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_capture.sql
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
--dba_capture
COLUMN CONSUMER_NAME HEADING 'Capture|Process|Name' FORMAT A15
COLUMN NAME HEADING 'Archived Redo Log|File Name' FORMAT A25
COLUMN FIRST_SCN HEADING 'First SCN' FORMAT 9999999999999
COLUMN NEXT_SCN HEADING 'Next SCN' FORMAT 9999999999999
COLUMN SCN_TO_TIMESTAMP(APPLIED_SCN) FORMAT 9999999999999
COLUMN PURGEABLE HEADING 'Purgeable?' FORMAT A10
 
SELECT r.CONSUMER_NAME,
       r.NAME, 
       r.FIRST_SCN,
       r.NEXT_SCN,
       r.PURGEABLE 
  FROM DBA_REGISTERED_ARCHIVED_LOG r, DBA_CAPTURE c
  WHERE r.CONSUMER_NAME = c.CAPTURE_NAME;



SELECT CAPTURE_NAME, QUEUE_NAME, RULE_SET_NAME, NEGATIVE_RULE_SET_NAME, STATUS,APPLIED_SCN, SCN_TO_TIMESTAMP(APPLIED_SCN) 
   FROM DBA_CAPTURE;