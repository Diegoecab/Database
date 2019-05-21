--dba_constraints
set pages 1000
set verify off
set lines 400
set feedback off
set trims on
undefine all
clear col
col column_name for a30


select owner,table_name,constraint_name,constraint_type,r_owner,r_constraint_name,status 
from dba_constraints
where owner like upper('%&owner%') 
and table_name like upper('%&tabla%')
and constraint_type like upper ('%&constraint_type%')
and constraint_name like upper ('%&constraint_name%')
and status like upper ('%&status%')
order by 1,2
/

select owner,table_name,constraint_name,column_name,position from dba_cons_columns 
where owner=upper('&owner') 
and table_name=upper('&tabla')
order by 1,2
/