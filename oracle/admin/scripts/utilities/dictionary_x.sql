-- ------------------------------------------------------------------------------
-- File       : dictionary_x.sql
-- Purpose    : Oracle administration helper: dictionary x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dictionary_x.sql
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
col event for a80
col wait_class for a30
set linesize 180
set verify off
accept TABLA prompt 'Ingrese %table_name%:  '
select table_name from dictionary where UPPER(table_name) like upper('%&TABLA%');