set echo off
SELECT book_date, run, servername, 
      db_sid, schema_name, 
      Round(Max(jobsize)/1024/1024/1024) max_size, 
      Round(Avg(jobsize)/1024/1024/1024) avg_size,
      Count(1) snaps
FROM exp_job_size
GROUP BY book_date, run, servername, db_sid, schema_name
ORDER BY 6 desc
/