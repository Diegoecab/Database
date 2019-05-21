prompt Usuarios que contienen un rol
select distinct grantee from dba_role_privs where granted_role=upper('&ROLE')
/
