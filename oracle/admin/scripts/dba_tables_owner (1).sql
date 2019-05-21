set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
accept Owner prompt 'Ingrese Owner: '

select TABLESPACE_NAME, TABLE_NAME from dba_tables where owner= upper('&OWNER') order by 1,2;
