REM	Script para listar los usuarios que consumen mas tablespace de undo
REM ======================================================================
REM dba_tables_x.sql		Version 1.1	29 Abril 2010
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
set verify off
accept TNAME prompt 'Ingrese nombre de tabla: '
select owner,last_analyzed,logging,tablespace_name,degree,buffer_pool from dba_tables where table_name=upper('&TNAME');