set serveroutput on

exec dbms_output.put_line('Sqlset name: ');
define name=&1
exec dbms_output.put_line('Sqlset schema: ');
define schema=&2

declare
c_sql dbms_sqltune.sqlset_cursor;
filter varchar2(300) :='parsing_schema_name = '''||'&schema'||'''';
BEGIN
	--dbms_output.put_line(filter);
	open c_sql for
	select value(p)
	from table( dbms_sqltune.select_workload_repository (
			&snap_begin,
			&snap_end,
			basic_filter => filter) 
	) p;

	dbms_sqltune.load_sqlset (
				sqlset_name => '&name',
				populate_cursor => c_sql
				);

	close c_sql;
END;
/
