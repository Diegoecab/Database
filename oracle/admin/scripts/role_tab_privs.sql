--role_tab_privs

set verify off
undefine all
set define on

select * from
role_tab_privs
where role like upper('%&role%')
and owner like upper('%&owner%')
and table_name like upper('%&table_name%')
and column_name like upper('%&column_name%')
and privilege like upper('%&privilege%')
and grantable like upper('%&grantable%')
order by 1,2,3
/