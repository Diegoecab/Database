-- ------------------------------------------------------------------------------
-- File       : dba_indexes_owner.sql
-- Purpose    : Oracle administration helper: dba indexes owner (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_indexes_owner (1).sql
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
set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
accept Owner prompt 'Ingrese Owner: '

select TABLESPACE_NAME, INDEX_NAME from dba_indexes where owner= upper('&OWNER') order by 1,2;
