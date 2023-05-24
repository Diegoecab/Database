How to achieve alternate client restore with RMAN and Tivoli (Doc ID 265595.1)
Step by Step Guide on Creating Physical Standby Using RMAN DUPLICATE...FROM ACTIVE DATABASE (Doc ID 1075908.1)
RMAN DUPLICATE / RESTORE including Standby in ASM with OMF / non-OMF / Mixed Name for Datafile / Online Log / Controlfile (Doc ID 1910175.1)


RIO196 BIS
deshabilitar jobs de base

rman target /


rman auxiliary / catalog rman/trivia05@RIO40




run {
ALLOCATE auxiliary CHANNEL C1 DEVICE TYPE 'SBT_TAPE';
ALLOCATE auxiliary CHANNEL C2 DEVICE TYPE 'SBT_TAPE';
ALLOCATE auxiliary CHANNEL C3 DEVICE TYPE 'SBT_TAPE';
ALLOCATE auxiliary CHANNEL C4 DEVICE TYPE 'SBT_TAPE';
duplicate database CDB196 dbid 1338822454 to CDB196B
  UNTIL TIME 'Apr 12 2021 12:00:00'
  db_file_name_convert '/RIO196/data01/CDB196/','+PDC_DATA','/RIO196/fra/CDB196/','+PDC_DATA',
  spfile
  parameter_value_convert 'ORAprim','ORAaux'
  set log_file_name_convert 'RIO196','+PDC_DATA';
} 


export ORACLE_SID=CDBLAB1B;

rman auxiliary / catalog rman/trivia05@RIO40

Restore a otra base:
startup clone nomount; # pfile=/tmp/pfiletemp_CDBLAB1B.ora;
run {
ALLOCATE auxiliary CHANNEL C1 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C2 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C3 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C4 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
duplicate database CDBLAB1 dbid 255100080 to CDBLAB1B
  #UNTIL TIME "to_date('12-APR-2021 00:00:00','DD-MON-YYYY HH24:MI:SS')"
  spfile
  PARAMETER_VALUE_CONVERT 'RIOLAB1_DATA', 'PDC_DATA','RIOLAB1_FRA','PDC_FRA','CDBLAB1','CDBLAB1B'
  SET "db_unique_name"="CDBLAB1B" 
  set "audit_file_dest"="/tmp/" comment "Temporal, luego sacar"
  set log_file_name_convert '+RIOLAB1_DATA','+PDC_DATA','+RIOLAB1_FRA','+PDC_FRA'
  set db_file_name_convert '+RIOLAB1_DATA','+PDC_DATA','+RIOLAB1_FRA','+PDC_FRA'
  nofilenamecheck;
}




Opcion for standby:

1. En prod


oratechdbsrv01

alter database force logging;


nohup /oracle/backup_rman/backup_scripts/run_backup.ksh CDBLAB1 HOT 8 DAILY Y N &

[oracle@oratechdbsrv01 logs]$ . oraenv
ORACLE_SID = [oracle] ? CDBLAB1

SQL> select dbid,db_unique_name from v$database;

      DBID DB_UNIQUE_NAME
---------- ------------------------------
 255100080 CDBLAB1




export ORACLE_SID=$1
export BACKUP_TYPE=$2
export CHANNEL_COUNT=$3
export RETENTION=$4
export PURGE_ARCH=$5
export INC_BKP=$6
export FORCE_FULL=$7
export NC=$8


Standby redologs

Proper Standby Redo Log Placement and Creation
Once the online redo logs have been appropriately sized you should create standby redo logs of the same size. It is
critical for performance that standby redo log groups only contain a single member. In addition, for each redo log
thread (a thread is associated with an Oracle RAC database instance), the number of Standby Redo Logs = number
of Redo Log Groups + 1. Be sure to place single member standby redo log groups in the fastest available diskgroup.
The objective is to have standby log file write times that are comparable to log file I/O on the primary database
optimal redo apply performance. 


select group#, thread#, sequence#, archived, ROUND (BYTES / 1024 / 1024) mb, status from v$standby_log;

col status for a10

