-- ------------------------------------------------------------------------------
-- File       : monitoring_indexes_x.sql
-- Purpose    : Oracle SQL performance and tuning helper: monitoring indexes x.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @monitoring_indexes_x.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--monitoring_indexes_x
set pages 1000
set lines 132
set trims on
set verify off
set feedback off
col owner for a20
accept OWNER prompt 'Ingrese OWNER: '
accept INDEX_NAME prompt 'Ingrese INDICE: '
select * from (
select 
   u.name as owner,
   io.name "index_name",
   t.name "table_name",
   decode(bitand(i.flags, 65536), 0, 'no', 'yes') as monitoring,
   decode(bitand(nvl(ou.flags,0), 1), 0, 'no', 'yes') as used,
   ou.start_monitoring "start_monitoring",
   ou.end_monitoring "end_monitoring"
from 
   sys.obj$ io, 
   sys.obj$ t, 
   sys.ind$ i, 
   sys.object_usage ou, sys.user$ u
where 
   t.obj#=i.bo#
and 
   io.owner#=u.user#
and 
   io.obj#=i.obj#
and 
   u.name not in ('SYS','SYSTEM')
and
  io.name=upper('&INDEX_NAME')
and 
   i.obj# =ou.obj#(+)
) where monitoring = 'yes' and owner=upper('&OWNER');

set feedback on
