declare
uid number;

pass varchar(50) := '05BE3869C7C6812D21BAE482717B98242B';
host varchar(50) := 'CDWDEV';
sqltext varchar2(1000) :='CREATE DATABASE LINK "CORDW.DCS.CITICORP.COM" CONNECT TO "EXT$CO_AML" IDENTIFIED BY VALUES '''||pass||''' USING '''||host||'''';

myint integer;
begin
select user_id into uid from all_users where username like 'EXT$COMN_AML';
myint:=sys.dbms_sys_sql.open_cursor();
sys.dbms_output.put_line(sqltext);
sys.dbms_sys_sql.parse_as_user(myint,sqltext,dbms_sql.native,UID);
sys.dbms_sys_sql.close_cursor(myint);
end ;
/
