-- ------------------------------------------------------------------------------
-- File       : dba_hist_parameter.sql
-- Purpose    : Oracle administration helper: dba hist parameter.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_parameter.sql
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
set linesize 155
col time for a15
col parameter_name format a50
col old_value format a30
col new_value format a30
break on instance skip 3
select instance_number instance, snap_id, time, parameter_name, old_value, new_value from (
select a.snap_id,to_char(end_interval_time,'DD-MON-YY HH24:MI') TIME, a.instance_number, parameter_name, value new_value,
lag(parameter_name,1) over (partition by parameter_name, a.instance_number order by a.snap_id) old_pname,
lag(value,1) over (partition by parameter_name, a.instance_number order by a.snap_id) old_value ,
decode(substr(parameter_name,1,2),'__',2,1) calc_flag
from dba_hist_parameter a, dba_Hist_snapshot b , v$instance v
where 
end_interval_time > trunc(sysdate-&days) and
a.snap_id=b.snap_id
and a.instance_number=b.instance_number
and parameter_name like nvl('&parameter_name',parameter_name)
and a.instance_number like nvl('&instance_number',v.instance_number)
)
where
new_value != old_value
order by 1,2;