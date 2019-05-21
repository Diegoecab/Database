select * from dba_role_privs where granted_role like upper ('%&1%') and
grantee like upper ('%&2%')
order by 1,2
/