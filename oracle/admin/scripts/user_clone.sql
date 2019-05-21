REM	Clonar usuario de base de datos
REM ======================================================================
REM user_conf.sql		Version 1.1	16 Enero 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
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
REM El script genera un archivo en /tmp/user_clone_tmp.sql
REM ======================================================================
REM

set lines 999 pages 999
set verify off
set feedback off
set heading off

select	username
from	dba_users
order	by username
/

undefine user

accept userid prompt 'Ingrese usuario a clonar: '
accept newuser prompt 'Ingrese nuevo usuario: '
accept passwd prompt 'Ingrese password para el nuevo usuario: '

select username
,      created
from   dba_users
where  lower(username) = lower('&newuser')
/

accept poo prompt 'Continue? (ctrl-c to exit)'

spool c:\temp\&newuser..sql

select 'create user ' || '&newuser' ||
       ' identified by ' || '&passwd' ||
       ' default tablespace ' || default_tablespace ||
       ' temporary tablespace ' || temporary_tablespace || ';' "user"
from   dba_users
where  username = '&userid'
/

select 'alter user &newuser quota '||
       decode(max_bytes, -1, 'unlimited'
       ,                     ceil(max_bytes / 1024 / 1024) || 'M') ||
       ' on ' || tablespace_name || ';'
from   dba_ts_quotas
where  username = '&&userid'
/

select 'grant ' ||granted_role || ' to &newuser' ||
       decode(admin_option, 'NO', ';', 'YES', ' with admin option;') "ROLE"
from   dba_role_privs
where  grantee = '&&userid'
/

select 'grant ' || privilege || ' to &newuser' ||
       decode(admin_option, 'NO', ';', 'YES', ' with admin option;') "PRIV"
from   dba_sys_privs
where  grantee = '&&userid'
/

spool off

undefine user

set verify on
set feedback on
set heading on

@c:\temp\&newuser..sql

--!rm /tmp/user_clone_tmp.sql