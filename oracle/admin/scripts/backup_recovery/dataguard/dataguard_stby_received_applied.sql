-- ------------------------------------------------------------------------------
-- File       : dataguard_stby_received_applied.sql
-- Purpose    : Oracle Data Guard administration helper: dataguard stby received applied.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dataguard_stby_received_applied.sql
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
(SELECT THREAD# ,SEQUENCE# FROM GV$ARCHIVED_LOG WHERE SEQUENCE# is not null and (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM GV$ARCHIVED_LOG where SEQUENCE# is not null GROUP BY THREAD#)) ARCH,
(SELECT THREAD# ,SEQUENCE# FROM GV$LOG_HISTORY WHERE SEQUENCE# is not null and (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM GV$LOG_HISTORY where SEQUENCE# is not null GROUP BY THREAD#)) APPL
WHERE
ARCH.THREAD# = APPL.THREAD#;