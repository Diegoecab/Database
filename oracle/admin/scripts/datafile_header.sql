col checkpoint_change# for 99999999999999999999999999999
set lines 900
select file#, status, fuzzy, error, checkpoint_change#,checkpoint_time,resetlogs_time
from v$datafile_header;

