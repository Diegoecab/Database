set head off
set echo off
set pages 999
set feed off
set long 90000


select dbms_metadata.get_ddl('TABLE',table_name,owner)
from dba_tables
where owner like upper('%&owner%') 
and table_name like upper('%&table_name%')
/

set feed on