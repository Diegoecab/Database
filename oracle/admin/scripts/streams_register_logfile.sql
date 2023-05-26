select source_database,thread#,sequence#,name,modified_time,first_scn,next_scn,dictionary_begin,dictionary_end
 from dba_registered_archived_log 
where 352328 between first_scn and next_scn; 


select source_database,thread#,sequence#,name,modified_time,first_scn,next_scn,dictionary_begin,dictionary_end
 from dba_registered_archived_log 
where sequence# >= 352328; 

--
/*
11. How to unregister logfile that have been registered using: ALTER DATABASE REGISTER LOGICAL LOGFILE ?
Remove the logfiles from the directory location.
Then wait about 6 hours and check DBA_REGISTERED_ARCHIVED_LOG again.
Make sure that logminer checkpoints are occuring so that you see the MAX_CHECKPOINT_SCN in DBA_CAPTURE increasing. Given that, archived redo logs deleted from OS will be also purged from SYSTEM.LOGMNR_LOG$ after about 6 hours.

Delete from system.logmnr_log$ should be the second or last resort option.

Given that there is no API to unregister a proposed solution would be to delete from system.logmnr_log$
1. Stop the capture process named PREMT_CAP
2. select max(sequence#) from logmnr_log$ where session#=<session_id> ;
3. delete from system.logmnr_log$ where session# = (select session# fromsystem.logmnr_session$ where session_name = 'PREMT_CAP') and sequence# > 3042;commit;
4. Start PREMT_CAP5.
5.Manually register the archived redo logs from new Sequence 3043
alter database register or replace logical logfile '/oradb1/wareht/strmarc1/premt_62420 2408_3043_1_0.arc' for 'PREMT_CAP';
*/


alter database register or replace logical logfile '+FRAC1/veoggp/archivelog/2020_01_31/thread_1_seq_367399' for 'OGG$CAP_VEEXTA';

alter database register or replace logical logfile '+FRAC1/veoggp/archivelog/2020_01_31/thread_2_seq_352326' for 'OGG$CAP_VEEXTA';

alter database register or replace logical logfile '1_367400_763465459.dbf' for 'OGG$CAP_VEEXTA';

--


/*
Determine if there are logs marked as corrupt
*/


set pagesize 1000 
select * from system.logmnr_log$ where contents = 16 order by sequence#; 
create table system.logmnr_log$_bak as select * from system.logmnr_log$; 

delete from system.logmnr_log$ where contents = 16 and thread# = and sequence# = ;
