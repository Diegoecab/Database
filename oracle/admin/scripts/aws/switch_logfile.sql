select sequence# from v$log where status='CURRENT';
exec rdsadmin.rdsadmin_util.switch_logfile;
select sequence# from v$log where status='CURRENT';
