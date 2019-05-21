COL avg_time HEAD "Min | avg_time"
select q.servername,
       q.db_sid,
       q.schema_name,
       round(avg((q.finished-q.started)*1440)) avg_time
  from exp_queue q
 where status ='DONE'
   and q.schema_name like '&schema_name'
   and q.finished >= sysdate-6
group by q.servername, q.db_sid, q.schema_name
order by 4;