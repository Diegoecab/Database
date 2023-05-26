--dba_hist_tbspc_space_usage days
set lines 200
set pages 200
set verify off

col ts_gb for 99999999
col max_gb for 99999999
col used_gb for 99999999
col last_gb for 99999999
col incr for 99999999

prompt Min begin_interval_time
select min(begin_interval_time) from dba_hist_snapshot;

  select * from (
  select v.name
,        v.ts#
--,        s.instance_number
,        h.tablespace_size
       * p.value/1024/1024/1024              ts_gb
,        h.tablespace_maxsize
       * p.value/1024/1024/1024              max_gb
,        h.tablespace_usedsize
       * p.value/1024/1024/1024              used_gb
,        to_date(h.rtime, 'MM/DD/YYYY HH24:MI:SS') resize_time
,        lag(h.tablespace_usedsize * p.value/1024/1024/1024, 1, h.tablespace_usedsize * p.value/1024/1024/1024)
         over (partition by v.ts# order by h.snap_id) last_gb
,        (h.tablespace_usedsize * p.value/1024/1024/1024)
       - lag(h.tablespace_usedsize * p.value/1024/1024/1024, 1, h.tablespace_usedsize * p.value/1024/1024/1024)
         over (partition by v.ts# order by h.snap_id) incr
    from dba_hist_tbspc_space_usage     h
,        dba_hist_snapshot              s
,        v$tablespace                   v
,        dba_tablespaces                t
,        v$parameter                    p
   where h.tablespace_id                = v.ts#
     and v.name                         = t.tablespace_name
     and t.contents                not in ('UNDO', 'TEMPORARY')
     and p.name                         = 'db_block_size'
     and h.snap_id                      = s.snap_id
     and s.begin_interval_time          > sysdate - &1
order by v.name, h.snap_id asc)
   where incr > 1;