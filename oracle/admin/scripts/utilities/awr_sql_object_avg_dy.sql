-- ------------------------------------------------------------------------------
-- File       : awr_sql_object_avg_dy.sql
-- Purpose    : Oracle administration helper: awr sql object avg dy.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @awr_sql_object_avg_dy.sql
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

col c1 heading 'Object|Name'        format a30
col c2 heading 'Week Day'           format a15
col c3 heading 'Invocation|Count'   format 99,999,999

break on c1 skip 2
break on c2 skip 2

select
  decode(c2,1,'Monday',2,'Tuesday',3,'Wednesday',4,'Thursday',5,'Friday',6,'Saturday',7,'Sunday') c2,
  c1,
  c3
from
(  
select
   p.object_name                       c1,
   to_char(sn.end_interval_time,'d')   c2,
   count(1)                            c3
from
  dba_hist_sql_plan   p,
  dba_hist_sqlstat    s,
  dba_hist_snapshot  sn
where
  p.object_owner <> 'SYS'  
and
  p.sql_id = s.sql_id
and
  s.snap_id = sn.snap_id    
group by
   p.object_name, 
   to_char(sn.end_interval_time,'d')
order by
  c2,c1
)
;





