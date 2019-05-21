REM	Script para ver el contenido de variables bind
REM ======================================================================
REM view_bind_variables.sql		Version 1.1	11 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	V$SQL_BIND_CAPTURE
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM Para ver datos en la vista que se detalla a continuacion, es necesario tener seteado el parametro STATISTICS_LEVEL en ALL o TYPICAL
REM Precauciones:
REM	
REM ======================================================================
REM
set lines 400

col sql_text for a100
col value_string for a20

 SELECT
   parsing_schema_name,
   a.sql_text,
   b.name,
   b.position,
   b.datatype_string,
   b.value_string
FROM
  v$sql_bind_capture b,
  v$sqlarea          a
WHERE
   b.sql_id = '&SQLID'
   and a.plan_hash_value = '&plan_hash_value'
   and parsing_schema_name = '&parsing_schema_name'
AND
   b.sql_id = a.sql_id;