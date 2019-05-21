accept p_owner prompt "Enter owner: "
accept p_dblinkname prompt "Enter dblink name: "
accept p_dblinkuser prompt "Enter dblink user: "
accept p_dblinkpassword prompt "Enter dblink password: "
accept p_dblinkalias prompt "Enter dblink alias or conection string: "

-- whenever sqlerror exit 1

create procedure &p_owner..dblink_create
is
begin
execute immediate 'create database link &p_dblinkname connect to &p_dblinkuser identified by &p_dblinkpassword using ''&p_dblinkalias''';
end;
/

column c_count noprint new_value v_count

select COUNT(*) c_count
from dba_sys_privs 
where grantee = upper('&p_owner') 
and privilege = 'CREATE DATABASE LINK';

begin
If &v_count = 0 then
execute immediate 'grant create database link to &p_owner';
end if;
end;
/

exec &p_owner..dblink_create;

begin
if &v_count = 0 then
execute immediate 'revoke create database link from &p_owner';
end if;
end;
/

drop procedure &p_owner..dblink_create;


select owner, object_type, object_name, status from dba_objects where object_name = 'DBLINK_CREATE' and owner = upper('&p_owner');
