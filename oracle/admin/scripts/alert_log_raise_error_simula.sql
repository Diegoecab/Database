declare
a exception;
pragma exception_init(a,-600);
begin
raise a;
end;
/



declare
a exception;
pragma exception_init(a,-4031);
begin
raise a;
end;
/



exec sys.dbms_system.ksdwrt(2, 'ORA-4031: testing');
commit;