SELECT group#, thread#, sequence#, ROUND (BYTES / 1024 / 1024) mb, members,
       archived, status, first_change#, first_time
  FROM v$log;

SQL> SQL>   2    3
    GROUP#    THREAD#  SEQUENCE#         MB    MEMBERS ARC STATUS     FIRST_CHANGE# FIRST_TIM
---------- ---------- ---------- ---------- ---------- --- ---------- ------------- ---------
         1          1        880        200          2 YES INACTIVE        31350384 11-APR-21
         2          1        881        200          2 YES INACTIVE        31351130 11-APR-21
         3          1        894        200          2 NO  CURRENT         31758000 13-APR-21
         4          1        882        200          2 YES INACTIVE        31398507 11-APR-21
         5          1        883        200          2 YES INACTIVE        31441215 12-APR-21
         6          1        884        200          2 YES INACTIVE        31481671 12-APR-21
         7          1        885        200          2 YES INACTIVE        31521227 12-APR-21
         8          1        886        200          2 YES INACTIVE        31522405 12-APR-21
         9          1        887        200          2 YES INACTIVE        31538556 12-APR-21
        10          1        888        200          2 YES INACTIVE        31572050 12-APR-21
        11          1        889        200          2 YES INACTIVE        31622198 13-APR-21
        12          1        890        200          2 YES INACTIVE        31662855 13-APR-21
        13          1        891        200          2 YES INACTIVE        31702867 13-APR-21
        14          1        892        200          2 YES INACTIVE        31704127 13-APR-21
        15          1        893        200          2 YES INACTIVE        31757230 13-APR-21


set serveroutput on
set lines 600
begin
for r in 16..32 loop
dbms_output.put_line ('ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 GROUP '||r||' (''+RIOLAB1_FRA'')  SIZE 200M;');
end loop;
end;
/


set serveroutput on
begin
for r in 16..32 loop
dbms_output.put_line ('ALTER DATABASE DROP STANDBY LOGFILE GROUP '||r||';');
end loop;
end;
/


select group#, thread#, sequence#, archived, ROUND (BYTES / 1024 / 1024) mb, status from v$standby_log;


ALTER DATABASE FORCE LOGGING;


alter system set LOG_ARCHIVE_CONFIG='DG_CONFIG=(CDBLAB1,CDBLAB1B)';
alter system set FAL_SERVER=CDBLAB1B;
alter system set FAL_CLIENT=CDBLAB1;

alter system set LOG_ARCHIVE_DEST_2='SERVICE=CDBLAB1B LGWR ASYNC VALID_FOR=(ONLINE_LOGFILE,PRIMARY_ROLE) DB_UNIQUE_NAME=CDBLAB1B';
alter system set LOG_ARCHIVE_DEST_STATE_2=ENABLE;
alter system set log_archive_max_processes=10;




SQL> alter system set DB_FILE_NAME_CONVERT='/<path>/boston/data/','/<path>/chicago/data' scope=spfile;
System altered.

SQL> alter system set LOG_FILE_NAME_CONVERT='/<path>/boston/redo/','/<path>/chicago/redo' scope=spfile;
System altered.


2. En la standby

oraspdcp01

[oracle@oraspdcp01 config]$ cat /etc/oratab | grep 19
PDC:/oracle/app/oracle/product/19c:N
[oracle@oraspdcp01 config]$ . oraenv
ORACLE_SID = [PDC] ?
The Oracle base remains unchanged with value /oracle/app/oracle
[oracle@oraspdcp01 config]$ export ORACLE_SID=CDBLAB1B


rman auxiliary / catalog rman/trivia05@RIO40

