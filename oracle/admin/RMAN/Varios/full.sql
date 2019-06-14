spool log to c:\oracle\disco2\rman_logs\rman_log.log
run { allocate channel c1 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
allocate channel c2 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
allocate channel c3 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
backup incremental level=0 database include current controlfile;}
run {sql 'alter system archive log current';
allocate channel c1 type disk format ='C:\oracle\disco2\rman\%d_%u_%t.bkp';
backup archivelog all delete all input;
sql 'alter system archive log start';}
backup copies 1 database format 'c:\oracle\disco3\rman\%d_%u_%t.bkp2';
exit;