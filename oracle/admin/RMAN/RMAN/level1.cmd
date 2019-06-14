run {allocate channel c1 type disk format = 'c:\diego\oracle\rman\dtest\%u.bkp';
allocate channel c2 type disk format = 'c:\diego\oracle\rman\dtest\%u.bkp';
allocate channel c3 type disk format = 'c:\diego\oracle\rman\dtest\%u.bkp';
backup incremental level = 1 database plus archivelog;}