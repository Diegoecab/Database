connect target sys/sys
run { allocate channel c1 type disk ;
allocate channel c2 type disk ;
set until time= '2007-07-02:10:30:00';
restore database;
recover database
ALTER DATABASE OPEN RESETLOGS;}