CREATE OR REPLACE TRIGGER on_logon after logon on dc22057.schema
begin
execute immediate('insert into dc22057.dba_tables_dc select * from dba_tables');
commit;
end; 
/