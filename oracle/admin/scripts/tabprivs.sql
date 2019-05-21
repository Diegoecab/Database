set linesize 180
col grantor format a10
col grantee format a20
col table_name format a30
col grantable format a4
select grantor, grantee, table_name, grantable, privilege 
from dba_tab_privs where table_name like upper('%&1%')
and grantee like upper('%&2%')
order by 1,2,3
/
