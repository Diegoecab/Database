set lines 350
col INSTANCE_NAME FOR A12
col DBNAME FOR A12
col host_name FOR A30
col STARTUP for A23

SELECT INST_ID
     , INSTANCE_NAME
	 , DB_UNIQUE_NAME AS "DBNAME"
	 , HOST_NAME
	 , STATUS
	 , TO_CHAR(STARTUP_TIME, 'DD-MON-YYYY HH24:MI:SS') AS "STARTUP"
	 , DATABASE_STATUS
	 , DATABASE_ROLE
	 , OPEN_MODE
      FROM gv$instance
INNER JOIN gv$database
     USING (inst_id)
  ORDER BY inst_id;


**********************

Check de Sincronización por BD

    Primary: SQL> select thread#, max(sequence#) "Last Primary Seq Generated"  
    from v$archived_log val, v$database vdb  
    where val.resetlogs_change# = vdb.resetlogs_change#  
    group by thread# order by 1;  
      
    PhyStdby:SQL> select thread#, max(sequence#) "Last Standby Seq Received"  
    from v$archived_log val, v$database vdb  
    where val.resetlogs_change# = vdb.resetlogs_change#  
    group by thread# order by 1;  
      
    PhyStdby:SQL>select thread#, max(sequence#) "Last Standby Seq Applied"  
    from v$archived_log val, v$database vdb  
    where val.resetlogs_change# = vdb.resetlogs_change#  
    and val.applied in ('YES','IN-MEMORY')  
    group by thread# order by 1;  
	
	
**********************




