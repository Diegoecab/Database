accept p_owner prompt "Enter owner: "
accept p_dblinkname prompt "Enter dblink name: "

-- whenever sqlerror exit 1

create procedure &p_owner..dblink_drop
is
begin
execute immediate 'drop database link &p_dblinkname';
end;
/

column c_count noprint new_value v_count

select COUNT(*) c_count
from dba_sys_privs 
where (grantee in ( select granted_role from dba_role_privs where grantee = upper('&p_owner') )
or grantee = upper('&p_owner') )
and privilege = 'CREATE DATABASE LINK';

begin
if &v_count = 0 then
execute immediate 'grant create database link to &p_owner';
end if;
end;
/

exec &p_owner..dblink_drop;

begin
if &v_count = 0 then
execute immediate 'revoke create database link from &p_owner';
end if;
end;
/

drop procedure &p_owner..dblink_drop;


select owner, object_type, object_name, status from dba_objects where object_name = 'DBLINK_DROP' and owner = upper('&p_owner');
