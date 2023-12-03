select name, dest_id, thread#,sequence#, archived, applied, deleted, status, first_time, next_time, completion_time  from v$archived_log where sequence# =40498;
