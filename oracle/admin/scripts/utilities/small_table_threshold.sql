-- ------------------------------------------------------------------------------
-- File       : small_table_threshold.sql
-- Purpose    : Oracle administration helper: small table threshold.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @small_table_threshold.sql
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
--small_table_threshold.sql
select nam.ksppinm NAME,val.KSPPSTVL VALUE from x$ksppi nam, x$ksppsv val where nam.indx = val.indx and nam.ksppinm = '_small_table_threshold';

alter session set "_small_table_threshold"=500000;