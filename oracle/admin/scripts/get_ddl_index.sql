set heading off;
set echo off;
set verify off;
Set pages 999;
set feedback off
set long 90000;
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', true);
accept OWNER prompt 'Ingrese Owner: '
select 'set timing on' from dual;
select 'prompt Creando indice '||owner||'.'||index_name||' ...'
||dbms_metadata.get_ddl('INDEX',index_name,'&OWNER') from dba_indexes
where owner=upper('&OWNER');
set feedback on