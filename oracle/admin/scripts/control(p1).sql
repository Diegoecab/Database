set feedback off
set verify off
set termout off
set heading off
set serveroutput on

spool /home/oracle/tmp/control.tmp append

set linesize 280
set pagesize 50000

select 'CONTROL', '&1', '&2', 'TBS', 'WARNING', 'Tablespace '|| name||' pct used: '||pct_used
from
(
select
 name,
        round(alloc) alloc,
        round(free) free,
        round(alloc - free) used,
        100 - round((max-(alloc - free))/max*100) pct_used,
        '  '||lpad(dfs,2,' ')||' / '||lpad(auto,2,' ')||' ' " DFs / Aut",
        decode(auto,dfs,'   ',0,'   ',' X') Ctl,
        max Max_Size,
        maxf Max_Size_file,
        round(decode(max,0,0,(alloc/max)*100)) pct_max_alloc
from (
select nvl(b.tablespace_name, nvl(a.tablespace_name,'UNKOWN')) name,
       alloc,
       nvl(free,0) free,
       auto,
       dfs,
--       maxn,
       nvl(max,0) + nvl(maxn,0) max,
       nvl(maxf,0) maxf
from ( select round(sum(bytes)/1024/1024) free,
              tablespace_name
       from  sys.dba_free_space
       group by tablespace_name ) a,
     ( select sum(bytes)/1024/1024 alloc,
              sum(maxbytes)/1024/1024 max,
              max(maxbytes)/1024/1024 maxf,
              (select sum(bytes)/1024/1024 from dba_data_Files df3 where df3.tablespace_name = df1.tablespace_name and df3.AUTOEXTENSIBLE = 'NO') maxn,
              tablespace_name,
              (select count(*) from dba_data_files df2 where df2.tablespace_name = df1.tablespace_name and df2.AUTOEXTENSIBLE = 'YES') auto,
              count(*) dfs
       from sys.dba_data_files df1
       group by tablespace_name
       union all
       select sum(bytes)/1024/1024 alloc,
              sum(maxbytes)/1024/1024 max,
              max(maxbytes)/1024/1024 maxf,
              (select sum(bytes)/1024/1024 from dba_temp_Files df3 where df3.tablespace_name = tablespace_name and df3.AUTOEXTENSIBLE = 'NO') maxn,
              tablespace_name,
              (select count(*) from dba_temp_files df2 where df2.tablespace_name = tablespace_name and df2.AUTOEXTENSIBLE = 'YES') auto,
              count(*) dfs
       from sys.dba_temp_files
       group by tablespace_name )b
where a.tablespace_name (+) = b.tablespace_name
order by 1
)
)
where ( pct_used between 80 and 95 and not exists (select 1 from v$instance where instance_name = 'INTDWOP')
         or 
        pct_used between 85 and 95 and     exists (select 1 from v$instance where instance_name = 'INTDWOP')
      )
and not exists (select 1 from dba_tablespaces where tablesPACE_name=name and contents in ('UNDO','TEMPORARY'))
union all
select 'CONTROL', '&1', '&2', 'TBS', 'CRITICAL',  'Tablespace '|| name||' pct used: '||pct_used
from
(
select
 name,
        round(alloc) alloc,
        round(free) free,
        round(alloc - free) used,
        100 - round((max-(alloc - free))/max*100) pct_used,
        '  '||lpad(dfs,2,' ')||' / '||lpad(auto,2,' ')||' ' " DFs / Aut",
        decode(auto,dfs,'   ',0,'   ',' X') Ctl,
        max Max_Size,
        maxf Max_Size_file,
        round(decode(max,0,0,(alloc/max)*100)) pct_max_alloc
from (
select nvl(b.tablespace_name, nvl(a.tablespace_name,'UNKOWN')) name,
       alloc,
       nvl(free,0) free,
       auto,
       dfs,
--       maxn,
       nvl(max,0) + nvl(maxn,0) max,
       nvl(maxf,0) maxf
from ( select round(sum(bytes)/1024/1024) free,
              tablespace_name
       from  sys.dba_free_space
       group by tablespace_name ) a,
     ( select sum(bytes)/1024/1024 alloc,
              sum(maxbytes)/1024/1024 max,
              max(maxbytes)/1024/1024 maxf,
              (select sum(bytes)/1024/1024 from dba_data_Files df3 where df3.tablespace_name = df1.tablespace_name and df3.AUTOEXTENSIBLE = 'NO') maxn,
              tablespace_name,
              (select count(*) from dba_data_files df2 where df2.tablespace_name = df1.tablespace_name and df2.AUTOEXTENSIBLE = 'YES') auto,
              count(*) dfs
       from sys.dba_data_files df1
       group by tablespace_name
       union all
       select sum(bytes)/1024/1024 alloc,
              sum(maxbytes)/1024/1024 max,
              max(maxbytes)/1024/1024 maxf,
              (select sum(bytes)/1024/1024 from dba_temp_Files df3 where df3.tablespace_name = tablespace_name and df3.AUTOEXTENSIBLE = 'NO')maxn,
              tablespace_name,
              (select count(*) from dba_temp_files df2 where df2.tablespace_name = tablespace_name and df2.AUTOEXTENSIBLE = 'YES') auto,
              count(*) dfs
       from sys.dba_temp_files
       group by tablespace_name )b
where a.tablespace_name (+) = b.tablespace_name
order by 1
)
)
where pct_used >= 95
and not exists (select 1 from dba_tablespaces where tablesPACE_name=name and contents in ('UNDO','TEMPORARY'))
/