SELECT ads.dest_id, max(sequence#) "Current Sequence",
	   max(log_sequence) "Last Archived",
	   max(applied_seq#) "Last Sequece Applied"
  FROM gv$archived_log al, gv$archive_dest ad,
       gv$archive_dest_status ads
 WHERE ad.dest_id=al.dest_id and al.dest_id=ads.dest_id
 GROUP BY ads.dest_id;
 
SELECT open_mode FROM v$database;

SELECT recovery_mode FROM gv$archive_dest_status
 WHERE recovery_mode <> 'IDLE'; 
 
SELECT inst_id,process, status FROM gv$managed_standby WHERE process LIKE 'MRP%';

SELECT max(al.sequence#) "Last Seq Received",
       max(lh.sequence#) "Las Seq Applied"
  FROM gv$archived_log al, gv$log_history lh;
  
SELECT * FROM gv$archive_gap;

-- Para encontrar qué archives ya no están 

SELECT name FROM gv$archived_log WHERE sequence# BETWEEN 319945 AND 319967
 AND thread# = 1;

 SELECT name FROM gv$archived_log WHERE sequence# IN (14376);
 
 
 ALTER DATABASE REGISTER LOGFILE 'ruta/nombrelogfile';
C$4m2kOracl3

-- Issue the following query to show information about the protection mode, the protection level, the role of the database, and switchover status:


select to_char(start_time, 'DD-MON-RR HH24:MI:SS') start_time,
item, round(sofar/1024,2) "MB/Sec"
from gv$recovery_progress
where (item='Active Apply Rate' or item='Average Apply Rate');

SELECT DATABASE_ROLE, DB_UNIQUE_NAME INSTANCE, OPEN_MODE, PROTECTION_MODE, PROTECTION_LEVEL, SWITCHOVER_STATUS FROM V$DATABASE;
On the standby database, query the V$ARCHIVED_LOG view to identify existing files in the archived redo log.

SELECT SEQUENCE#, FIRST_TIME, NEXT_TIME FROM gV$ARCHIVED_LOG ORDER BY SEQUENCE#;
Or

SELECT THREAD#, MAX(SEQUENCE#) AS "LAST_APPLIED_LOG" FROM gV$LOG_HISTORY GROUP BY THREAD#;////
On the standby database, query the V$ARCHIVED_LOG view to verify the archived redo log files were applied.

SELECT SEQUENCE#,APPLIED FROM GV$ARCHIVED_LOG where thread# = 2 ORDER BY SEQUENCE# ;

set lines 350
col name FOR A85
SELECT name
     , DEST_ID
	 , THREAD#
	 --, block_size
	 ,(BLOCKS * 512) / 1024 / 1024 / 1024 GB -- tomar el valor del bloque en el parámetro db_block_size
	 , ARCHIVED,APPLIED,DELETED
	 , TO_CHAR(COMPLETION_TIME,'DD-MON-RRRR HH24:MI:SS') COMPLETION_TIME 
 FROM gv$archived_log 
WHERE sequence# IN (312821,312817,312818);


col name FOR A85
SELECT name
     , DEST_ID
	 , THREAD#
	 --, block_size
	 ,(BLOCKS * 512) / 1024 / 1024 / 1024 GB -- tomar el valor del bloque en el parámetro db_block_size
	 , ARCHIVED,APPLIED,DELETED
	 , TO_CHAR(COMPLETION_TIME,'DD-MON-RRRR HH24:MI:SS') COMPLETION_TIME 
	 , BACKUP_COUNT
 FROM gv$archived_log 
WHERE TO_CHAR(COMPLETION_TIME,'DD-MON-RRRR HH24:MI:SS') < '18-NOV-2018 23:00:00'
 AND BACKUP_COUNT > 0; 



-- Query the physical standby database to monitor Redo Apply and redo transport services activity at the standby site.
SELECT PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS FROM gV$MANAGED_STANDBY;

SELECT PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS 
  FROM gV$MANAGED_STANDBY
 WHERE status = 'APPLYING_LOG';
 
 -- Con MB
SELECT PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS , (BLOCK# * 512) / 1024 / 1024 / 1024 GB FROM gV$MANAGED_STANDBY;

-- To determine if real-time apply is enabled, query the RECOVERY_MODE column of the V$ARCHIVE_DEST_STATUS view.
SELECT RECOVERY_MODE FROM V$ARCHIVE_DEST_STATUS WHERE RECOVERY_MODE <> 'IDLE';
SELECT DEST_ID,DEST_NAME,STATUS,TYPE,DATABASE_MODE,DB_UNIQUE_NAME,RECOVERY_MODE,PROTECTION_MODE FROM V$ARCHIVE_DEST_STATUS WHERE RECOVERY_MODE <> 'IDLE';


--The V$DATAGUARD_STATUS fixed view displays events that would typically be triggered by any message to the alert log or server process trace files.
SELECT MESSAGE FROM V$DATAGUARD_STATUS;

SELECT FACILITY,SEVERITY,DEST_ID,MESSAGE_NUM,ERROR_CODE,TIMESTAMP,MESSAGE FROM V$DATAGUARD_STATUS;

Set linesize 340
column Timestamp Format a20
column Facility  Format a24
column Severity  Format a13
column Message   Format a80 trunc
 
Select
   to_char(timestamp,'YYYY-MON-DD HH24:MI:SS') Timestamp,
   Facility,
   Severity,
   Message
From
   gv$dataguard_status
Order by
   Timestamp;


-- Determining Which Log Files Were Not Received by the Standby Site.
SELECT LOCAL.THREAD#, LOCAL.SEQUENCE# FROM (SELECT THREAD#, SEQUENCE# FROM V$ARCHIVED_LOG WHERE DEST_ID=1) LOCAL WHERE LOCAL.SEQUENCE# NOT IN (SELECT SEQUENCE# FROM V$ARCHIVED_LOG WHERE DEST_ID=2 AND THREAD# = LOCAL.THREAD#);

-- If a delayed apply has been specified or an archive log is missing then switchover may take longer than expected.
-- Check v$managed_standby

select process, status, sequence# from gv$managed_standby;
OR alternatively:
select name, applied from v$archived_log;

SELECT   a.thread#,  b. last_seq, a.applied_seq, b.last_seq-a.applied_seq   ARC_DIFF FROM (SELECT  thread#, MAX(sequence#) applied_seq, MAX(next_time) last_app_timestamp FROM gv$archived_log WHERE applied = 'YES' GROUP BY thread#) a,
       (SELECT  thread#, MAX (sequence#) last_seq FROM gv$archived_log GROUP BY thread#) b WHERE a.thread# = b.thread#;
alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';
select THREAD#,max(SEQUENCE#),max(NEXT_TIME) from v$archived_log where APPLIED='YES' group by THREAD#;


-- ############################################## --

When we are dealing with Standby Databases we should take care that our Archivelogs are not deleted in Primary Database, because if the archivelogs are deleted we will have a Lag in the Standby and we will have to fix the standby, there are some methods to fix this, however, there is an easy way to avoid this deletion. We can take advantage of "ARCHIVELOG DELETION POLICY". You can configure this policy at the following way:

CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON ALL STANDBY;

Once that policy is set the archivelogs can't be deleted up to they have been applied on all the standby databases. would you like to confirm this? Let's do it with one example:

Current Data Guard Configuration:

DGMGRL> show configuration;

Configuration - orcl.oraworld.com

Protection Mode: MaxPerformance
Databases:
orcl - Primary database
orcl2 - Physical standby database

Fast-Start Failover: DISABLED

Configuration Status:
SUCCESS

DGMGRL>

Sequence status in Primary Database:

SQL> archive log list;
Database log mode Archive Mode
Automatic archival Enabled
Archive destination USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence 82
Next log sequence to archive 83
Current log sequence 83
SQL>

Sequence Status in Standby Database:

SQL> select max(sequence#) from gv$archived_log where applied='YES';

MAX(SEQUENCE#)
--------------
82

SQL>

Now let's disable the apply process on Standby:

DGMGRL> EDIT DATABASE 'orcl2' SET STATE='APPLY-OFF';
Succeeded.

Configuring the Deletion policy of Archivelogs:

RMAN> CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON ALL STANDBY;

old RMAN configuration parameters:
CONFIGURE ARCHIVELOG DELETION POLICY TO BACKED UP 1 TIMES TO DISK;
new RMAN configuration parameters:
CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON ALL STANDBY;
new RMAN configuration parameters are successfully stored

Checking the current Archivelogs:

RMAN> list archivelog all;

specification does not match any archived log in the repository

RMAN>

Let's create some Archivelogs in Primary Database so that they won't be applied in Standby Database since Standby Database is in "APPLY-OFF" status:

SQL> alter system switch logfile;

System altered.

SQL> alter system switch logfile;

System altered.

SQL> alter system switch logfile;

System altered.

SQL>

Let's check our generated Archivelogs:

RMAN> list archivelog all;

List of Archived Log Copies for database with db_unique_name ORCL
=====================================================================

Key Thrd Seq S Low Time 
------- ---- ------- - ---------
39 1 83 A 30-NOV-14
Name: /u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_83_b7ov5cz4_.arc

41 1 84 A 30-NOV-14
Name: /u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_84_b7ov5dtq_.arc

42 1 85 A 30-NOV-14
Name: /u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_85_b7ov5j0q_.arc


RMAN>

The sequence status in Primary Database:

SQL> select max(sequence#) from gv$archived_log where archived='YES';

MAX(SEQUENCE#)
--------------
85

SQL>

The sequence status in Standby Database:

SQL> select max(sequence#) from gv$archived_log where applied='YES';

MAX(SEQUENCE#)
--------------
82

Now let's simulate a human error, let's try to delete our archivelog regardless if they were applied on standby or not.

RMAN> delete archivelog all;

released channel: ORA_DISK_1
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=87 device type=DISK
RMAN-08120: WARNING: archived log not deleted, not yet applied by standby
archived log file name=/u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_83_b7ov5cz4_.arc thread=1 sequence=83
RMAN-08120: WARNING: archived log not deleted, not yet applied by standby
archived log file name=/u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_84_b7ov5dtq_.arc thread=1 sequence=84
RMAN-08120: WARNING: archived log not deleted, not yet applied by standby
archived log file name=/u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_85_b7ov5j0q_.arc thread=1 sequence=85

RMAN>

RMAN shows a warning saying that those archivelogs haven't been applied yet, so we weren't able to delete them.

Now let's apply those archivelogs in Standby:

DGMGRL> EDIT DATABASE 'orcl2' SET STATE='APPLY-ON';
Succeeded.

Standby Database Sequence status:

SQL> select max(sequence#) from v$archived_log where applied='YES';

MAX(SEQUENCE#)
--------------
85

Now we are able to delete those archivelogs in Primary Database, because they were applied already:

RMAN> delete archivelog all;

released channel: ORA_DISK_1
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=71 device type=DISK
List of Archived Log Copies for database with db_unique_name ORCL
=====================================================================

Key Thrd Seq S Low Time 
------- ---- ------- - ---------
39 1 83 A 30-NOV-14
Name: /u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_83_b7ov5cz4_.arc

41 1 84 A 30-NOV-14
Name: /u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_84_b7ov5dtq_.arc

42 1 85 A 30-NOV-14
Name: /u01/app/oracle/flash_recovery_area/ORCL/archivelog/2014_11_30/o1_mf_1_85_b7ov5j0q_.arc


Do you really want to delete the above objects (enter YES or NO)?

Note: the "obsolete" functions of RMAN don't work with archivelog deletion policy. As you can see the archivelogs don't appear as obsolete even if they were applied in Standby Database.

RMAN> delete obsolete;

RMAN retention policy will be applied to the command
RMAN retention policy is set to redundancy 1
using channel ORA_DISK_1
no obsolete backups found

RMAN> report obsolete;

RMAN retention policy will be applied to the command
RMAN retention policy is set to redundancy 1
no obsolete backups found



-----


Doc ID 836986.1
http://www.dba-oracle.com/t_physical_standby_missing_log_scenario.htm

