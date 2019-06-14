spool log to c:\oracle\disco2\rman_logs\rman_log.log
run { allocate channel c1 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
backup datafile 3;}
exit;