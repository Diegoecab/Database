col sql for a121
col SCHEMA_NAME for a13 trunc
col MAX_SIZE for 99 heading 'SIZE|MAX'
col avg_size for 99 heading 'SIZE|AVG'
col snaps for 999 heading 'SNAP'
set linesize 253
col bd for a8

SELECT round(s.jobsize/1024/1024) jobsize_mb, 
       round(a.avg_max_size/1024/1024) avg_max_mb,
       round((a.avg_max_size-s.jobsize)/1024/1024) growth_mb, 'update exp_schema set jobsize='||avg_max_size||' where schema_name='''||a.schema_name||''' and servername='''||a.servername||''' and db_sid='''||a.db_sid||''';' SQL
  FROM (
          SELECT servername, db_sid, schema_name, Round(Avg(job_max_size)) avg_max_size
            FROM (
                    select j.servername, j.db_sid, j.schema_name, j.book_date, max(j.jobsize) job_max_size
                      from exp_job_size j,
                           exp_queue q
                     where j.servername  = q.servername
                       and j.db_sid      = q.db_sid
                       and j.schema_name = q.schema_name
                       and j.book_date   = q.book_date
                       and j.run         = q.run
                       and q.status      = 'DONE'          
                    group by  j.servername, j.db_sid, j.schema_name, j.book_date
                    order by j.servername, j.db_sid, j.schema_name, j.book_date
                  )
          GROUP BY servername, db_sid, schema_name
          ORDER BY servername, db_sid, schema_name
       ) A,
       exp_schema s 
 WHERE s.servername  = a.servername
   and s.db_sid      = a.db_sid
   and s.schema_name = a.schema_name
   and abs(round((a.avg_max_size-s.jobsize)/1024/1024)) > 5
order by 3
/
