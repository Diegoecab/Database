--dba_hist_undostat_usagehist
set pages 30
@nls_Date
select * from(
select INSTANCE_NUMBER, TO_CHAR (begin_time, 'DD-MON-RR HH24:MI') begin_Time, 
max(MAXQUERYSQLID),	--SQL identifier of the longest running SQL statement in the period
round((max(UNEXPIREDBLKS)*8192)/1024/1024/1024)UNEXPIREDBLKS_GB, 
round((max(EXPIREDBLKS)*8192)/1024/1024/1024)EXPIREDBLKS_GB,
round((max(ACTIVEBLKS)*8192)/1024/1024/1024)ACTIVEBLKS_GB,
round((sum(ACTIVEBLKS+UNEXPIREDBLKS+expiredblks)*8192)/1024/1024/1024) total_usage
from dba_hist_undostat where begin_time > sysdate-(nvl('&sysdate',1))
group by INSTANCE_NUMBER, TO_CHAR (begin_time, 'DD-MON-RR HH24:MI')
order by to_date(begin_time)
) 
where 
total_usage > nvl('&total_usage',0)
/
