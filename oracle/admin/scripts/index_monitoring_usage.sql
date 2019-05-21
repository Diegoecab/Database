REM	Script para monitorear el uso de índices
REM ======================================================================
REM index_monitoring_usage.sql		Version 1.1	15 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Detectar indices sin utilizar.
REM Dependencias:
REM	dba_indexes,dba_users
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM
REM Precauciones:
REM	
REM ======================================================================
REM
SELECT 'ALTER INDEX ' || owner || '.' || index_name || ' MONITORING USAGE;'
  FROM dba_indexes
 WHERE owner NOT IN (
                     SELECT username
                       FROM dba_users
                      WHERE default_tablespace IN
                                                ('SYSTEM', 'SYSAUX', 'USERS'))
   AND index_name NOT IN (SELECT index_name
                            FROM dba_lobs);
							
							
/*
consultar el estado de los índices:
SELECT table_name,
       index_name,
       used,
       start_monitoring,
       end_monitoring
FROM   v$object_usage;
*/