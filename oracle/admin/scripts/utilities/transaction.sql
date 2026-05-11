-- ------------------------------------------------------------------------------
-- File       : transaction.sql
-- Purpose    : Oracle administration helper: transaction.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @transaction.sql
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
SELECT COUNT(*)
       FROM gv$transaction t, gv$session s, gv$mystat m
      WHERE t.inst_id = s.inst_id AND  s.inst_id = m.inst_id
		AND t.ses_addr = s.saddr
        AND s.sid = m.sid;