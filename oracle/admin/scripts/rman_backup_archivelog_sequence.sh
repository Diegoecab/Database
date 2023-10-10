run {
allocate channel d1 type disk;
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
allocate channel d5 type disk;
allocate channel d6 type disk;
backup FILESPERSET 2 archivelog from sequence 5004 thread 1 format '/export/incr/arc_%d_%T_s%sp%p.%t';
}



run {
crosscheck archivelog all;
allocate channel d1 type disk;
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
allocate channel d5 type disk;
allocate channel d6 type disk;
restore archivelog from sequence 5118 thread 1 until sequence 5184 thread 1;
}




5243

5184