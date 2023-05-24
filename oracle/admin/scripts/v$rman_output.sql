--v$rman_output 600
select
start_time,
end_time,
a.sid,
a.recid,
b.operation,
b.status,
a.output
from v$rman_output a,
v$rman_status b
where a.rman_status_recid = b.recid
 and a.rman_status_stamp = b.stamp
  and start_time >  sysdate - interval '&1' minute
 order by a.recid
 /