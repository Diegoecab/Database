REM	Script para obtener el tamaño y espacio libre por datafile
REM ======================================================================
REM dba_temp_files.sql		Version 1.1	10 Marzo 2010
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
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM

set pages 1000
set lines 400
set trims on
col tablespace_name format a20            heading "Tabsp Name"
col file_name       format a60            heading "File Name"
col total_size      format 999,999.00     heading "Size MB"
col free_space      format 999,999.00     heading "Free MB"
col pct_used        format 999.00         heading "%|Used"

clear breaks

select df.tablespace_name
,      df.file_name
,       nvl(df.bytes/1024/1024/1024,0)                   total_size_gb
,      nvl(fr.bytes/1024/1024/1024,0)                 free_space_gb
,	   df.increment_by
,      ((df.bytes-nvl(fr.bytes,0))/df.bytes)*100 pct_used,
df.autoextensible auto,
df.maxbytes/1024/1024/1024 maxsize_gb
from   (select sum(bytes) bytes
        ,      file_id
        from   dba_free_space
        group by file_id)     fr
,       dba_temp_files        df
where df.file_id = fr.file_id(+)
order by 1, df.file_id
/
