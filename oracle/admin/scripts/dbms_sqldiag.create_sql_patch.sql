
DECLARE
   patch_name varchar2(100);
BEGIN
patch_name := dbms_sqldiag.create_sql_patch(
sql_id=>'g06d5qs35kkvf',
hint_text=>' FULL(@"SEL$58A6D7F6" "C"@"SEL$1")');
end;
/
	
	
	
	
DECLARE
   patch_name varchar2(100);
BEGIN
dbms_sqldiag.drop_sql_patch(name => 'SYS_SQLPTCH_0172be451e100000'
);
end;
/
	
	
	
	
	DECLARE
   patch_name varchar2(100);
BEGIN
patch_name := dbms_sqldiag.disable_sql_patch(
'SYS_SQLPTCH_0172be451e100000'
);
end;
/
	patch_name := dbms_sqldiag.create_sql_patch(