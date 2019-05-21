--dbms_scheduler.add_window_group_member.sql
@dba_scheduler_window_groups.sql
@dba_scheduler_windows.sql

begin
dbms_scheduler.add_window_group_member (
   group_name   =>  '&group_name',
   window_list  =>  '&window_list_sep_coma');
end;
/