REM ======================================================================
REM user_conf.sql		Version 1.1	16 Enero 2009
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Clonar usuario de base de datos
REM
REM Dependencias:
REM	
REM
REM NotAs:
REM 	Ejecutar con sys
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM 
REM ======================================================================
REM
set lines 100 pages 999
set verify off
set feedback off

undefine user

accept userid prompt 'Ingresar usuario:'

select username
,      default_tablespace
,      temporary_tablespace
from   dba_users
where  username = '&userid'
/

select tablespace_name
,      decode(max_bytes, -1, 'unlimited'
,      ceil(max_bytes / 1024 / 1024) || 'M' ) "QUOTA"
from   dba_ts_quotas
where  username = upper('&&userid')
/

select granted_role || ' ' || decode(admin_option, 'NO', '', 'YES', 'with admin option') "ROLE"
from   dba_role_privs
where  grantee = upper('&&userid')
/

select privilege || ' ' || decode(admin_option, 'NO', '', 'YES', 'with admin option') "PRIV"
from   dba_sys_privs
where  grantee = upper('&&userid')
/

undefine user
set verify on
set feedback on
REM
REM