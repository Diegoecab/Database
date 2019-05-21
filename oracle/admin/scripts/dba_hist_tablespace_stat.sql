--dba_hist_tablespace_stat

col begin_interval_time for a30
set verify off
set feed off
set head on
set lines 400

column  instance_number  new_value m_instance  noprint
column  dbid             new_value m_dbid      noprint

select
        ins.instance_number,
        db.dbid
from
        v$instance        ins,
        v$database        db
;

select a.snap_id,b.begin_interval_time,tsname,status,is_backup
from dba_hist_tablespace_stat a, dba_hist_snapshot b
where 	a.snap_id=b.snap_id
and 	b.dbid = &m_dbid
and     b.instance_number = &m_instance
and		b.dbid = a.dbid
and		b.instance_number = a.instance_number
and begin_interval_time > sysdate - nvl('&days',10000)
--group by snap_id
and upper(status) like upper('%&status%')
order by a.snap_id
/