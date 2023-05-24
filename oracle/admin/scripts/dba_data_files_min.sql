REM	Script para obtener el tamaño y espacio libre por datafile
REM ======================================================================
REM dba_data_files_min.sql		Version 1.1	10 Marzo 2010

set pages 1000
set lines 300
set trims on
set verify off

col tablespace_name format a20            
col file_name       format a60            
col total_size      format 99999999
col free_space      format 99999999
col pct_used        format 999       
undefine all


clear breaks

select df.file_id
,	df.tablespace_name
,      df.file_name
,      df.bytes/1024/1024                        total_size
,	df.autoextensible auto
,increment_by
,	df.maxbytes/1024/1024 maxsize,
vdf.status,
vdf.creation_time
from   dba_data_files        df
,	    v$datafile			  vdf
where vdf.file# = df.file_id
and df.tablespace_name like ('%&tablespace_name%')
and df.file_name like ('%&file_name%')
order by tablespace_name,vdf.creation_time
/