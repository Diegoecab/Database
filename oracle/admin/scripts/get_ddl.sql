set heading off;
set echo off;
Set pages 999;
set feedback off
set long 90000;
accept OWNER prompt 'Ingrese Owner: '
accept TYPE prompt 'Ingrese tipo Objeto: '
accept NAME prompt 'Ingrese Nombre de objeto: '
col ddl for a900
set long 900
set lines 900
set pages 1000
set head off
set feed off

BEGIN
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', false);
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SEGMENT_ATTRIBUTES', false);
 DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'STORAGE', false);
END;
/
select dbms_metadata.get_ddl('&TYPE','&NAME','&OWNER') from dual;
set feedback on