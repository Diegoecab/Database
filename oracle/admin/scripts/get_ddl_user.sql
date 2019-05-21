set heading off
set echo off
set pages 9999
set feed off
set verify off
set long 90000
set long 200000 pages 0 lines 131
col meta format a121 word_wrapped

exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', true);
accept username prompt 'username: '

prompt prompt Create user ...
select dbms_metadata.get_ddl('USER', upper('&&username')) meta from dual;
prompt prompt system privileges ...
select dbms_metadata.get_granted_ddl('SYSTEM_GRANT', upper('&&username')) meta from dual;
prompt prompt objects provileges ...
select dbms_metadata.get_granted_ddl('OBJECT_GRANT', upper('&&username')) meta from dual;
prompt prompt role privileges ...
select dbms_metadata.get_granted_ddl('ROLE_GRANT', upper('&&username')) meta from dual;


Prompt ver dba_ts_quotas.sql