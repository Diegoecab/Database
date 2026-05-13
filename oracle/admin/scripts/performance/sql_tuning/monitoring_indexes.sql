-- ------------------------------------------------------------------------------
-- File       : monitoring_indexes.sql
-- Purpose    : Oracle SQL performance and tuning helper: monitoring indexes.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @monitoring_indexes.sql
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
col "table_name" for a30
col "index_name" for a30
col "owner" for a30
set lines 900
set pages 100

select * from (
select 
   u.name "owner",
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
   i.obj# =ou.obj#(+)
) where monitoring = 'yes' order by "table_name";