--copy_sqlprof_table.sql

accept staging_table prompt 'Enter value for staging_table: '
accept schema_name prompt 'Enter value for schema_name: '
accept sql_profile_id prompt 'Enter value for sql_profile_id: '

begin
DBMS_SQLTUNE.CREATE_STGTAB_SQLPROF (table_name=>'&staging_table',schema_name=>'&schema_name'); 
commit;
end;
/

begin
DBMS_SQLTUNE.PACK_STGTAB_SQLPROF ( staging_schema_owner => '&schema_name', staging_table_name => '&staging_table',profile_name=>'&sql_profile_id');
end;
/