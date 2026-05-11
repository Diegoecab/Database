/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  top_activity_wait_h.sql v1.0
-- Purpose:    Script To Get Cpu Usage And Wait Event Information In Oracle Database
-- Usage:       
--     @top_activity_wait_h <lastNminutes>
-- (rounded minutes)
-- Example:
--     Last hour
--     @top_activity_wait 60
--AAS = (DB Time / Elapsed Time) AAS is a time-normalized DB Time
--Load on database = AAS = DB Time/elapsed ~ = count(*)/elapsed
--DBA_HIST_ACTIVE_SESS_HISTORY => 10 * (COUNT(*)) = DB Time in seconds
--the sample time is now 10 seconds, so use (count*10) to measure time
*/

set lines 900
set pages 1000
set trimout on
set tab off
set feed off
set verify off


Break on SAMPLE_TIME on report

compute avg max of OTHER_PCT CLUST_PCT QUEUEING_PCT NETWORK_PCT ADMINISTRATIVE_PCT CONFIGURATION_PCT COMMIT_PCT APPLICATION_PCT CONCURRENCY_PCT SYSTEM_IO_PCT USER_IO_PCT SCHEDULER_IO_PCT CPU_PCT BACKGROUND_CPU_PCT on report


COLUMN SAMPLE_TIME HEADING 'Sample|Time'
COLUMN AAS HEADING 'AAS' for 999.999
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


SELECT TO_CHAR(SAMPLE_TIME, 'DD-MON-YY HH24:MI') AS SAMPLE_TIME,
	   ROUND((OTHER*10) / 60, 3) AS OTHER,
       ROUND((CLUST*10) / 60, 3) AS CLUST,
       ROUND((QUEUEING*10) / 60, 3) AS QUEUEING,
       ROUND((NETWORK*10) / 60, 3) AS NETWORK,
       ROUND((ADMINISTRATIVE*10) / 60, 3) AS ADMINISTRATIVE,
       ROUND((CONFIGURATION*10) / 60, 3) AS CONFIGURATION,
       ROUND((COMMIT*10) / 60, 3) AS COMMIT,
       ROUND((APPLICATION*10) / 60, 3) AS APPLICATION,
       ROUND((CONCURRENCY*10) / 60, 3) AS CONCURRENCY,
       ROUND((SIO*10) / 60, 3) AS SYSTEM_IO,
       ROUND((UIO*10) / 60, 3) AS USER_IO,
       ROUND((SCHEDULER*10) / 60, 3) AS SCHEDULER,
       ROUND((CPU*10) / 60, 3) AS CPU,
       ROUND((BCPU*10) / 60, 3) AS BACKGROUND_CPU--,
	   /*(
			(SELECT (count(*)*10)/60 FROM DBA_HIST_ACTIVE_SESS_HISTORY where  
			TO_CHAR(SAMPLE_TIME, 'DD-MON-YY HH24:MI') = TO_CHAR(ASH.SAMPLE_TIME, 'DD-MON-YY HH24:MI') and session_type = 'FOREGROUND' )
		) as AAS --DB Time*/
  FROM (SELECT TRUNC(SAMPLE_TIME, 'MI') AS SAMPLE_TIME,
               DECODE(SESSION_STATE,
                      'ON CPU',
                      DECODE(SESSION_TYPE, 'BACKGROUND', 'BCPU', 'ON CPU'),
                      WAIT_CLASS) AS WAIT_CLASS
          FROM DBA_HIST_ACTIVE_SESS_HISTORY
         WHERE SAMPLE_TIME > SYSDATE - INTERVAL '&1' MINUTE
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
order by 1
;