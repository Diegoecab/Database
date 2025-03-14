--dba_role_privs

set verify off
undefine all
set define on
col stmt for a90
col granted_role for a30
col grantee for a20
col admin_option for a10
col default_role for a10


select grantee,granted_role,admin_option,default_role, case
when admin_option = 'NO' then
lower('grant '||granted_role||' to '||grantee||';')
when admin_option= 'YES' then
lower('grant '||granted_role||' to '||grantee||' with admin option;')
else '???'
end stmt
 from dba_role_privs 
where grantee like upper('%&grantee%')
and granted_role like upper('%&granted_role%')
and admin_option like upper('%&admin_option%')
and default_role like upper('%&default_role%')
order by 1,2
/
