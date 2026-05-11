REM	Datafiles por FS
REM ======================================================================
REM dba_data_files_fs.sql		Version 1.1	10 Marzo 2010
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
set lines 132
set trims on
col tablespace_name format a20            heading "Tabsp Name"
col file_name       format a60            heading "File Name"
col fs       format a60            heading "File|System"
col total_size      format 999999999     heading "Size MB"
col free_space      format 999999999     heading "Free MB"
col pct_used        format 999.00         heading "%|Used"
col cant		    heading "Cantidad|Datafiles"
col cant_temp	    heading "Cantidad|Tempfiles"

clear breaks

Break on fs on report 
compute sum of total_size on report 
compute sum of free_space on report 
prompt 
prompt ================================================================================================================================================
prompt
ttitle left 'Suma de espacio usado por datafiles, por fileSystem'


select 
  SUBSTR (df.file_name,
                 1,
                 REGEXP_INSTR (df.file_name, '/', INSTR (df.file_name, '/', -1)) - 1
                ) fs
,      sum(df.bytes/1024/1024)                        total_size
,      sum(nvl(fr.bytes/1024/1024,0))                 free_space
,	   count(*)										  cant
from   (select sum(bytes) bytes
        ,      file_id
        from   dba_free_space
        group by file_id)     fr
,       dba_data_files        df
where df.file_id = fr.file_id(+)
group by
SUBSTR (df.file_name,
                 1,
                 REGEXP_INSTR (df.file_name, '/', INSTR (df.file_name, '/', -1)) - 1
                )
order by 1
/

ttitle off
prompt 
prompt ================================================================================================================================================
prompt
ttitle left 'Suma de espacio usado por tempfiles, por fileSystem'


select 
  SUBSTR (df.file_name,
                 1,
                 REGEXP_INSTR (df.file_name, '/', INSTR (df.file_name, '/', -1)) - 1
                ) fs
,      sum(df.bytes/1024/1024)                        total_size
,      sum(nvl(fr.bytes/1024/1024,0))                 free_space
,	   count(*)										  cant_temp
from   (select sum(bytes) bytes
        ,      file_id
        from   dba_free_space
        group by file_id)     fr
,       dba_temp_files        df
where df.file_id = fr.file_id(+)
group by
SUBSTR (df.file_name,
                 1,
                 REGEXP_INSTR (df.file_name, '/', INSTR (df.file_name, '/', -1)) - 1
                )
order by 1
/
prompt 
prompt ================================================================================================================================================
prompt
ttitle off
clear breaks
clear comp