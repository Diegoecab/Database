-- ------------------------------------------------------------------------------
-- File       : datafiles_io_gday.sql
-- Purpose    : Oracle administration helper: datafiles io gday.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @datafiles_io_gday.sql
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
--datafiles_io_gday.sql
break on trunc(begin_interval_time) skip 2

alter session set nls_date_format='dd/mm/yyyy';

column phyrds              format 999,999,999
column begin_interval_time format a25

select 
   trunc(begin_interval_time),
   filename,
   sum(phyrds), sum(phywrts)
from
   dba_hist_filestatxs 
natural join
   dba_hist_snapshot
group by trunc(begin_interval_time),filename
;