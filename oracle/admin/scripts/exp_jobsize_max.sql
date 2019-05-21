col sql for a121
col SCHEMA_NAME for a13 trunc
col MAX_SIZE for 99 heading 'SIZE|MAX'
col avg_size for 99 heading 'SIZE|AVG'
col snaps for 999 heading 'SNAP'
set linesize 253
col bd for a8

SELECT to_char(book_date,'DD-MM-YY') BD, servername, 
      db_sid, schema_name, 
      Round(Max(jobsize)/1024/1024/1024) max_size, 
      Round(Avg(jobsize)/1024/1024/1024) avg_size,
      Count(1) snaps,
      'update exp_schema set jobsize='||max(jobsize)||' where schema_name='''||schema_name||''' and servername='''||servername||''' and db_sid='''||db_sid||''';' sql
FROM exp_job_size
where book_date=(select max(book_date) from exp_job_size)
GROUP BY book_date,  servername, db_sid, schema_name
ORDER BY 6 desc
/