set heading off;
set echo off;
Set pages 999;
set feedback off
set long 90000;
accept OWNER prompt 'Ingrese Owner: '
accept TYPE prompt 'Ingrese tipo Objeto: '
accept NAME prompt 'Ingrese Nombre de objeto: '
select dbms_metadata.get_ddl('&TYPE','&NAME','&OWNER') from dual;
set feedback on