--dbms_scheduler.drop_window.sql

@dba_scheduler_windows.sql

begin
dbms_scheduler.drop_window ('&window_list_sep_coma');
end;
/
