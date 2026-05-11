-- ------------------------------------------------------------------------------
-- File       : prompt.sql
-- Purpose    : Oracle administration helper: prompt.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @prompt.sql
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
--alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
SET sqlprompt '&_date | &_user@&_connect_identifier > '
ttitle off
--clear screen
set heading on
set linesize 150
set underline =
set lines 300
set pages 1000