run {
CONFIGURE CHANNEL DEVICE TYPE DISK MAXPIECESIZE 2G;
allocate channel d1 type disk;
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
allocate channel d5 type disk;
allocate channel d6 type disk;
allocate channel d7 type disk;
allocate channel d8 type disk;
allocate channel d9 type disk;
allocate channel d10 type disk;
BACKUP 
TAG = 'PRE_UPGRADE'
FORMAT '/backup/db/emrep_dbf_%d_%T_s%sp%p.%t'
DATABASE
CURRENT CONTROLFILE
  FORMAT '/backup/db/emrep_control_%d_C_%T_%u'
  SPFILE
  FORMAT '/backup/db/emrep_spfile_%d_S_%T_%u';
}



export ORAENV_ASK=NO
export ORACLE_SID=ibscn2
. oraenv
rman target / cmdfile=/home/oracle/scripts/ibscn/rman_full.rman log=/home/oracle/scripts/ibscn/rman_full.log



/home/oracle/scripts/ibscn/rman_full.sh