startup clone nomount; #pfile=/tmp/pfiletemp_CDBLAB1B.ora;
run {
ALLOCATE auxiliary CHANNEL C1 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C2 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C3 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C4 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C5 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C6 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
set dbid 255100080;
duplicate target database for standby DORECOVER
  #UNTIL TIME "to_date('12-APR-2021 00:00:00','DD-MON-YYYY HH24:MI:SS')"
  spfile
  PARAMETER_VALUE_CONVERT 'RIOLAB1_DATA', 'PDC_DATA','RIOLAB1_FRA','PDC_FRA'
  SET "db_unique_name"="CDBLAB1B"
  set "audit_file_dest"="/tmp/" comment "Temporal, luego sacar"
  set log_file_name_convert '+RIOLAB1_DATA','+PDC_DATA','+RIOLAB1_FRA','+PDC_FRA'
  set db_file_name_convert '+RIOLAB1_DATA','+PDC_DATA','+RIOLAB1_FRA','+PDC_FRA'
  set fal_client='cdblab1b'
  set fal_server='cdblab1'
  set standby_file_management='MANUAL'
  set log_archive_config='dg_config=(cdblab1,cdblab1b)'
  set log_archive_dest_2='service=cdblab1 ASYNC valid_for=(ONLINE_LOGFILE,PRIMARY_ROLE) db_unique_name=cdblab1'
  set local_listener='oraspdcp01.iaas.ar.bsch:7365'
  set log_archive_max_processes='10'
  set job_queue_processes='0' comment "Temporal, luego dejar como produccion"
  nofilenamecheck;
}




RMAN> run {
ALLOCATE auxiliary CHANNEL C1 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C2 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C3 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C4 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C5 DEVICE TYPE2> 3> 4> 5> 6>  'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
ALLOCATE auxiliary CHANNEL C6 DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/tsmlogs/config/tdpo_CDBLAB1B.opt)';
set dbid 255100080;
duplicate target database for standby DORECOVER
  #UNTIL TIME "to_date('12-APR-2021 00:00:00','DD-MON-YYYY HH24:MI:SS')"
  spfile
  PARAMETER_VALUE_CONVERT 'RIOLAB1_DATA', 'PDC_DATA','RIOLAB1_FRA','PDC_FRA'
  SET "db_unique_name"="CDBLAB1B"
  set "audit_file_dest"="/tmp/" comment "Temporal, luego sacar"
  set log_file_name_convert '+RIOLAB1_DATA','+PDC_DATA','+RIOLAB1_FRA','+PDC_FRA'
  set db_file_name_convert '+RIOLAB1_DATA','+PDC_DATA','+RIOLAB1_FRA','+PDC_FRA'
  set fal_client='cdblab1b'
  set fal_server='cdblab1'
  set standby_file_management='MANUAL'
  set log_archive_config='dg_config=(cdblab1,cdblab1b)'
  set log_archive_dest_2='service=cdblab1 ASYNC valid_for=(ONLINE_LOGFILE,PRIMARY_ROLE) db_unique_name=cdblab1'
  nofilenamecheck;
}7> 8> 9> 10> 11> 12> 13> 14> 15> 16> 17> 18>

allocated channel: C1
channel C1: SID=150 device type=SBT_TAPE
channel C1: Data Protection for Oracle: version 8.1.9.0

allocated channel: C2
channel C2: SID=293 device type=SBT_TAPE
channel C2: Data Protection for Oracle: version 8.1.9.0

allocated channel: C3
channel C3: SID=434 device type=SBT_TAPE
channel C3: Data Protection for Oracle: version 8.1.9.0

allocated channel: C4
channel C4: SID=12 device type=SBT_TAPE
channel C4: Data Protection for Oracle: version 8.1.9.0

allocated channel: C5
channel C5: SID=151 device type=SBT_TAPE
channel C5: Data Protection for Oracle: version 8.1.9.0

allocated channel: C6
channel C6: SID=294 device type=SBT_TAPE
channel C6: Data Protection for Oracle: version 8.1.9.0

executing command: SET DBID

Starting Duplicate Db at 13-APR-21

contents of Memory Script:
{
   set until scn  31758000;
   restore clone spfile to  '/oracle/app/oracle/product/19c/dbs/spfileCDBLAB1B.ora';
   sql clone "alter system set spfile= ''/oracle/app/oracle/product/19c/dbs/spfileCDBLAB1B.ora''";
}
executing Memory Script

executing command: SET until clause

Starting restore at 13-APR-21

WARNING: A restore time was estimated based on the supplied UNTIL SCN
channel C1: starting datafile backup set restore
channel C1: restoring SPFILE
output file name=/oracle/app/oracle/product/19c/dbs/spfileCDBLAB1B.ora
channel C1: reading from backup piece c-255100080-20210413-05
channel C1: piece handle=c-255100080-20210413-05 tag=TAG20210413T230545
channel C1: restored backup piece 1
channel C1: restore complete, elapsed time: 00:00:03
Finished restore at 13-APR-21

