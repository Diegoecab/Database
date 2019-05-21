select end_interval_time snap_time,
          round(sum(tablespace_size) * 8192 / 1024 / 1024 / 1024, 1) size_gb,
          round(sum(tablespace_maxsize) * 8192 / 1024 / 1024 / 1024, 1) maxsize_gb,
          round(sum(tablespace_usedsize) * 8192 / 1024 / 1024 / 1024, 1) usedsize_gb
from sys.dba_hist_tbspc_space_usage tsu,
       sys.dba_hist_snapshot s
where tsu.snap_id = s.snap_id
and s.snap_id in (select snap_id
	          from sys.dba_hist_snapshot
	          where to_char(end_interval_time, 'HH24') = '00')
group by end_interval_time
order by end_interval_time;