/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  data_files_move_omf_online.sql v1.0
-- Purpose:    Script para mover datafiles online (Version 12c en adelante) 
-- Usage:       
--  Ejecutar desde el servidor de la base de datos, conectado como / as sysdba:
--   spool data_files_move_omf_online_<dbname>.log
-- 		@data_files_move_omf_online 
-- 	 spool off
--
--IMPORTANTE! Los datafiles se moveran usando OMF. Verificar primero el seteo del parametro db_create_file_dest sea /u02/app/oracle/oradata/datastore/.ACFS/snaps/<db_name>
--
*/


prompt db_create_file_dest:
col value for a80
select value from v$parameter where name='db_create_file_dest';

alter session set nls_date_format='DD-MM-YY HH24:MI:SS';
set lines 500
col fs       format a90 word_wrap   heading "File System"

Prompt datafiles by FS

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

prompt
host df -h
prompt

set serveroutput on
declare
v_sd date;
new_file_name varchar2(150);
begin
for r in (
select file_name, file_id from dba_data_files where file_name not like '/u02/app/oracle/oradata/datastore%'
)
loop
select sysdate into v_sd from dual;
dbms_output.put_line (v_sd||' moving datafile '||r.file_name);
execute immediate ('alter database move datafile '||r.file_id);
select file_name into new_file_name from dba_data_files where file_id=r.file_id;
dbms_output.put_line (v_sd||' new file name '||new_file_name);
end loop;
end;
/


prompt
host df -h
prompt


col fs       format a90 word_wrap   heading "File System"

Prompt datafiles by FS

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
