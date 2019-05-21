set lines 400
set pages 500
set head on
col job_id for 999999
col priority for 999 heading 'PRIO'
col SIZE_GB for 999 HEADING 'GB|SIZE' 
col nice for 999
col avg  for 999 HEADING 'MIN|AVG'
col rem  for 999 HEADING 'MIN|REM'
col elap for 999 HEADING 'MIN|ELAP'
col started   for a15
col finished  for a15
col submitted for a15
col status    for a8
col degree    for 99 heading 'DG'
col cron for 99
col servername for a13
col SCHEMA_NAME for a19

select q.job_id,
       q.db_sid,
       q.servername,
       q.schema_name,
       q.book_date,
       q.run,
       q.bkp_mode,
	   s.ps_mon_id,
       q.status,
       s.cron_id cron,
       q.attempt,
       q.nice, 
       decode(q.bkp_Mode,'EOM',q.nice-10,q.nice)+q.attempt-1 PRIORITY,
       d.parallel                                            DEGREE,
       nvl(round(s.jobsize/1024/1024/1024),0)                SIZE_GB,
       nvl(avg.avg_time,0)                                   AVG,
       nvl((sysdate-q.started)*1440,0)                       ELAP,
       nvl(avg.avg_time-(sysdate-q.started)*1440,0)          REM,
       to_char(q.submitted,'DD-MON-YY HH24:MI')              SUBMITTED,
       to_char(q.started,'DD-MON-YY HH24:MI')                STARTED,
       to_char(q.finished,'DD-MON-YY HH24:MI')               FINISHED
  from dbadmin.exp_queue  q,
       dbadmin.exp_schema s,
       dbadmin.exp_dp_cfg d,
       (select q1.servername, q1.db_sid, q1.schema_name,
               round(avg((q1.finished-q1.started)*1440)) avg_time
          from exp_queue q1
         where status ='DONE'
           and q1.finished >= sysdate-6
       group by q1.servername, q1.db_sid, q1.schema_name)   AVG
 where submitted > trunc(sysdate-2)
   and q.servername = s.servername
   and q.db_sid     = s.db_sid
   and q.schema_name = s.schema_name
   and avg.schema_name (+)= q.schema_name
   and avg.db_sid      (+)= q.db_sid
   and avg.servername  (+)=q.servername
   and s.cfg_id  = d.cfg_id
   and status !='DONE'
order by 12 desc,1 desc;

prompt Monitor: exec exp_util.monitor(1);