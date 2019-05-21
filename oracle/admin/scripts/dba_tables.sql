REM	
REM ======================================================================
REM dba_tables.sql		Version 1.1	29 Abril 2010
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
set lines 400
set head on
set feed on

select owner,table_name,last_analyzed,logging,tablespace_name,degree,buffer_pool, num_rows, blocks
from dba_tables 
where owner like upper('%&owner%')
and table_name like upper('%&table_name%')
order by 1,2
/