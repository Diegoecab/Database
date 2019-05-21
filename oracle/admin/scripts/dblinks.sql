set serveroutput on
set long 10000000

declare
uid number;

v_tgt_user varchar2(30);
v_dblink varchar2(30) := 'fctudwp';
v_host varchar2(50) := 'fctudwp';
sqltext varchar2(1000);
sqltext_drop varchar2(1000);

myint integer;
begin

	for schemas in (
	       	select username 
		from all_users 
		where username in ( 'UYMN_AML' )
	)
	loop
		begin
			select user_id into uid from all_users where username=schemas.username;
			select lower(substr(schemas.username,5,instr( substr(schemas.username,5),'_AML',1)-1)) into v_tgt_user from dual;
			--v_tgt_user:=schemas.username;
			sqltext_drop :='drop DATABASE LINK "'||v_dblink||'"';
			sqltext :='CREATE DATABASE LINK "'||v_dblink||'" CONNECT TO '||v_tgt_user||'_pfg_link'||' IDENTIFIED BY "'||v_tgt_user||'_pfg_pass01"'||' USING '''||v_host||'''';
			myint:=sys.dbms_sys_sql.open_cursor();
			--sys.dbms_output.put_line(sqltext_drop);
			begin
				sys.dbms_sys_sql.parse_as_user(myint,sqltext_drop,dbms_sql.native,UID);
			exception
			when others then
				dbms_output.put_line('Cannot drop database link in '||schemas.username||' -> '||SQLERRM); 
			end;
			execute immediate 'grant create database link to '||schemas.username;
			sys.dbms_output.put_line(sqltext);
			sys.dbms_sys_sql.parse_as_user(myint,sqltext,dbms_sql.native,UID);
			sys.dbms_sys_sql.close_cursor(myint);
			dbms_output.put_line('link created successfully in '||schemas.username); 
		exception
		when others
			then
				dbms_output.put_line('error creating link in '||schemas.username||' -> '||SQLERRM); 
		end;
	end loop;
end ;
/

