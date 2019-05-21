--dba_hist_snapshot_obj_usage.sql
col c1 heading 'Begin|Interval|time' format a20
col c2 heading 'Search Columns'      format 999
col c3 heading 'Invocation|Count'    format 99999999

set verify off
set lines 400

select
   to_char(sn.begin_interval_time,'dd/mm/yyyy hh24')||' Hs'  btime,
   p.sql_id,
   operation,
   time,
   p.search_columns,
   object_owner,
   object_type,
   object_name,
   count(*) cnt
from
   dba_hist_snapshot  sn,
   dba_hist_sql_plan   p,
   dba_hist_sqlstat   st
where st.sql_id = p.sql_id
and sn.snap_id = st.snap_id   
and trunc(begin_interval_time) > sysdate - &days
and p.sql_id like upper('%&sqlid%')
and object_owner like upper('%&object_owner%')
and object_type like upper('%&object_type%')
and operation like upper('%&operation%')
and upper(p.object_name) like upper('%&object_name%')
group by begin_interval_time, p.sql_id, operation, time, search_columns, object_owner, object_type, object_name
order by begin_interval_time
/