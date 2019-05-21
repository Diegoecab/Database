-- 
-- update jobsize value
--
col new_job_size_gb heading "GB|New" for 999
col curr_job_size   heading "GB|Current" for 999
col diff_gb         heading "GB|diff" for 999
col zipped_size     heading "GB|zipped" for 999
col servername      heading "HOST" for a9

select av.servername, av.db_sid, av.schema_name, 
      round(av.avg_job_size/1024/1024/1024)    zipped_size, 
      round(s.jobsize/1024/1024/1024)          curr_job_size, 
      round((av.avg_job_size +(c.filesize*c.parallel*2))/1024/1024/1024) new_job_size_gb,  
      round(((av.avg_job_size +(c.filesize*c.parallel*2)) - (s.jobsize))/1024/1024/1024) diff_gb,
      'update exp_schema set jobsize='||round((av.avg_job_size +(c.filesize*c.parallel*2)))||' where app_id='|| s.app_id||' and schema_name='''||s.schema_name||''';' sql
  from (
         select j.servername,j.db_sid, j.schema_name, round(avg(j.job_size))  avg_job_size       
           from(
                 select q.servername, 
                        q.db_sid, 
                        q.schema_name,
                        q.book_date,
                        q.job_id,
                        round(sum(nvl(f.zipsize,0))) job_size 
                   from exp_queue    q, exp_log_file f 
                  where q.job_id = f.job_id
                    and q.status='DONE'
                    and q.job_id= f.job_id
                    and q.submitted between sysdate-14 and sysdate
                 group by q.servername, q.db_sid, q.schema_name, q.book_date,q.job_id) j
         group by j.servername,j.db_sid, j.schema_name            
       ) av,
       exp_schema s,											
       exp_dp_cfg c											
where s.servername  = av.servername											
  and s.db_sid      = av.db_sid										
  and s.schema_name = av.schema_name		
  and s.cfg_id      = c.cfg_id	
  and s.enable > 0
  and round(((av.avg_job_size +(c.filesize*c.parallel*2) ) - (s.jobsize))/1024/1024/1024) != 0
order by 7 desc;