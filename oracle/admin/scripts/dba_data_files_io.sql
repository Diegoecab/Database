REM dba_data_files_io.sql
set pages 500 lines 110
clear col bre buffer
bre on REPORT;
comp sum lab Total min lab Minimum max lab Maximum of reads on REPORT;
comp sum lab Total min lab Minimum max lab Maximum of writes on REPORT;
comp sum lab Total min lab Minimum max lab Maximum of total on REPORT;
col datafile format a60
col file_name       format a60            heading "File Name"
col total_size      format 999,999.00     heading "Size MB"
col free_space      format 999,999.00     heading "Free MB"
ttitle 'Datafiles con mayor escritura a disco'

select name datafile, phyrds reads, phywrts writes, phyrds+phywrts total, a.bytes/1024/1024  total_size
from v$datafile a, v$filestat b,  (select sum(bytes) bytes
  ,      file_id
  from   dba_free_space
  group by file_id)     fr, dba_data_files        df
  where a.file# = b.file# 
  and df.file_id = fr.file_id(+)
 and  df.file_id = a.file#
 order by writes desc;
 
 ttitle off