sql statement: alter system set spfile= ''/oracle/app/oracle/product/19c/dbs/spfileCDBLAB1B.ora''

contents of Memory Script:
{
   sql clone "alter system set  control_files =
 ''+PDC_DATA/CDBLAB1/CONTROLFILE/current.260.1054472177'', ''+PDC_FRA/CDBLAB1/CONTROLFILE/current.256.1054472177'' comment=
 '''' scope=spfile";
   sql clone "alter system set  db_create_file_dest =
 ''+PDC_DATA'' comment=
 '''' scope=spfile";
   sql clone "alter system set  db_recovery_file_dest =
 ''+PDC_FRA'' comment=
 '''' scope=spfile";
   sql clone "alter system set  db_unique_name =
 ''CDBLAB1B'' comment=
 '''' scope=spfile";
   sql clone "alter system set  audit_file_dest =
 ''/tmp/'' comment=
 ''Temporal, luego sacar'' scope=spfile";
   sql clone "alter system set  log_file_name_convert =
 ''+RIOLAB1_DATA'', ''+PDC_DATA'', ''+RIOLAB1_FRA'', ''+PDC_FRA'' comment=
 '''' scope=spfile";
   sql clone "alter system set  db_file_name_convert =
 ''+RIOLAB1_DATA'', ''+PDC_DATA'', ''+RIOLAB1_FRA'', ''+PDC_FRA'' comment=
 '''' scope=spfile";
   shutdown clone immediate;
   startup clone nomount;
}
executing Memory Script

sql statement: alter system set  control_files =  ''+PDC_DATA/CDBLAB1/CONTROLFILE/current.260.1054472177'', ''+PDC_FRA/CDBLAB1/CONTROLFILE/current.256.1054472177'' comment=                                         '''' scope=spfile

sql statement: alter system set  db_create_file_dest =  ''+PDC_DATA'' comment= '''' scope=spfile

sql statement: alter system set  db_recovery_file_dest =  ''+PDC_FRA'' comment= '''' scope=spfile

sql statement: alter system set  db_unique_name =  ''CDBLAB1B'' comment= '''' scope=spfile

sql statement: alter system set  audit_file_dest =  ''/tmp/'' comment= ''Temporal, luego sacar'' scope=spfile

sql statement: alter system set  log_file_name_convert =  ''+RIOLAB1_DATA'', ''+PDC_DATA'', ''+RIOLAB1_FRA'', ''+PDC_FRA'' comment= '''' scope=spfile

sql statement: alter system set  db_file_name_convert =  ''+RIOLAB1_DATA'', ''+PDC_DATA'', ''+RIOLAB1_FRA'', ''+PDC_FRA'' comment= '''' scope=spfile

Oracle instance shut down

connected to auxiliary database (not started)
Oracle instance started

Total System Global Area    4194301760 bytes

Fixed Size                     9144128 bytes
Variable Size                788529152 bytes
Database Buffers            3388997632 bytes
Redo Buffers                   7630848 bytes
allocated channel: C1
channel C1: SID=773 device type=SBT_TAPE
channel C1: Data Protection for Oracle: version 8.1.9.0
allocated channel: C2
channel C2: SID=1144 device type=SBT_TAPE
channel C2: Data Protection for Oracle: version 8.1.9.0
allocated channel: C3
channel C3: SID=10 device type=SBT_TAPE
channel C3: Data Protection for Oracle: version 8.1.9.0
allocated channel: C4
channel C4: SID=392 device type=SBT_TAPE
channel C4: Data Protection for Oracle: version 8.1.9.0
allocated channel: C5
channel C5: SID=774 device type=SBT_TAPE
channel C5: Data Protection for Oracle: version 8.1.9.0
allocated channel: C6
channel C6: SID=11 device type=SBT_TAPE
channel C6: Data Protection for Oracle: version 8.1.9.0

