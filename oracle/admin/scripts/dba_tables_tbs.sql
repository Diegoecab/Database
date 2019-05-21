set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
accept Tablespace prompt 'Ingrese Tablespace: '

select OWNER,TABLE_NAME from dba_tables where tablespace_name=upper('&TABLESPACE') order by 1,2;