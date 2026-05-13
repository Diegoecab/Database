REM ======================================================================
REM enable_block_change_tracking.sql		Version 1.1	19 Enero 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM Habilitar db block change tracking en la base de datos
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar usuario dba
REM	Para Oracle version 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM os_file_name debe ser reemplazado por el archivo encerrado con comillas simples
REM ======================================================================
REM
ALTER DATABASE
ENABLE BLOCK CHANGE TRACKING
USING FILE os_file_name;