contents of Memory Script:
{
   set until scn  31758000;
   sql clone "alter system set  control_files =
  ''+PDC_DATA/CDBLAB1B/CONTROLFILE/current.357.1069801921'', ''+PDC_FRA/CDBLAB1B/CONTROLFILE/current.316.1069801921'' comment=
 ''Set by RMAN'' scope=spfile";
   restore clone standby controlfile;
}
executing Memory Script

executing command: SET until clause

sql statement: alter system set  control_files =   ''+PDC_DATA/CDBLAB1B/CONTROLFILE/current.357.1069801921'', ''+PDC_FRA/CDBLAB1B/CONTROLFILE/current.316.1069801921'' commen                                        t= ''Set by RMAN'' scope=spfile

Starting restore at 13-APR-21

channel C1: starting datafile backup set restore
channel C1: restoring control file
channel C1: reading from backup piece c-255100080-20210413-04
channel C1: piece handle=c-255100080-20210413-04 tag=TAG20210413T230241
channel C1: restored backup piece 1
channel C1: restore complete, elapsed time: 00:00:03
output file name=+PDC_DATA/CDBLAB1B/CONTROLFILE/current.358.1069801923
output file name=+PDC_FRA/CDBLAB1B/CONTROLFILE/current.317.1069801923
Finished restore at 13-APR-21

contents of Memory Script:
{
   sql clone 'alter database mount standby database';
}
executing Memory Script

sql statement: alter database mount standby database
RMAN-05529: warning: DB_FILE_NAME_CONVERT resulted in invalid ASM names; names changed to disk group only.

contents of Memory Script:
{
   set until scn  31758000;
   set newname for tempfile  1 to
 "+PDC_DATA";
   set newname for tempfile  2 to
 "+PDC_DATA";
   set newname for tempfile  3 to
 "+PDC_DATA";
   switch clone tempfile all;
   set newname for datafile  1 to
 "+PDC_DATA";
   set newname for datafile  3 to
 "+PDC_DATA";
   set newname for datafile  4 to
 "+PDC_DATA";
   set newname for datafile  5 to
 "+PDC_DATA";
   set newname for datafile  6 to
 "+PDC_DATA";
   set newname for datafile  7 to
 "+PDC_DATA";
   set newname for datafile  8 to
 "+PDC_DATA";
   set newname for datafile  9 to
 "+PDC_DATA";
   set newname for datafile  10 to
 "+PDC_DATA";
   set newname for datafile  11 to
 "+PDC_DATA";
   set newname for datafile  12 to
 "+PDC_DATA";
   set newname for datafile  13 to
 "+PDC_DATA";
   set newname for datafile  14 to
 "+PDC_DATA";
   restore
   clone database
   ;
}
executing Memory Script

executing command: SET until clause

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

renamed tempfile 1 to +PDC_DATA in control file
renamed tempfile 2 to +PDC_DATA in control file
renamed tempfile 3 to +PDC_DATA in control file

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

Starting restore at 13-APR-21

