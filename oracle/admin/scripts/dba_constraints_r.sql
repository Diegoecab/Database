--dba_constraints_r
set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col r_owner for a20
col column_name for a20
accept OWNER prompt 'Ingrese Owner: '
accept TABLA prompt 'Ingrese Tabla: '
ttitle 'Constraints que hacen referencia a la tabla &OWNER - &TABLA'
select owner,table_name,constraint_name,constraint_type,
r_constraint_name,status 
from dba_constraints where r_owner= UPPER('&OWNER')
and r_constraint_name in (select constraint_name
from dba_constraints where table_name = upper('&TABLA')
and owner = UPPER('&OWNER') 
)
order by 1,2;
ttitle off