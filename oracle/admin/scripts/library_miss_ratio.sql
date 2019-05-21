REM	Library Cache Miss Ratio
REM ======================================================================
REM library_miss_ratio.sql		Version 1.1	26 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM

select 	sum(PINS) Executions,
	sum(RELOADS) cache_misses,
	sum(RELOADS) / sum(PINS) miss_ratio
from 	v$librarycache;