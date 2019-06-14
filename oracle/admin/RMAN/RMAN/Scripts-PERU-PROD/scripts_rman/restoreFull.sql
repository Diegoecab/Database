connect target sys/sys
run { allocate channel c1 type disk;
allocate channel c2 type disk;
allocate channel c3 type disk;
restore database;
recover database;
sql 'alter database open';}