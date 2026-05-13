-- ------------------------------------------------------------------------------
-- File       : olocks.sql
-- Purpose    : Oracle administration helper: olocks.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @olocks.sql
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
set pagesize 500
set linesize 120
column A.OWNER format a16
column A.OBJECT_NAME format a16


SELECT
A.OWNER,
A.OBJECT_NAME,
A.OBJECT_TYPE,
C.SID,
C.SERIAL#,
C.USERNAME
FROM DBA_OBJECTS A,
V$LOCKED_OBJECT B
,V$SESSION C
WHERE A.OBJECT_ID = B.OBJECT_ID
AND B.SESSION_ID  = C.SID
/
