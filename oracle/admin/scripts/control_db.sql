set pagesize 5000
set linesize 500

prompt
prompt TABLESPACE DATA FILES
prompt

col tablespace_name format a10
col file_name format a60
select tablespace_name, file_name
from dba_data_files
order by tablespace_name;

prompt
PROMPt TABLESPACE CONTROL
prompt

col name format a15
col dfs format 999
col used format 999999
col free format 999999
col pct_used format 999999
select nvl(b.tablespace_name, nvl(a.tablespace_name,'UNKOWN')) name,
       alloc alloc,
       round(alloc-nvl(free,0)) used,
       nvl(free,0) free,
       round(((alloc-nvl(free,0)) / alloc)*100) pct_used,
       nvl(largest,0) largest,
       auto,
       dfs,
       round(nvl(max,alloc)) Max_Size,
       round(decode( max, 0, 0, (alloc/max)*100)) pct_max_used
from ( select round(sum(bytes)/1024/1024) free,
              round(max(bytes)/1024/1024) largest,
              tablespace_name
       from  sys.dba_free_space
       group by tablespace_name ) a,
     ( select sum(bytes)/1024/1024 alloc,
              sum(maxbytes)/1024/1024 max,
              tablespace_name,
              max(autoextensible) auto,
              count(*) dfs
       from sys.dba_data_files
       group by tablespace_name
       union all
       select sum(bytes)/1024/1024 alloc,
              sum(maxbytes)/1024/1024 max,
              tablespace_name,
              max(autoextensible) auto,
              count(*) dfs
       from sys.dba_temp_files
       group by tablespace_name )b 
where a.tablespace_name (+) = b.tablespace_name
order by 1;

prompt
PROMPt TABLESPACE WITH AT LEAST ONE AUTOEXTENSIBLE UNLIMITED DATAFILE
prompt

select tablespace_name, round(bytes/1024/1024) "bytes[MB]",  autoextensible, maxbytes 
from dba_data_files 
where autoextensible = 'YES' 
and maxbytes = 0;

prompt
prompt ---------------------------------------------------------------
prompt


prompt
prompt DATA FILES
prompt

select file_name from dba_data_files order by file_name;

prompt
prompt TEMP FILE
prompt

select file_name, round(bytes/1024/1024) MB from dba_temp_files;

prompt
prompt CONTROL FILES
prompt

col name format a60
select name from v$controlfile;

prompt
prompt LOGS FILES
prompt

col group# format 99999
col member format a60 
col MB format 99999
select lf.group#, member, bytes/1024/1024 MB,lf.type, l.status, archived
from v$logfile lf, v$log l
where lf.group# = l.group#
order by lf.group#;

prompt
prompt ARCHIVE LOG LIST
prompt

archive log list

prompt
prompt ARCHIVE LOGS
prompt

col name format a60
col value format a200
select name, substr(value,1,200) from v$parameter where name like '%log_archive%';

prompt
prompt -----------------------------------------------------------------
prompt


prompt
prompt STATPACK USER ( NO DEBE HABER, 10G AWR )
prompt

select temporary_tablespace, default_tablespace from dba_users where username = 'PERFSTAT';

prompt
prompt ---------------------------------------------------------------
prompt


prompt
prompt JOBS ( DBA_JOBS ) EN 10G SE DEBEN HACER POR EL SCHEDULER
prompt

col job format 9999
col log_user format a12
select job, log_user,last_date,last_sec,next_date,next_sec,broken from dba_jobs order by job;

prompt
prompt TABLES STATS
prompt

col OWNER FORMAT a20
col min format a20
col max format a20
select aux.*, decode(substr(min,1,10), substr(max,1,10), ' ','Verificar') ctrl
from 
(
 select owner, 	
        to_char(min(last_analyzed),'dd-mm-yyyy hh24:mi:ss') min, 
to_char(max(last_analyzed),'dd-mm-yyyy hh24:mi:ss') max 
from dba_tables 
group by owner
) aux ;


prompt
prompt INDEXES STATS ( DBA_INDEXES )
prompt

select aux.*, decode(substr(min,1,10), substr(max,1,10), ' ','Verificar') ctrl
from 
(
 select owner, 	
        to_char(min(last_analyzed),'dd-mm-yyyy hh24:mi:ss') min, 
to_char(max(last_analyzed),'dd-mm-yyyy hh24:mi:ss') max 
from dba_indexes
group by owner
) aux ;


prompt
prompt INDEXES candidatos para rebuild o bitmap index
prompt

-- Index is considered as candidate for rebuild when :
--   - when deleted entries represent 20% or more of the current entries
--   - when the index depth is more then 4 levels.(height starts counting from 1 so > 5)
-- Index is (possible) candidate for a bitmap index when :
--   - distinctiveness is more than 99%
--

SELECT *
FROM (
    SELECT name,
           blocks, 
           pct_used,
           Height - 1 blevel,
           lf_rows,
           Del_Lf_Rows,           
           distinct_keys,
           Round((Del_Lf_Rows / Decode(Lf_Rows, 0, 1, Lf_Rows)) * 100, 3) pct_deleted_entries,        
           Round((Lf_Rows - Distinct_Keys) * 100 / Decode(Lf_Rows, 0, 1, Lf_Rows), 3) distinctivness
      FROM Index_Stats)
WHERE (blevel > 4) OR (Round((Del_Lf_Rows / Decode(Lf_Rows, 0, 1, Lf_Rows))) > 0.2) or 
      distinctivness > 98;


prompt
prompt ---------------------------------------------------------------
prompt


prompt
prompt USERS WITH WRONG TEMPORARY TABLESPACE
prompt

select username 
from dba_users
where temporary_tablespace not in (select tablespace_name from dba_tablespaces where contents = 'TEMPORARY') order by usernamE;

prompt
prompt USERS WITH WRONG DEFAULT TABLESPACE
prompt

select username
from dba_users
where default_tablespace = 'SYSTEM'
and username not in ('DBSNMP','MDSYS','ORDPLUGINS','ORDSYS','OUTLN','SYS','SYSTEM','WMSYS')
order by username;

prompt
prompt OBJETS IN WRONG SEGMENT ( SYSTEM )
prompt

SELECT owner, segment_name, segment_type
FROM dba_segments
WHERE tablespace_name = 'SYSTEM'
AND owner NOT IN ('SYS','SYSTEM','OUTLN', 'WMSYS','ORDSYS','MDSYS');

prompt
prompt INVALID OBJECTS COUNT
prompt

select owner, object_type, count(*) 
from dba_objects where status = 'INVALID' 
group by owner, object_type; 

prompt
prompt INVALID OBJECTS DETAIL
prompt

col owner format a15
col object_name format a30
col object_type format a20
select owner, object_name, object_type
from dba_objects where status = 'INVALID';

prompt
prompt ---------------------------------------------------------------
prompt


prompt
prompt LOG HISTORY
prompt

select fecha, cant, round(cant/(24)) "cant x hora"
from (
select trunc(first_time) fecha, count(*) cant
from v$log_history
where trunc(first_time) > trunc(sysdate) - 30
group by trunc( first_time) 
);


prompt
prompt ---------------------------------------------------------------
prompt

prompt
prompt PARAMETERS
prompt

col name format a40 
col value format a200
Select name, substr(value,1,200) from v$parameter;

prompt
prompt ---------------------------------------------------------------
prompt

