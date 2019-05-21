set serveroutput on
set pages 80
set lines 185

--exec dbms_output.put_line('Sqlset name: ');
PROMPT Sqlset name:
define name=&1
--exec dbms_output.put_line('Sqlset description: ');
PROMPT Sqlset description
define description=&2

begin
	dbms_sqltune.create_sqlset(
		sqlset_name => '&name',
		description => '&description');
end;
/
