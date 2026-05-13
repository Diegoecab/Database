-- ------------------------------------------------------------------------------
-- File       : crecimiento.sql
-- Purpose    : Oracle administration helper: crecimiento.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @crecimiento.sql
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
SET SERVEROUTPUT ON
accept 1 prompt 'Enter Tablespace: '
accept 2 prompt 'Enter AVG Row Len: '
accept 3 prompt 'Enter Num Rows: '
accept 4 prompt 'Enter PCTFREE: '
DECLARE
used_bytes NUMBER;
alloc_bytes NUMBER;
BEGIN
 SYS.DBMS_SPACE.create_table_cost ( upper('&1'),&2,&3,&4,used_bytes,alloc_bytes);
  DBMS_OUTPUT.PUT_LINE('used_bytes: '||used_bytes);
  DBMS_OUTPUT.PUT_LINE('alloc_bytes: '||alloc_bytes);
END;
/