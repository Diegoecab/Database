--dba_dependencies.sql

desc dba_dependencies

set lines 400
set verify off

select * from dba_dependencies
where owner like upper('%&owner%') 
and name like upper('%&name%')
and type like upper('%&type%')
and referenced_owner like upper('%&referenced_owner%')
and referenced_name like upper('%&referenced_name%')
and referenced_type like upper('%&referenced_type%')
order by 1,2,3
/