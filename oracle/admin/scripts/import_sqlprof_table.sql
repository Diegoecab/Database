--import_sqlprof_table.sql
set serveroutput on

accept staging_table prompt 'Enter value for staging_table: '
accept schema_name prompt 'Enter value for schema_name: '

begin
dbms_sqltune.unpack_stgtab_sqlprof(replace => true,staging_table_name => '&staging_table', staging_schema_owner => '&schema_name');
commit;
end;
/
