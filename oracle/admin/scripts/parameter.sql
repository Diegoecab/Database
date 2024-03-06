REM Parametros de la base
REM ======================================================================
REM v$parameter.sql		Version 1.1	16 Mayo 2011
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
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set pagesize 10000
set verify off
col name heading 'Parametro' for a50
col display_value heading 'Valor' for a50
select name,display_value from v$parameter where upper(name) like upper('%&name%');