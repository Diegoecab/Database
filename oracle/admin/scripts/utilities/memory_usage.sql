REM	Script para monitorear el uso de memoria en la base de datos
REM ======================================================================
REM memory_usage.sql		Version 1.1	15 Marzo 2010
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
prompt
prompt ======================================================================
prompt Parametros
prompt ======================================================================
show parameter sga_max_size
show parameter sga_target
show parameter pga
prompt
prompt ======================================================================
set heading on
/* Ver tamaño actual de db buffers */
col block_size for 99999
select name,block_size,current_size from v$buffer_pool;
/* */
select pool, round(sum(bytes)/1024/1024,2) Mbytes from v$sgastat group by pool;