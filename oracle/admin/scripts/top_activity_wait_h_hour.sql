/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  top_activity_wait_h_hour.sql v1.0
-- Purpose:    Script To Get Cpu Usage And Wait Event Information In Oracle Database
-- Usage:       
--     @top_activity_wait_h_hour <lastNhours>
-- (rounded minutes)
-- Example:
--     Last hour
--     @top_activity_wait_h_hour 168
--AAS = (DB Time / Elapsed Time) AAS is a time-normalized DB Time
--Load on database = AAS = DB Time/elapsed ~ = count(*)/elapsed
--DBA_HIST_ACTIVE_SESS_HISTORY => 10 * (COUNT(*)) = DB Time in seconds
--the sample time is now 10 seconds, so use (count*10) to measure time
*/

set lines 900
set pages 100
set trimout on
set tab off
set feed off
set verify off


--Break on SAMPLE_TIME on report

compute avg max of OTHER_PCT CLUST_PCT QUEUEING_PCT NETWORK ADMINISTRATIVE CONFIGURATION COMMIT APPLICATION CONCURRENCY SYSTEM_IO USER_IO SCHEDULER_IO CPU BACKGROUND_CPU on report


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


SELECT to_char(trunc(SAMPLE_TIME, 'HH24'),'DD-MM-YY HH24') AS SAMPLE_TIME,
	   ROUND(AVG(OTHER*10) / 60, 3) AS OTHER,
       ROUND(AVG(CLUST*10) / 60, 3) AS CLUST,
       ROUND(AVG(QUEUEING*10) / 60, 3) AS QUEUEING,
       ROUND(AVG(NETWORK*10) / 60, 3) AS NETWORK,
       ROUND(AVG(ADMINISTRATIVE*10) / 60, 3) AS ADMINISTRATIVE,
       ROUND(AVG(CONFIGURATION*10) / 60, 3) AS CONFIGURATION,
       ROUND(AVG(COMMIT*10) / 60, 3) AS COMMIT,
       ROUND(AVG(APPLICATION*10) / 60, 3) AS APPLICATION,
       ROUND(AVG(CONCURRENCY*10) / 60, 3) AS CONCURRENCY,
       ROUND(AVG(SIO*10) / 60, 3) AS SYSTEM_IO,
       ROUND(AVG(UIO*10) / 60, 3) AS USER_IO,
       ROUND(AVG(SCHEDULER*10) / 60, 3) AS SCHEDULER,
       ROUND(AVG(CPU*10) / 60, 3) AS CPU,
       ROUND(AVG(BCPU*10) / 60, 3) AS BACKGROUND_CPU,
	  SUM(OTHER+CLUST+QUEUEING+NETWORK+ADMINISTRATIVE+COMMIT+APPLICATION+CONCURRENCY+SIO+UIO+SCHEDULER+CPU
		)*10 as AAS --DB Time
  FROM (SELECT TRUNC(SAMPLE_TIME, 'MI') AS SAMPLE_TIME,
               DECODE(SESSION_STATE,
                      'ON CPU',
                      DECODE(SESSION_TYPE, 'BACKGROUND', 'BCPU', 'ON CPU'),
                      WAIT_CLASS) AS WAIT_CLASS
          FROM DBA_HIST_ACTIVE_SESS_HISTORY
         WHERE SAMPLE_TIME > SYSDATE - INTERVAL '&1' HOUR
           AND SAMPLE_TIME <= TRUNC(SYSDATE, 'MI')) ASH PIVOT(COUNT(*) 
  FOR WAIT_CLASS IN('ON CPU' AS CPU,'BCPU' AS BCPU,
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
order by to_date( SAMPLE_TIME,'DD-MM-YY HH24')
;