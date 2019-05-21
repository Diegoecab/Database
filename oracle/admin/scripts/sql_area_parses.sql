REM	Script para ver estadisticas en SQL Area
REM ======================================================================
REM sql_area_parses.sql		Version 1.1	31 Marzo 2010
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

REM SQL_TEXT        Primeros 1000 caracteres del sql
REM EXECUTIONS      Cuantas veces fue ejecutado
REM FIRST_LOAD_TIME Cuando fue cargado por primera vez en el SQL Area
REM PARSE_CALLS     Cuantas veces se tuvo que re-parsear este SQL
REM DISK_READS      Total acumulado de lecturas fisicas para este SQL
REM BUFFER_GETS     Total acumulado de lecturas en memoria para este SQL
REM ROWS_PROCESSED  Total de registros procesados por este SQL
REM HASH_VALUE      HASH_VALUE unico para este SQL

col sql_text for a200
col parse_calls for 99999999
col executions for 99999999
select sql_text, parse_calls, executions from v$sqlarea
where parse_calls > 100 and executions < 2*parse_calls
order by parse_calls,first_load_time;