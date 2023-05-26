set lines 300
set pages 300

select FIRST_TIME,COMPLETION_TIME,inst_id, THREAD#, SEQUENCE#, dest_id, blocks, block_size from gV$ARCHIVED_LOG where dest_id=3  and FIRST_TIME > sysdate+(1/1440*-360)
order by 2;

with duplicates as (
select * from (
select thread#,SEQUENCE#,count(*) cnt from (
select THREAD#, SEQUENCE# from gV$ARCHIVED_LOG where dest_id=3 and FIRST_TIME>to_date('22/09/2020 02:28:32','DD/MM/YYYY HH24:MI:SS')--sysdate+(1/1440*-180)
) 
group by thread#,SEQUENCE#)  where cnt > 2)
select to_char(a.COMPLETION_TIME,'DD-MM-YY HH24'), a.thread#,a.SEQUENCE#, duplicates.cnt from gV$ARCHIVED_LOG a, duplicates WHERE 
a.thread#=duplicates.thread# and a.SEQUENCE#=duplicates.SEQUENCE# order by COMPLETION_TIME;



--select FIRST_TIME,COMPLETION_TIME,inst_id, THREAD#, SEQUENCE#, dest_id, blocks, block_size from gV$ARCHIVED_LOG where SEQUENCE#=18497 and thread#=2 and dest_id=3 order by COMPLETION_TIME;


FIRST_TIME          COMPLETION_TIME        INST_ID    THREAD#  SEQUENCE#    DEST_ID     BLOCKS BLOCK_SIZE
------------------- ------------------- ---------- ---------- ---------- ---------- ---------- ----------
07/09/2020 00:02:23 07/09/2020 00:30:36          2          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 00:30:36          1          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 06:23:54          2          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 06:23:54          1          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 07:21:36          1          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 07:21:36          2          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 08:21:54          2          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 08:21:54          1          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 09:35:43          1          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 09:35:43          2          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 10:28:36          1          1      18326          3    6245814        512
07/09/2020 00:02:23 07/09/2020 10:28:36          2          1      18326          3    6245814        512

12 rows selected.

SQL> l
  1* select FIRST_TIME,COMPLETION_TIME,inst_id, THREAD#, SEQUENCE#, dest_id, blocks, block_size from gV$ARCHIVED_LOG where SEQUENCE#=18326 and thread#=1 and dest_id=3 order by COMPLETION_TIME
SQL>




grep -i 18326 /u01/app/oracle/product/12.1.0.2/dbhome_1/diag/rdbms/cnibsr/cnibsr2/trace/alert_cnibsr2.log -A2





ibscn:

RFS[3]: Selected log 15 for thread 1 sequence 18326 dbid 2413205728 branch 1022492769
Mon Sep 07 02:02:39 2020
--
TT00: Standby redo logfile selected for thread 1 sequence 18326 for destination LOG_ARCHIVE_DEST_2
Mon Sep 07 02:03:53 2020
--
Re-archiving standby log 15 thread 1 sequence 18326
RFS[6]: Assigned to RFS process (PID:21264)
--
Archived Log entry 19738 added for thread 1 sequence 18326 ID 0x8fd6c8e0 dest 1:
Mon Sep 07 03:00:08 2020
--
RFS[22]: Opened log for thread 1 sequence 18326 dbid 2413205728 branch 1022492769
Mon Sep 07 08:00:58 2020
--
Archived Log entry 19826 added for thread 1 sequence 18326 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
Mon Sep 07 08:23:56 2020


RFS[54]: Opened log for thread 1 sequence 18326 dbid 2413205728 branch 1022492769
Mon Sep 07 09:00:46 2020
RFS[55]: Assigned to RFS process (PID:17460)
--
Archived Log entry 19857 added for thread 1 sequence 18326 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
Mon Sep 07 09:21:39 2020
RFS[61]: Assigned to RFS process (PID:12227)
--
RFS[80]: Opened log for thread 1 sequence 18326 dbid 2413205728 branch 1022492769
Mon Sep 07 10:01:05 2020
Archived Log entry 19881 added for thread 2 sequence 18494 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
--
Archived Log entry 19890 added for thread 1 sequence 18326 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
Mon Sep 07 10:21:57 2020
RFS[90]: Assigned to RFS process (PID:1107)
--
RFS[124]: Opened log for thread 1 sequence 18326 dbid 2413205728 branch 1022492769
Mon Sep 07 11:15:01 2020
Archived Log entry 19936 added for thread 1 sequence 18324 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
--
Archived Log entry 19944 added for thread 1 sequence 18326 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
Mon Sep 07 11:35:46 2020
RFS[132]: Assigned to RFS process (PID:7948)
--
RFS[152]: Opened log for thread 1 sequence 18326 dbid 2413205728 branch 1022492769
Mon Sep 07 12:06:50 2020
Archived Log entry 19974 added for thread 1 sequence 18324 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
--
Archived Log entry 19980 added for thread 1 sequence 18326 rlc 1022492769 ID 0x8fd6c8e0 dest 3:
Mon Sep 07 12:30:39 2020
RFS[157]: Assigned to RFS process (PID:18355)
[oracle@rgmadbp1752 ~]$




cnibsr:

Media Recovery Waiting for thread 1 sequence 18326 (in transit)
Mon Sep 07 02:04:10 2020
Recovery of Online Redo Log: Thread 1 Group 16 Seq 18326 Reading mem 0
  Mem# 0: +FRAC4/CNIBSR/ONLINELOG/group_16.4677.1048342137
Mon Sep 07 02:21:05 2020
--
Re-archiving standby log 16 thread 1 sequence 18326
RFS[1702]: Assigned to RFS process (PID:86237)
RFS[1702]: Selected log 14 for thread 1 sequence 18327 dbid 2413205728 branch 1022492769
--
Archived Log entry 3576 added for thread 1 sequence 18326 ID 0x8fd6c8e0 dest 1:
Mon Sep 07 03:00:02 2020



