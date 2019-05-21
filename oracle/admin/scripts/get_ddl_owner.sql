set heading off;
set echo off;
Set pages 999;
set feedback off
set long 90000;
accept OWNER prompt 'Ingrese Owner: '
select dbms_metadata.get_ddl('TABLE',table_name,'&OWNER') from dba_tables
where owner=upper('&OWNER');
set feedback on