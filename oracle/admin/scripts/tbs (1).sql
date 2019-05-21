ttitle 'Reporte Tablespaces'

column dummy noprint

column  pct_used format 99999    heading "%|Usado" 
column  name    format a20       heading "Tablespace Name" 
column  alloc   format 9,999,999 heading "Total Alloc" 
column  used    format 9,999,999 heading "Usado" 
column  free    format 9,999,999 heading "Libre" 
column  " DFs / Aut" format a10
column  max_size format 9,999,999
column  max_size_file format 9,999,999
column	block_size heading 'Block|Size' format 99

Break on name on report 

compute sum of alloc on report 
compute sum of free  on report 
compute sum of used  on report 


set linesize 170
set pagesize 10000


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
        round(decode(max,0,0,(alloc/max)*100)) pct_max_alloc,
		b.block_size/1024||'K' block_size
from (
select nvl(b.tablespace_name, nvl(a.tablespace_name,'UNKNOW')) name,
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
) a inner join dba_tablespaces b on b.tablespace_name=a.name
;


ttitle off