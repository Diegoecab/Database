REM	Script para obtener grants dados a un rol
REM ======================================================================
REM role_privs_x.sql		Version 1.1	10 Enero 2011
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

set pages 1000
set lines 132
set trims on
set verify off
set feedback off

accept ROLE prompt 'Ingrese ROLE: '
prompt
ttitle 'GRANTS A UN ROL'
prompt
ttitle 'SYSTEM ROLES'
select privilege,admin_option from ROLE_SYS_PRIVS where upper(role)=upper('&ROLE');
prompt
ttitle 'TAB PRIVS'
select owner,table_name,column_name,privilege,grantable from ROLE_TAB_PRIVS where upper(role)=upper('&ROLE');
prompt
ttitle 'ROLE PRIVS'
select granted_role,admin_option from ROLE_ROLE_PRIVS where upper(role)=upper('&ROLE');
--System privileges
prompt
ttitle 'SYSTEM PRIVILEGES'
SELECT dsp.PRIVILEGE, dsp.admin_option  FROM dba_sys_privs dsp WHERE upper(dsp.grantee) = upper('&ROLE');
prompt
ttitle off
set feedback on