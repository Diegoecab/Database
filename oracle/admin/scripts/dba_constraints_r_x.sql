set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col column_name for a20
accept OWNER prompt 'Ingrese Owner: '
accept TABLA prompt 'Ingrese Tabla: '
ttitle 'FK de la tabla &OWNER - &TABLA'
select 
a.constraint_name, b.owner r_owner, b.table_name r_table_name,
a.r_constraint_name, 
a.status, b.status r_status
from dba_constraints a join dba_constraints b
on b.constraint_name=a.r_constraint_name
and b.owner=a.r_owner
where a.owner= upper ('&OWNER') and
a.table_name=upper('&TABLA') and
a.constraint_type = 'R'
order by 1,2;
ttitle off