connect target sys/sys
run { allocate channel c1 type disk ;
allocate channel c2 type disk ;
restore datafile 6;
recover datafile 6;
sql 'alter database open';}