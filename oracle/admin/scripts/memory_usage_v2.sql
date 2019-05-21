ALTER SESSION SET nls_date_format = 'DD/MM/YYYY HH24:MI:SS';

set pages 900
set lines 300
COL COMPONENT FORMAT A25
COL INITIAL_SIZE FORMAT A10
COL FINAL_SIZE FORMAT A10

select * from V$MEMORY_DYNAMIC_COMPONENTS;

select component, current_size/1024/1024 current_size,  min_size/1024/1024 min_size , max_Size/1024/1024 max_size, 
user_specified_size/1024/1024 user_specified_size, oper_count,
last_oper_type, last_oper_mode, last_oper_time,granule_size
from V$SGA_DYNAMIC_COMPONENTS;

select START_TIME, component, oper_type, oper_mode, initial_size/1024/1024 "INITIAL", FINAL_SIZE/1024/1024 "FINAL", END_TIME
from V$MEMORY_RESIZE_OPS
order by start_time, component;

select START_TIME, component, oper_type, oper_mode, initial_size/1024/1024 "INITIAL", FINAL_SIZE/1024/1024 "FINAL", END_TIME
from V$SGA_RESIZE_OPS
order by start_time, component;

select name, round(bytes/(1024*1024),1) "MB" from v$sgastat where pool='shared pool' order by 2 desc;

--Cantidad de pooles en la shared
select KSMCHIDX "SubPool", round((sum(ksmchsiz))/1024/1024,2) MBytes
from x$ksmsp 
group by ksmchidx order by 1;

select KSMCHIDX "SubPool",ksmchcom "Allocation Type", round((sum(ksmchsiz))/1024/1024,2) MBytes 
from x$ksmsp 
group by ksmchidx,ksmchcom 
order by 3;

set lines 120
set pages 999
col KSMCHIDX for 999 head "Subpool"
col num_chunks for 99999999
col "Min Size" for 99999999
col "Max Size" for 99999999
col "Avg Size" for 99999999
col "Tot Size" for 99999999
break on report
compute sum label "Total" of "Tot Size" on report

--Ver en detalle el uso de subpooles de la shared
SELECT KSMCHIDX, ksmchcom "Allocation Type"
,count(*) Num_Chunks
,(min(ksmchsiz)/1024) "Min Size"
,(max(ksmchsiz)/1024) "Max Size"
,(trunc(avg(ksmchsiz))/1024) "Avg Size"
,round((sum(ksmchsiz))/1024/1024,2) "Tot Size"
FROM x$ksmsp
GROUP BY KSMCHIDX, ksmchcom
ORDER BY 7, 5, 3
/


SELECT KSMCHIDX, ksmchcom "Allocation Type"
,count(*) Num_Chunks
,(min(ksmchsiz)/1024) "Min Size"
,(max(ksmchsiz)/1024) "Max Size"
,(trunc(avg(ksmchsiz))/1024) "Avg Size"
,round((sum(ksmchsiz))/1024/1024,2) "Tot Size"
FROM x$ksmsp where ksmchcom='free memory'
GROUP BY KSMCHIDX, ksmchcom
ORDER BY 1, 7, 5, 3
/

--Para ver Errores en los diferentes subpools de la shared
SELECT KGHLUSHRPOOL "SUBPOOL", KGHLURCR "PINS AND|RELEASES",
KGHLUTRN, KGHLUFSH, KGHLUOPS, KGHLUNFU "ORA-4031|ERRORS",
KGHLUNFS "LAST ERROR|SIZE" 
FROM SYS.X$KGHLU
WHERE INST_ID = USERENV('Instance') ;



SELECT KSMCHCLS CLASS, COUNT(KSMCHCLS) NUM, SUM(KSMCHSIZ) SIZ,
To_char( ((SUM(KSMCHSIZ)/COUNT(KSMCHCLS)/1024)),'999,999.00')||'k' "AVG SIZE"
FROM X$KSMSP GROUP BY KSMCHCLS;



SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') DT, KSMSSNAM NAME, 
       KSMDSIDX SUBPOOL, ROUND(KSMSSLEN/1024/1024) MBYTES 
	   FROM X$KSMSS
WHERE KSMSSLEN > (10*1024*1024) OR KSMSSNAM='free memory' --more than 10MBytes
ORDER BY NAME, SUBPOOL;