REM v$filestat_tbs.sql
set pages 500 lines 110

clear col bre buffer
col tablespace_name format a15 hea 'TABLESPACE'
col file_name format a24 hea 'DATAFILE'
--break on tablespace_name skip
break on tablespace on report 
compute sum of total on report 

select tablespace_name, regexp_replace(file_name,'^.*.\/.*.\/', '') file_name,
sum(phyrds) reads, sum(phywrts) writes, sum(phyrds)+sum(phywrts) total
from dba_data_files, v$filestat
where file_id=file# group by tablespace_name, file_name
order by tablespace_name, file_name;