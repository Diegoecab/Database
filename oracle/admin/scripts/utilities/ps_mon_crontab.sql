-- ------------------------------------------------------------------------------
-- File       : ps_mon_crontab.sql
-- Purpose    : Oracle administration helper: ps mon crontab.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @ps_mon_crontab.sql
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
col description for a30
col command for a80
set lines 900
col weekday for a30
col monthday for a30
select * from ps_mon_crontab order by 1;