REM	Script para monitorear el uso historico de memoria en la base de datos
REM ======================================================================
REM memory_usage_hist.sql		Version 1.1	22 Feb 2012
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	
REM Dependencias:
REM	v$buffer_pool,v$sgastat
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set heading off

select nvl(pool,'buffer pool') pool,to_date(to_char(
trunc(begin_interval_time,'dd'),'dd/mm/yyyy'),'dd/mm/yyyy')
begin_interval_time,
round(avg(bytes/1024/1024)) avg_mbytes,
round(max(bytes/1024/1024)) max_mbytes,
round(min(bytes/1024/1024)) min_mbytes
from dba_hist_sgastat a, dba_hist_snapshot b
where a.snap_id=b.snap_id
and begin_interval_time > sysdate - &days
group by pool,trunc(begin_interval_time,'dd')
order by 2,1
/
