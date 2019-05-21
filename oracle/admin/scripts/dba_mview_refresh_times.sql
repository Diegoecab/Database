--dba_mview_refresh_times
set lines 400
@nls_date
select * from 
dba_mview_refresh_times
order by last_refresh
/