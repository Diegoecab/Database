--v$log_history.sql

alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
select sequence#, first_time from v$log_history 
where first_time > &first_time
order by sequence#
/