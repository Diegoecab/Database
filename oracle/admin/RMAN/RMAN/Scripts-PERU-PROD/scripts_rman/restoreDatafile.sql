connect target sys/sys
run { allocate channel c1 type disk ;
allocate channel c2 type disk ;
sql 'alter database datafile n� offline';
restore datafile n�;
recover datafile n�;
sql 'alter database datafile n� online';}