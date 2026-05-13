-- ------------------------------------------------------------------------------
-- File       : Lockeos10G.sql
-- Purpose    : Oracle administration helper: Lockeos10G.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Lockeos10G.sql
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
SELECT DISTINCT A.SID "waiting sid", D.SQL_TEXT "waiting SQL",
                A.ROW_WAIT_OBJ# "locked object",
                A.BLOCKING_SESSION "blocking sid",
                C.SQL_TEXT "SQL from blocking session"
           FROM V$SESSION A, V$ACTIVE_SESSION_HISTORY B, V$SQL C, V$SQL D
          WHERE A.EVENT = 'enq: TX - row lock contention'
            AND A.SQL_ID = D.SQL_ID
            AND A.BLOCKING_SESSION = B.SESSION_ID
            AND C.SQL_ID = B.SQL_ID
            AND B.CURRENT_OBJ# = A.ROW_WAIT_OBJ#
            AND B.CURRENT_FILE# = A.ROW_WAIT_FILE#
            AND B.CURRENT_BLOCK# = A.ROW_WAIT_BLOCK#