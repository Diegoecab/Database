-- ------------------------------------------------------------------------------
-- File       : diff_archivelogs_gap.sql
-- Purpose    : Oracle Data Guard administration helper: diff archivelogs gap.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @diff_archivelogs_gap.sql
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
SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last Sequence Received", APPL.SEQUENCE# "Last Sequence Applied", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference"
          FROM
         (SELECT THREAD# ,SEQUENCE# FROM GV$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM GV$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,
         (SELECT THREAD# ,SEQUENCE# FROM GV$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM GV$LOG_HISTORY GROUP BY THREAD#)) APPL
         WHERE
         ARCH.THREAD# = APPL.THREAD#
          ORDER BY 1;