--dba_sys_privs

set verify off
undefine all
set define on

col privilege for a40
col grantee for a30
set lines 400

select grantee,privilege,admin_option, case
when admin_option = 'NO' then
lower('grant '||privilege||' to '||grantee||';')
when admin_option= 'YES' then
lower('grant '||privilege||' to '||grantee||' with grant option;')
else '???'
end stmt
 from dba_sys_privs 
where grantee like upper('%&grantee%')
and privilege like upper('%&privilege%')
and admin_option like upper('%&admin_option%')
order by 1,2
/