--db_wait_class_ratio minutes
select inst_id, wait_class, time_waited, total_time_waited, AAS, round(time_waited*100/total_time_waited,1) time_waited_pct
 from 
(
select a.inst_id,
 b.wait_class,
 round((sum(a.time_waited) / 100),2) time_waited,
 (select (sum(h.time_waited) / 100) from gv$waitclassmetric_history h, gv$system_wait_class i where  h.wait_class# = i.wait_class# and wait_class != 'Idle'  and h.end_time > SYSDATE - INTERVAL '&1' MINUTE and h.inst_id=a.inst_id) total_time_waited,
round(sum(a.time_waited)/max(a.INTSIZE_CSEC),3) AAS
 from gv$waitclassmetric_history a,
 gv$system_wait_class b
 where a.wait_class# = b.wait_class# 
  and end_time > SYSDATE - INTERVAL '&1' MINUTE
 and b.wait_class != 'Idle'
 group by a.inst_id,b.wait_class
 order by 1,2
 )
 order by 1, time_waited_pct desc
 /