connect target sys/sys
run { allocate channel c1 type disk ;
allocate channel c2 type disk ;
sql 'alter database datafile nº offline';
restore datafile nº;
recover datafile nº;
sql 'alter database datafile nº online';}