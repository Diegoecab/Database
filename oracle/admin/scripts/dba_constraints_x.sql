set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col column_name for a20
accept OWNER prompt 'Ingrese Owner: '
accept TABLA prompt 'Ingrese Tabla: '

select constraint_name,constraint_type,r_owner,r_constraint_name,status from dba_constraints where owner=UPPER('&OWNER') and table_name=upper('&TABLA') order by 1,2;

select constraint_name,column_name,position from dba_cons_columns where owner=UPPER('&OWNER') and table_name=upper('&TABLA') order by 1,2;