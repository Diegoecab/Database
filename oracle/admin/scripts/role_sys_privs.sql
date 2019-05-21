--role_sys_privs

set verify off
undefine all
set define on

select role,privilege,admin_option from
role_sys_privs
where role like upper('%&role%')
and privilege like upper('%&privilege%')
and admin_option like upper('%&admin_option%')
order by 1,2
/