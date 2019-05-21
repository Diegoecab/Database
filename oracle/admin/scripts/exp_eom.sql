col exported for a9
col schema_name for a20

 select distinct 
        s.schema_name, 
        NVL2(q.schema_name,'TRUE','FALSE') exported
   from exp_schema   s,
        (select q.servername, 
                q.db_sid, 
                q.schema_name
           from exp_queue q
          where trunc(q.submitted)>=trunc(sysdate-10) 
            and exists (select 1 
                         from exp_eom_file f
                         where q.job_id=f.job_id)
         )    q
where s.servername  = q.servername   (+) 
  and s.db_sid      = q.db_sid       (+) 
  and s.schema_name = q.schema_name  (+) 
  and s.db_sid='&db_sid'
  and s.enable>0
order by 2 desc,1
/
