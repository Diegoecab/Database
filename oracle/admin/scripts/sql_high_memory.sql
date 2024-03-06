--v$sql_high_memory.sql
--Now

PROMPT Now
col sql_text for a100
set lines 300
 SELECT substr(sql_text,1,120) "Stmt", count(*), 
 round(sum(sharable_mem)/1024/1024)    "MemMB",                
 sum(users_opening)   "Open",                
 sum(executions)      "Exec"
 FROM v$sql         
 GROUP BY substr(sql_text,1,120)        
 HAVING (sum(sharable_mem)/1024/1024) > (select round(sum(bytes)/1024/1024,2) * .1 from v$sgastat where pool = 'shared pool')
 ORDER BY round(sum(sharable_mem)/1024/1024);
 

col Stmt for a200
set lines 400
set pages 10

--Ejecutar para cdwpro
SELECT substr(sql_text,1,250) "Stmt", count(*),
round(sum(sharable_mem)/1024)    "MemKB",
round(sum(sharable_mem)/1024/1024)    "MemMB",
round(sum(sharable_mem)/1024)/count(*)    "MemxExec",
sum(users_opening)   "Open",
count(invalidations) "Invalid",
count(loads) "Loads",
sum(executions)      "Exec"
FROM v$sql where substr(sql_text,1,250) like '%SYS_XMLGEN(VALUE%'
GROUP BY substr(sql_text,1,250)
ORDER BY round(sum(sharable_mem)/1024) 
/
 
 

--X Hora 

PROMPT Per Hour, last 7 days

 SELECT TO_DATE(TO_CHAR(SS.END_INTERVAL_TIME,'dd/mm/yyyy hh24'),'dd/mm/yyyy hh24')||'Hs' "Date",to_char(substr(sql_text,1,120)) "Stmt", count(*), 
 round(sum(sharable_mem)/1024/1024)    "MemMB"
FROM   DBA_HIST_SQLSTAT STAT, DBA_HIST_SQLTEXT TXT, DBA_HIST_SNAPSHOT SS
   WHERE       STAT.SQL_ID = TXT.SQL_ID
           AND STAT.DBID = TXT.DBID
           AND SS.DBID = STAT.DBID
           AND SS.INSTANCE_NUMBER = STAT.INSTANCE_NUMBER
           AND STAT.SNAP_ID = SS.SNAP_ID
           AND STAT.DBID = (select dbid from v$database)
           --AND STAT.INSTANCE_NUMBER = (select instance_number from v$instance)    
           AND TRUNC(SS.END_INTERVAL_TIME) > TRUNC(SYSDATE -7)
 GROUP BY TO_DATE(TO_CHAR(SS.END_INTERVAL_TIME,'dd/mm/yyyy hh24'),'dd/mm/yyyy hh24'),to_char(substr(sql_text,1,120))
 HAVING (sum(sharable_mem)/1024/1024) > (select round(sum(bytes)/1024/1024,2) * .1 from v$sgastat where pool = 'shared pool')
 ORDER BY TO_DATE(TO_CHAR(SS.END_INTERVAL_TIME,'dd/mm/yyyy hh24'),'dd/mm/yyyy hh24');
 
--X Mes

PROMPT By month
col sql_text for a30
set lines 300
SELECT TO_DATE(TO_CHAR(SS.END_INTERVAL_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') "Date",to_char(substr(sql_text,1,120)) "Stmt", count(*), 
 round(sum(sharable_mem)/1024/1024)    "MemMB"
FROM   DBA_HIST_SQLSTAT STAT, DBA_HIST_SQLTEXT TXT, DBA_HIST_SNAPSHOT SS
   WHERE       STAT.SQL_ID = TXT.SQL_ID
           AND STAT.DBID = TXT.DBID
           AND SS.DBID = STAT.DBID
           AND SS.INSTANCE_NUMBER = STAT.INSTANCE_NUMBER
           AND STAT.SNAP_ID = SS.SNAP_ID
           AND STAT.DBID = (select dbid from v$database)
           AND STAT.INSTANCE_NUMBER = (select instance_number from v$instance)     
 GROUP BY TO_DATE(TO_CHAR(SS.END_INTERVAL_TIME,'dd/mm/yyyy'),'dd/mm/yyyy'),to_char(substr(sql_text,1,120))
 HAVING (sum(sharable_mem)/1024/1024) > (select round(sum(bytes)/1024/1024,2) * .1 from v$sgastat where pool = 'shared pool')
 ORDER BY 1;
 
 
 
