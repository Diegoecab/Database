set heading off;
set echo off;
set verify off;
Set pages 999;
set feedback off
set long 90000;
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', true);
accept PROFILE prompt 'Ingrese PERFIL: '
select dbms_metadata.get_ddl('PROFILE','&PROFILE') from dual;
set feedback on