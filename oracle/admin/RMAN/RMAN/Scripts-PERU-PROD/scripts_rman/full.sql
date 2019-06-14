spool log to /gemini/DbBackup/GEMPROD/rman/logs/rman_log.log
run { allocate channel c1 type disk format ='/gemini/DbBackup/GEMPROD/rman/%d_%u_%t.bkp';
backup incremental level=0 database include current controlfile;}
run {sql 'alter system archive log current';
allocate channel c1 type disk format ='/gemini/DbBackup/GEMPROD/rman/%d_%u_%t.bkp';
backup archivelog all;
sql 'alter system archive log start';}
exit;
