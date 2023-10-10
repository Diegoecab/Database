REM	Script para obtener el tamaño y espacio libre por datafile
REM ======================================================================
REM dba_data_files.sql		Version 1.1	10 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	
REM
REM Notas:
REM Precauciones:
REM	
REM ======================================================================
REM

set pages 1000
set lines 300
set trims on
set verify off

col tablespace_name format a20            
col file_name       format a100            truncate
col total_size      format 99999999
col free_space      format 99999999
col pct_used        format 999       
undefine all


clear breaks

select df.file_id
,	df.tablespace_name
,      df.file_name
,      df.bytes/1024/1024                        total_size
,   nvl((select sum(bytes)/1024/1024 from dba_free_space a where a.file_id = df.file_id group by a.file_id),0) as free_space
,   round(((df.bytes-nvl((select sum(bytes) from dba_free_space a where a.file_id = df.file_id group by a.file_id),0))/replace(df.bytes,0,1))*100) pct_used
,   round(((df.bytes-nvl((select sum(bytes) from dba_free_space a where a.file_id = df.file_id group by a.file_id),0))/replace(df.maxbytes,0,1))*100) pct_used_max
,	df.autoextensible auto
,increment_by
,	df.maxbytes/1024/1024/1024 maxsize,
vdf.status,
vdf.creation_time
from   dba_data_files        df
,	    v$datafile			  vdf
where vdf.file# = df.file_id
and df.tablespace_name like ('%&tablespace_name%')
and df.file_name like ('%&file_name%')
order by tablespace_name,vdf.creation_time
/