channel C1: starting datafile backup set restore
channel C1: specifying datafile(s) to restore from backup set
channel C1: restoring datafile 00013 to +PDC_DATA
channel C1: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_ivvs72nm_1_1.bkp
channel C2: starting datafile backup set restore
channel C2: specifying datafile(s) to restore from backup set
channel C2: restoring datafile 00014 to +PDC_DATA
channel C2: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_j0vs72nn_1_1.bkp
channel C3: starting datafile backup set restore
channel C3: specifying datafile(s) to restore from backup set
channel C3: restoring datafile 00009 to +PDC_DATA
channel C3: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_j2vs72no_1_1.bkp
channel C4: starting datafile backup set restore
channel C4: specifying datafile(s) to restore from backup set
channel C4: restoring datafile 00004 to +PDC_DATA
channel C4: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_j1vs72nn_1_1.bkp
channel C5: starting datafile backup set restore
channel C5: specifying datafile(s) to restore from backup set
channel C5: restoring datafile 00007 to +PDC_DATA
channel C5: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_j8vs72q5_1_1.bkp
channel C6: starting datafile backup set restore
channel C6: specifying datafile(s) to restore from backup set
channel C6: restoring datafile 00012 to +PDC_DATA
channel C6: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_j9vs72qc_1_1.bkp
channel C5: piece handle=BACKUP_CDBLAB1_DAILYF_20210413170118_j8vs72q5_1_1.bkp tag=BACKUP_DAILY_20210413170118
channel C5: restored backup piece 1
channel C5: restore complete, elapsed time: 00:00:03
channel C5: starting datafile backup set restore
channel C5: specifying datafile(s) to restore from backup set
channel C5: restoring datafile 00008 to +PDC_DATA
channel C5: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_j7vs72q2_1_1.bkp
channel C6: piece handle=BACKUP_CDBLAB1_DAILYF_20210413170118_j9vs72qc_1_1.bkp tag=BACKUP_DAILY_20210413170118
channel C6: restored backup piece 1
channel C6: restore complete, elapsed time: 00:00:03
channel C6: starting datafile backup set restore
channel C6: specifying datafile(s) to restore from backup set
channel C6: restoring datafile 00006 to +PDC_DATA
channel C6: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_j5vs72o0_1_1.bkp
channel C5: piece handle=BACKUP_CDBLAB1_DAILYF_20210413170118_itvs72nl_1_1.bkp tag=BACKUP_DAILY_20210413170118
channel C5: restored backup piece 1
channel C5: restore complete, elapsed time: 00:00:45
Finished restore at 13-APR-21

contents of Memory Script:
{
   switch clone datafile all;
}
executing Memory Script

datafile 1 switched to datafile copy
input datafile copy RECID=17 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/DATAFILE/system.368.1069801951
datafile 3 switched to datafile copy
input datafile copy RECID=18 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/DATAFILE/sysaux.371.1069801961
datafile 4 switched to datafile copy
input datafile copy RECID=19 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/DATAFILE/undotbs1.364.1069801933
datafile 5 switched to datafile copy
input datafile copy RECID=20 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245A2A1639EBECDE0531F00280AF249/DATAFILE/system.370.1069801961
datafile 6 switched to datafile copy
input datafile copy RECID=21 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245A2A1639EBECDE0531F00280AF249/DATAFILE/sysaux.366.1069801935
datafile 7 switched to datafile copy
input datafile copy RECID=22 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/DATAFILE/users.363.1069801933
datafile 8 switched to datafile copy
input datafile copy RECID=23 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245A2A1639EBECDE0531F00280AF249/DATAFILE/undotbs1.365.1069801935
datafile 9 switched to datafile copy
input datafile copy RECID=24 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245CC5C3CF4D487E0531F00280A308F/DATAFILE/system.361.1069801933
datafile 10 switched to datafile copy
input datafile copy RECID=25 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245CC5C3CF4D487E0531F00280A308F/DATAFILE/sysaux.369.1069801957
datafile 11 switched to datafile copy
input datafile copy RECID=26 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245CC5C3CF4D487E0531F00280A308F/DATAFILE/undotbs1.367.1069801951
datafile 12 switched to datafile copy
input datafile copy RECID=27 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245CC5C3CF4D487E0531F00280A308F/DATAFILE/users.362.1069801933
datafile 13 switched to datafile copy
input datafile copy RECID=28 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245CC5C3CF4D487E0531F00280A308F/DATAFILE/techdb_data.359.1069801931
datafile 14 switched to datafile copy
input datafile copy RECID=29 STAMP=1069802005 file name=+PDC_DATA/CDBLAB1B/B245CC5C3CF4D487E0531F00280A308F/DATAFILE/techdb_index.360.1069801933

contents of Memory Script:
{
   set until scn  31758000;
   recover
   standby
   clone database
    delete archivelog
   ;
}
executing Memory Script

executing command: SET until clause

Starting recover at 13-APR-21

starting media recovery

