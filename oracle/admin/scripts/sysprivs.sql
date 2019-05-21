set linesize 180

col grantor format a10
col grantee format a20
col table_name format a30
col grantable format a4

select *
from dba_sys_privs where privilege like upper('&1%')
and grantee like upper('%&2%')
order by 1,2
/
