run {
set archivelog destination to '/d00/backup/';
restore archivelog all; }



backup format '/archive/%d_%s_%p_%c_%t.arc.bkp'
archivelog from sequence 89710 until sequence 1050;



run {
allocate channel d1 type disk;
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
backup FILESPERSET 2 archivelog from sequence 89710 thread 1 format '/oracle_temp/oracle_temp/arc_%d_%T_s%sp%p.%t';
}



rman auxiliary / catalog rman/trivia05@RIO40

rman target sys/R3Y1m#ZbPsrE+0xc4KkT@CDB196 catalog rman/trivia05@RIO40 auxiliary /

run {
 set archivelog destination to '/oracle_temp/temp';
 restore clone archivelog from sequence 89710 until sequence 89716;
}




