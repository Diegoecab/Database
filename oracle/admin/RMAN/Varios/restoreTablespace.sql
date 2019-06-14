connect target sys/sys
run { allocate channel c1 type disk ;
allocate channel c2 type disk ;
sql 'alter tablespace nombre offline immediate';
restore tablespace nombre;
recover tablespace nombre;
sql 'alter tablespace nombre online';}