select 'CONTROL', '&1', '&2', 'AUD', 'WARNING', 'Tamaño tabla auditoría (AUD$): '|| round(sum(bytes)/1024/1024,2)||' M' 
from dba_segments
where segment_name = 'AUD$'
group by segment_name
having round(sum(bytes)/1024/1024,2) >= 250
/

col sql format a100
select 'CONTROL', '&1', '&2', 'KEEP', 'WARNING', 'Valor parámetro '||name||' <> 15: '||value sql 
from v$parameter 
where name ='control_file_record_keep_time' and value <> '15'
and not exists (select 1 from v$instance where instance_name in('SARGPOP')
/


col sql format a100
select 'CONTROL', '&1', '&2', 'BCT', 'WARNING', 'Block Change Tracking DISABLED' sql
from v$block_change_tracking
where status <> 'ENABLED' 
and not exists (select 1 from v$instance where instance_name in ('SARGPOP','NEXUSHR0','NEXUSHR1','NEXUSHR2','NEXUSHR3'))
/

select 'CONTROL', '&1', '&2', 'JOB', 'WARNING', 'Broken Jobs: '||aux.cantidad sql
from (select count(*) cantidad from dba_jobs where broken = 'Y') aux
where aux.cantidad > 0
/

select 'CONTROL', '&1', '&2', 'JOB2', 'WARNING', 'Execution Error Jobs: '||cantidad sql
from (select count(*) cantidad from dba_jobs where failures > 0 and broken = 'N') aux
where aux.cantidad > 0
/

select 'CONTROL', '&1', '&2', 'OBJ', 'WARNING', 'Invalid Objects: '||cantidad sql
from (select count(*) cantidad from dba_objects where status <> 'VALID'
and object_name not in ('SNAPSHOT','WB_RTI_WORKFLOW_UTIL','WB_OLAP_LOAD_CUBE','WB_OLAP_LOAD_DIMENSION',
                        'WB_OLAP_LOAD_DIMENSION_GENUK','PKG_CALCULOSPROCESAR','PKG_INTERFACE_PROCESOINICIAL',
                        'F_CALCULA_GAREX_GS', 'F_CALCULA_VENTAS_GS','F_CALCULA_RENTABILIDAD_GS','F_MAIN_GESTION_SUCURSAL','SEVEN_EXCEL_PERFORMANCE')
and owner not in ('OWB2_GAR','ADMREC')
) aux
where aux.cantidad > 0
and exists (select 1 from v$instance where instance_name in ('gardb','gardw','clondb') or instance_name like '%OP')
/

select 'CONTROL', '&1', '&2', 'SPF', 'WARNING', 'No está definido el spfile' sql
from v$parameter 
where name = 'spfile' and value is  null
and not exists (select 1 from v$instance where instance_name in ('NEXUSHR0','NEXUSHR1','NEXUSHR2','NEXUSHR3'))
/

select 'CONTROL', '&1', '&2', 'SPF', 'WARNING', 'proc: '||proc||' sess: '||sess||' - max_proc: '||max_proc||' max_sess: '||max_sess 
from
(
select 
      (select count(*) from v$process) proc,
      (select count(*) from v$session) sess,
      (select to_number(value) from v$parameter where name = 'processes' ) max_proc,
      (select to_number(value) from v$parameter where name = 'sessions' ) max_sess
from dual 
) aux
where (proc / max_proc > 0.8) or (sess / max_sess > 0.8)
union all
select 'CONTROL', '&1', '&2', 'SPF', 'CRITICAL', 'proc: '||proc||' sess: '||sess||' - max_proc: '||max_proc||' max_sess: '||max_sess sql
from
(
select 
      (select count(*) from v$process) proc,
      (select count(*) from v$session) sess,
      (select to_number(value) from v$parameter where name = 'processes' ) max_proc,
      (select to_number(value) from v$parameter where name = 'sessions' ) max_sess
from dual 
) aux
where (proc / max_proc > 0.95) or (sess / max_sess > 0.95)
/

exit

