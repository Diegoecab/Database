-- ------------------------------------------------------------------------------
-- File       : rollback_usage_TOAD.sql
-- Purpose    : Oracle administration helper: rollback usage TOAD.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rollback_usage_TOAD.sql
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
/* Formatted on 2005/07/28 09:15 (Formatter Plus v4.5.2) */
SELECT   r.NAME, -- rbs name
                s.sid, s.serial#, s.username, s.machine, t.status, t.cr_get, -- consistent gets
         t.phy_io, -- physical IO
                  t.used_ublk, -- Undo blocks used
                              t.noundo, --   Is a noundo transaction
                                       SUBSTR (s.program, 1, 78) "COMMAND",
         s.username "DB User", t.start_time, s.sql_address "Address",
         s.sql_hash_value "Sql Hash"
    FROM sys.v_$session s, sys.v_$transaction t, sys.v_$rollname r
   WHERE t.addr = s.taddr AND t.xidusn = r.usn
ORDER BY t.start_time;