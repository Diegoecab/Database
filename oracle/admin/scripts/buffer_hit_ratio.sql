REM	Script para determinar hit ratio de Buffer Hit Ratio
REM ======================================================================
REM buffer_hit_ratio.sql		Version 1.1	26 Marzo 2010
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

select 	sum(decode(NAME, 'consistent gets',VALUE, 0)) "Consistent Gets",
	sum(decode(NAME, 'db block gets',VALUE, 0)) "DB Block Gets",
	sum(decode(NAME, 'physical reads',VALUE, 0)) "Physical Reads",
	round((sum(decode(name, 'consistent gets',value, 0)) + 
	       sum(decode(name, 'db block gets',value, 0)) - 
	       sum(decode(name, 'physical reads',value, 0))) / 
	      (sum(decode(name, 'consistent gets',value, 0)) + 
	       sum(decode(name, 'db block gets',value, 0))) * 100,2) "Hit Ratio"
from   v$sysstat;

SELECT NAME, PHYSICAL_READS, DB_BLOCK_GETS, CONSISTENT_GETS,
      1 - (PHYSICAL_READS / (DB_BLOCK_GETS + CONSISTENT_GETS)) "Hit Ratio"
  FROM V$BUFFER_POOL_STATISTICS;