/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  top_activity_wait_hour.sql v1.0
-- Purpose:    Script To Get Cpu Usage And Wait Event Information In Oracle Database
-- Usage:       
--     @top_activity_wait <lastNhours>
-- (rounded minutes)
-- Example:
--     Last hour
--     @top_activity_wait 60
--AAS = (DB Time / Elapsed Time) AAS is a time-normalized DB Time
--Load on database = AAS = DB Time/elapsed ~ = count(*)/elapsed
*/

set lines 200
set pages 100
set trimout on
set tab off
set feed off
set verify off


Break on SAMPLE_TIME on report

compute avg max of OTHER CLUST QUEUEING NETWORK ADMINISTRATIVE CONFIGURATION COMMIT APPLICATION CONCURRENCY SYSTEM_IO USER_IO SCHEDULER_IO CPU BACKGROUND_CPU on report

COLUMN SAMPLE_TIME HEADING 'Sample|Time'
COLUMN AAS HEADING 'AAS' for 999999.999
COLUMN CPU_CNT for a5
COLUMN OTHER HEADING 'Oth|er' for 999.999
COLUMN CLUST HEADING 'Clu|ste|r' for 999.999
COLUMN QUEUEING HEADING 'Que|uei|ng' for 999.999
COLUMN NETWORK HEADING 'Net|wor|k' for 999.999
COLUMN ADMINISTRATIVE HEADING 'Adm|ini|str|ati|ve' for 999.999
COLUMN CONFIGURATION HEADING 'Con|fig|ura|tio|n' for 999.999
COLUMN COMMIT HEADING 'Com|mit' for 999.999
COLUMN APPLICATION HEADING 'App|lic|ati|on' for 999.999
COLUMN CONCURRENCY HEADING 'Con|cur|ren|cy' for 999.999
COLUMN SYSTEM_IO HEADING 'Sys|tem| IO' for 999.999
COLUMN USER_IO HEADING 'Use|rIO' for 999.999
COLUMN SCHEDULER HEADING 'Sch|edu|ler' for 999.999
COLUMN CPU HEADING ' CPU' for 999.999
COLUMN BACKGROUND_CPU HEADING 'Bac|kgr|oun|d|CPU' for 999.999



SELECT trunc(SAMPLE_TIME, 'HH24') AS SAMPLE_TIME,
	   ROUND(AVG(OTHER) / 60, 3) AS OTHER,
       ROUND(AVG(CLUST) / 60, 3) AS CLUST,
       ROUND(AVG(QUEUEING) / 60, 3) AS QUEUEING,
       ROUND(AVG(NETWORK) / 60, 3) AS NETWORK,
       ROUND(AVG(ADMINISTRATIVE) / 60, 3) AS ADMINISTRATIVE,
       ROUND(AVG(CONFIGURATION) / 60, 3) AS CONFIGURATION,
       ROUND(AVG(COMMIT) / 60, 3) AS COMMIT,
       ROUND(AVG(APPLICATION) / 60, 3) AS APPLICATION,
       ROUND(AVG(CONCURRENCY) / 60, 3) AS CONCURRENCY,
       ROUND(AVG(SIO) / 60, 3) AS SYSTEM_IO,
       ROUND(AVG(UIO) / 60, 3) AS USER_IO,
       ROUND(AVG(SCHEDULER) / 60, 3) AS SCHEDULER,
       ROUND(AVG(CPU) / 60, 3) AS CPU,
       ROUND(AVG(BCPU) / 60, 3) AS BACKGROUND_CPU,
		AVG(OTHER+CLUST+QUEUEING+NETWORK+ADMINISTRATIVE+COMMIT+APPLICATION+CONCURRENCY+SIO+UIO+SCHEDULER+CPU
		) as AAS,
		(select value  from v$parameter
where name='cpu_count') as CPU_CNT
  FROM (SELECT TRUNC(SAMPLE_TIME, 'MI') AS SAMPLE_TIME,
               DECODE(SESSION_STATE,
                      'ON CPU',
                      DECODE(SESSION_TYPE, 'BACKGROUND', 'BCPU', 'ON CPU'),
                      WAIT_CLASS) AS WAIT_CLASS
          FROM gv$active_session_history
         WHERE (SAMPLE_TIME > SYSDATE - INTERVAL '&1' HOUR)
           AND SAMPLE_TIME <= TRUNC(SYSDATE, 'MI')) ASH PIVOT(COUNT(*) 
  FOR WAIT_CLASS IN(
 'ON CPU' AS CPU,'BCPU' AS BCPU,
'Scheduler' AS SCHEDULER,
'User I/O' AS UIO,
'System I/O' AS SIO, 
'Concurrency' AS CONCURRENCY,                                                                               
'Application' AS  APPLICATION,                                                                                  
'Commit' AS  COMMIT,                                                                             
'Configuration' AS CONFIGURATION,                     
'Administrative' AS   ADMINISTRATIVE,                                                                                 
'Network' AS  NETWORK,                                                                                 
'Queueing' AS   QUEUEING,                                                                                  
'Cluster' AS   CLUST,                                                                                      
'Other' AS  OTHER)) ASH
group by trunc(SAMPLE_TIME, 'HH24')
ORDER BY 1
/
