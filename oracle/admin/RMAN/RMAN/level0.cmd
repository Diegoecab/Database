run {allocate channel c1 type disk format = 'c:\diego\oracle\rman\standb\%u.bkp';
allocate channel c2 type disk format = 'c:\diego\oracle\rman\standb\%u.bkp';
allocate channel c3 type disk format = 'c:\diego\oracle\rman\standb\%u.bkp';
sql 'alter system switch logfile';
backup incremental level = 0 database plus archivelog delete input;}
