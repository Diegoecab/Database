-- ------------------------------------------------------------------------------
-- File       : CursorInfoRAC.sql
-- Purpose    : Oracle RAC or cluster administration helper: CursorInfoRAC.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @CursorInfoRAC.sql
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
set lines 120
set pages 999

REM 
REM   Change 'having count(*) > 30'   can be changed
REM     as appropriate.  Larger values will result in
REM     in fewer matching rows

col statement format a60 word_wrapped heading "SQL"
col cursor_count format 999,999,999 head "Total Cnt"
col sid format 9999999 heading "ID"


SELECT O.SID SID, COUNT(*) CURSOR_COUNT, A.SQL_TEXT STATEMENT
    FROM gV$OPEN_CURSOR O, gV$SQLAREA A
      WHERE O.HASH_VALUE = A.HASH_VALUE
      AND O.ADDRESS = A.ADDRESS
      GROUP BY O.SID, A.SQL_TEXT
    HAVING COUNT(*) > 30
      ORDER BY CURSOR_COUNT DESC
/


