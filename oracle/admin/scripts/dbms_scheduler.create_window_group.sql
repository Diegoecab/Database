--dbms_scheduler.create_window_group.sql

begin
dbms_scheduler.create_window_group ('&window_group_name');
end;
/
