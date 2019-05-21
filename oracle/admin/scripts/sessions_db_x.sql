REM	Script para ver las sesiones actuales en la base de datos
REM ======================================================================
REM sessions_db.sql		Version 1.1	29 Marzo 2010
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
col machine heading 'Machine' for a50
accept username prompt 'Ingrese Usuario:  '
select sid,serial#,username,program,machine,status from v$session where username = upper('&username') order by machine,program;