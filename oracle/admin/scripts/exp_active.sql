--select q.servername, q.db_sid, q.schema_name, count(1)
--from exp_queue q
--where exists (select 1 from exp_log_file f where q.job_id=f.job_id
--and f.deleted is null)
--group by q.servername, q.db_sid, q.schema_name
--having count(1) > 2
--order by count(1)
--/



select s.servername, s.db_sid, s.schema_name, count(1)
  from exp_schema s,
       exp_queue  q
 where s.servername  = q.servername  (+)
   and s.db_sid      = q.db_sid      (+)
   and s.schema_name = q.schema_name (+)
   and s.db_sid      like '&db_sid'
   and s.schema_name like '&schema'
   and exists (select 1 from exp_log_file f where f.job_id=q.job_id and deleted is null and bmode!='EOM')
group by s.servername, s.db_sid, s.schema_name
order by 4 desc
/