channel C1: starting archived log restore to default destination
channel C1: restoring archived log
archived log thread=1 sequence=891
channel C1: reading from backup piece BACKUP_CDBLAB1_DAILYF_20210413170118_javs730j_1_1.bkp
channel C2: starting archived log restore to default destination
channel C2: restoring archived log
archived log thread=1 sequence=892
channel C2: reading from backup piece BACKUP_CDBLAB1_DAILY_20210413230013_jevs7nr5_1_1.bkp
channel C3: starting archived log restore to default destination
channel C3: restoring archived log
archived log thread=1 sequence=893
channel C3: reading from backup piece BACKUP_CDBLAB1_DAILY_20210413230512_jivs7o1q_1_1.bkp
channel C1: piece handle=BACKUP_CDBLAB1_DAILYF_20210413170118_javs730j_1_1.bkp tag=BACKUP_DAILY_20210413170118
channel C1: restored backup piece 1
channel C1: restore complete, elapsed time: 00:00:03
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_891.318.1069802009 thread=1 sequence=891
channel clone_default: deleting archived log(s)
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_891.318.1069802009 RECID=2 STAMP=1069802009
channel C3: piece handle=BACKUP_CDBLAB1_DAILY_20210413230512_jivs7o1q_1_1.bkp tag=BACKUP_DAILY_20210413230512
channel C3: restored backup piece 1
channel C3: restore complete, elapsed time: 00:00:03
channel C2: piece handle=BACKUP_CDBLAB1_DAILY_20210413230013_jevs7nr5_1_1.bkp tag=BACKUP_DAILY_20210413230013
channel C2: restored backup piece 1
channel C2: restore complete, elapsed time: 00:00:07
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_892.320.1069802009 thread=1 sequence=892
channel clone_default: deleting archived log(s)
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_892.320.1069802009 RECID=3 STAMP=1069802011
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_893.319.1069802009 thread=1 sequence=893
channel clone_default: deleting archived log(s)
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_893.319.1069802009 RECID=1 STAMP=1069802009
media recovery complete, elapsed time: 00:00:03
Finished recover at 13-APR-21
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_892.320.1069802009 RECID=3 STAMP=1069802011
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_893.319.1069802009 thread=1 sequence=893
channel clone_default: deleting archived log(s)
archived log file name=+PDC_FRA/CDBLAB1B/ARCHIVELOG/2021_04_13/thread_1_seq_893.319.1069802009 RECID=1 STAMP=1069802009
media recovery complete, elapsed time: 00:00:03
Finished recover at 13-APR-21
Finished Duplicate Db at 13-APR-21
released channel: C1
released channel: C2
released channel: C3
released channel: C4
released channel: C5
released channel: C6



alter system set standby_file_management='AUTO' scope=both;
alter system set job_queue_processes=1000 scope=both; --Ojo!

reset audit_file_dest



set serveroutput on
begin
for r in 20..36 loop
dbms_output.put_line ('ALTER DATABASE ADD STANDBY LOGFILE THREAD 1 GROUP '||r||' (''+PDC_FRA'')  SIZE 200M;');
end loop;
end;
/



Oracle NETWORK


en prod
CDBLAB1B =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = oraspdcp01.iaas.ar.bsch)(PORT = 7365))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = CDBLAB1B_DG)
    )
  )


standby

CDBLAB1 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = oratechdbsrv01.iaas.ar.bsch)(PORT = 7365))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = CDBLAB1)
    )
  )

Copiar password file
Extraer password de SYS desde PSAFE



En standby
alter database recover managed standby database disconnect from session;

En el alert log:

2021-04-14T14:47:49.267086-03:00
 rfs (PID:67883): krsr_rfs_atc: Identified database type as 'PHYSICAL STANDBY': Client is Foreground (PID:117607)
2021-04-14T14:48:42.971498-03:00
ARC2 (PID:55013): Archived Log entry 7 added for T-1.S-897 ID 0xf344fb0 LAD:1
2021-04-14T14:48:43.000345-03:00
PR00 (PID:67293): Media Recovery Waiting for T-1.S-898
2021-04-14T14:48:43.020939-03:00
 rfs (PID:68185): krsr_rfs_atc: Identified database type as 'PHYSICAL STANDBY': Client is ASYNC (PID:69466)
 rfs (PID:68185): Primary database is in MAXIMUM PERFORMANCE mode
2021-04-14T14:48:43.099351-03:00
 rfs (PID:68185): Selected LNO:20 for T-1.S-898 dbid 255100080 branch 1054472180
