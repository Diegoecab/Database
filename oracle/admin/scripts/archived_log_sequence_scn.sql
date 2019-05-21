col FIRST_CHANGE# for 99999999999999
select sequence#,FIRST_CHANGE# from v$archived_log where sequence# = &sequence;