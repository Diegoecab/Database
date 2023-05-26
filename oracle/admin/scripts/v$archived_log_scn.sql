col first_change# for 999999999999999
col next_change# for 999999999999999
set lines 400

select thread#,sequence#,FIRST_CHANGE#,NEXT_CHANGE#,FIRST_TIME,RESETLOGS_ID from v$archived_log where 690601453767 between FIRST_CHANGE# and NEXT_CHANGE#;


col first_change# for 999999999999999
col next_change# for 999999999999999

select thread#,sequence#,FIRST_CHANGE#,NEXT_CHANGE#,FIRST_TIME from v$archived_log where sequence#=18076 and thread#=1;