REM	Script para listar los usuarios que tiene algún tipo de grant a un esquema en particular
REM ======================================================================
REM grants_obj_esquema_users.sql		Version 1.1	10 Marzo 2010
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
set pagesize 300
accept SCHEMA prompt 'Ingrese ESQUEMA: '
select distinct grantee USUARIO from dba_Tab_privs where owner=upper('&SCHEMA') order by 1;

prompt Grants a roles:
select count(*) from role_tab_privs where owner= upper('&SCHEMA');