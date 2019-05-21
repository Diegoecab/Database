select name,auto,alloc,pct_used,used,pct_used_s_auto,free,pct_used_s_auto - 78,round((((pct_used_s_auto-78)*ALLOC/100)),1) MB,round(round((((pct_used_s_auto-78)*ALLOC/100)),2)/1024) GB from (
select 
    name,
        round(alloc) alloc,
        round(free) free,
        round(alloc - free) used,
        100 - round((max-(alloc - free))/max*100) pct_used,
        100 - round(100-((alloc - free)/alloc*100)) pct_used_s_auto,
        '  '||lpad(dfs,2,' ')||' / '||lpad(auto,2,' ')||' ' " DFs / Aut",        
        decode(auto,dfs,'   ',0,'   ',' X') Ctl,
        max Max_Size,
        maxf Max_Size_file,        
        round(decode(max,0,0,(alloc/max)*100)) pct_max_alloc,
        auto
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
)
) where pct_used_s_auto >= 78 and NAME not in('TEMP','USERS','SYSTEM','SYSAUX','UNDO')