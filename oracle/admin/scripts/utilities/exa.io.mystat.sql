-- ------------------------------------------------------------------------------
-- File       : exa.io.mystat.sql
-- Purpose    : Oracle administration helper: exa io mystat.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exa.io.mystat.sql
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
select s.name, m.value/1024/1024 MB from v$sysstat s, v$mystat m
where s.statistic# = m.statistic# and
(s.name like 'physical%total bytes' or s.name like 'cell phy%'
or s.name like 'cell IO%');