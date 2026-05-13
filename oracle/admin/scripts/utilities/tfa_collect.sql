-- ------------------------------------------------------------------------------
-- File       : tfa_collect.sql
-- Purpose    : Oracle administration helper: tfa collect.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tfa_collect.sql
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
tfactl diagcollect -from "Sep/14/2021 03:30:00" -to "Sep/14/2021 03:50:00" -node local

Performance:
tfactl diagcollect -srdc dbperf -from "Sep/14/2021 03:30:00" -to "Sep/14/2021 03:50:00"