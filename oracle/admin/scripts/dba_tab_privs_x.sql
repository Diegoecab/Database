set verify off
col owner for a10
col grantee for a20
col grantor for a10
col privilege for a20
set lines 300

select * from dba_tab_privs where 
grantee like upper('%&grantee%')
and owner like upper('%&owner%') 
and table_name like upper('%&table_name%')
and grantor like upper('%&grantor%')
and privilege like upper('%&privilege%')
and grantable like upper('%&grantable%')
order by 1,2,3
/