2021-04-14T14:48:44.016077-03:00
Recovery of Online Redo Log: Thread 1 Group 20 Seq 898 Reading mem 0
  Mem# 0: +PDC_DATA/CDBLAB1B/ONLINELOG/group_20.464.1069856423
  Mem# 1: +PDC_FRA/CDBLAB1B/ONLINELOG/group_20.385.1069856423
  
 
 
Prod:

ALTER SYSTEM SET log_archive_dest_state_2='ENABLE' SCOPE=BOTH;
2021-04-14T14:48:42.724671-03:00
Thread 1 advanced to log sequence 898 (LGWR switch),  current SCN: 31872561
  Current log# 5 seq# 898 mem# 0: +RIOLAB1_DATA/CDBLAB1/ONLINELOG/group_5.276.1054473451
  Current log# 5 seq# 898 mem# 1: +RIOLAB1_FRA/CDBLAB1/ONLINELOG/group_5.261.1054473453
2021-04-14T14:48:42.811047-03:00
ARC3 (PID:117617): Archived Log entry 888 added for T-1.S-897 ID 0xf344fb0 LAD:1
2021-04-14T14:48:43.102010-03:00
TT04 (PID:69466): SRL selected for T-1.S-898 for LAD:2



Active DG:

alter database recover managed standby database cancel;
alter database open;
alter database recover managed standby database disconnect;



SQL> @database

      DBID NAME      DB_UNIQUE_NAME                       CURRENT_SCN CREATED   OPEN_MODE            FORCE_LOGGING                           DATABASE_ROLE    LOG_MODE     ARCHIVEL
---------- --------- ------------------------------ ----------------- --------- -------------------- --------------------------------------- ---------------- ------------ --------
 255100080 CDBLAB1   CDBLAB1B                                31873038 22-OCT-20 READ ONLY WITH APPLY YES                                     PHYSICAL STANDBY ARCHIVELOG   DISABLED


PL/SQL procedure successfully completed.


SCN_TIMESTAMP
---------------------------------------------------------------------------
14-APR-21 02.51.10.000000000 PM

SQL> @instance

                                                                                                                      Database
C INSTANCE_NUMBER LOGINS     INSTANCE_NAME    HOST_NAME                      VERSION           STARTUP_T STATUS       Status
- --------------- ---------- ---------------- ------------------------------ ----------------- --------- ------------ -----------------
*               1 ALLOWED    CDBLAB1B         oraspdcp01.iaas.ar.bsch        19.0.0.0.0        14-APR-21 OPEN         ACTIVE


CON_NAME
------------------------------
CDB$ROOT
SQL> @nls_date

Session altered.


SYSDATE
-------------------
14/04/2021 14:51:22

SQL>
SQL> select name,open_mode  from v$pdbs;

NAME                                                                                                                             OPEN_MODE
-------------------------------------------------------------------------------------------------------------------------------- ----------
PDB$SEED                                                                                                                         READ ONLY
RIOLAB1                                                                                                                          MOUNTED

SQL> alter pluggable database RIOLAB1 open;

Pluggable database altered.

SQL>



--------------------------------

3Gb: 1 min

/tsmlogs/config/
# cat tdpo_CDBLAB1B.opt
DSMI_ORC_CONFIG    /tsmlogs/config/dsm_rman_tsmmtz3.opt
DSMI_LOG           /tsmlogs/logs/tdperror_CDBLAB1B
TDPO_FS            ORATECHDBSRV01_CDBLAB1_RMAN
TDPO_NODE          ORATECHDBSRV01_CDBLAB1_RMAN
TDPO_OWNER         ORATECHDBSRV01_CDBLAB1_RMAN
TDPO_PSWDPATH      /tsmlogs/pwd
#

chmod 664 tdpo_CDBLAB1B.opt
tdpoconf passw 12345678 12345678 -tdpo_optfile=/tsmlogs/config/tdpo_CDBLAB1B.opt
tdpoconf showenv -tdpo_optfile=/tsmlogs/config/tdpo_CDBLAB1B.opt


Notas Santander

	
	

/opt/tivoli/tsm/client/ba/bin/



CDBSI02 BIS
deshabilitar jobs de base

CDB153 BIS
