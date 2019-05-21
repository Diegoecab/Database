--ps_mon_sessions.sql
set lines 1000
set pages 10000
set head on
set feed off
set verify off
alter session set current_schema=DBADMIN;
alter session set nls_date_format='DD-MON-YY';
ACCEPT bdate DATE FORMAT 'dd-mon-yy' DEFAULT '01-NOV-14'-
PROMPT 'Enter date for "Book date (from):  '
ACCEPT edate DATE FORMAT 'dd-mon-yy' DEFAULT '01-DEC-14'-
PROMPT 'Enter date for "Book date (end):  '
ACCEPT spool_name CHAR FORMAT 'A50' DEFAULT 'c:\temp\ps_mon_sessions_&bdate-&edate-.txt'-
PROMPT 'Enter file name [c:\temp\ps_mon_sessions_&bdate-&edate-.txt]:  '
spool &spool_name
select to_char(log_date,'dd/mm/yy hh24:mi') log_date, a.user_id, user_name, full_name,
decode(browser_name,'safari','Chrome') browser_name, 
remote_address, decode(log_type,'I','IN','O','OUT') log_type
 from ps_mon_sessions a, ps_mon_users b
 where b.user_id = a.user_id
 and log_date between '&bdate'  and '&edate'
 order by log_date;
spool off