REM	Script alternativa a un update masivo de millones de registros en una tabla
REM ======================================================================
REM update_massive_asselect.sql		Version 1.1	11 Marzo 2010
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
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM
CREATE TABLE asselect 
PARALLEL (degree 4)
AS
SELECT
  (CASE
    WHEN owner IN (SELECT 'SYS' FROM DUAL) THEN 'PEPE'
    ELSE owner
  END ) owner, object_name,subobject_name,object_id,
  data_object_id,object_type,created,last_ddl_time,
  TIMESTAMP,status,TEMPORARY,GENERATED,secondary
FROM dba_objects;