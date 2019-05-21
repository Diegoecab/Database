REM	Script para ver el cursor cache hits
REM ======================================================================
REM cursor_cache_hits.sql		Version 1.1	18 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM
col cursor_cache_hits for a20
col soft_parses for a20
col hard_parses for a20
SELECT    TO_CHAR (100 * sess / calls, '999999999990.00')
       || '%' cursor_cache_hits,
          TO_CHAR (100 * (calls - sess - hard) / calls,
                   '999990.00'
                  )
       || '%' soft_parses,
       TO_CHAR (100 * hard / calls, '999990.00') || '%' hard_parses
  FROM (SELECT VALUE calls
          FROM v$sysstat
         WHERE NAME = 'parse count (total)'),
       (SELECT VALUE hard
          FROM v$sysstat
         WHERE NAME = 'parse count (hard)'),
       (SELECT VALUE sess
          FROM v$sysstat
         WHERE NAME = 'session cursor cache hits');