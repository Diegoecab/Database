REM	Script para ver cantidad total de espacio utilizado por indices no utilizados
REM ======================================================================
REM v_unusable_indexes.sql		Version 1.1	18 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM Detectar índices sin usar
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
SELECT owner, ROUND (SUM (BYTES) / 1024 / 1024 / 1024, 1) gb
  FROM dba_segments a
 WHERE segment_type in ('INDEX','PARTITION INDEX')
   AND segment_name IN (
          SELECT o.object_name
            FROM dba_objects o, SYS.object_usage os
           WHERE object_id = obj#
             AND flags = 0                                     -- Indice no usado
             AND object_name NOT LIKE 'BIN$%'      --No sea objeto en papelera
             AND end_monitoring IS NULL
             AND o.owner = a.owner
             AND o.object_type in ('INDEX','PARTITION INDEX')
             AND o.object_name = a.segment_name)
GROUP BY OWNER
ORDER BY 2
/