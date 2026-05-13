-- ------------------------------------------------------------------------------
-- File       : dba_db_links.sql
-- Purpose    : Oracle administration helper: dba db links.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_db_links.sql
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
set linesize 180
set verify off
set head on
set pages 500
col db_link for a40
col host for a50
col username for a40
col owner for a30
select owner,db_link,username,host from dba_db_links
where owner like upper('%&owner%')
and db_link like upper('%&db_link%')
and username like upper('%&username%')
and host like upper('%&host%')
order by 1;