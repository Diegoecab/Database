select * from (
SELECT tablespace_name, SUBSTR (FILE_NAME, 1, 22) PATH, round(sum(bytes/1024/1024/1024),1) GB
          FROM DBA_DATA_FILES
      GROUP BY tablespace_name, ROLLUP (SUBSTR (FILE_NAME, 1, 22) ) order by tablespace_name,path) where path is not null
	  
	  
	  
	  

	  
***************



SELECT a.host_name,instance_name,tablespace_name,path,round(bytes/1024/1024,0),round(bytes/1024/1024/1024,1),round(alloc/1024),b.used,b.pct_used,auto FROM ( 
SELECT b.host_name,b.instance_name,a.* 
  FROM (SELECT * FROM (SELECT   tablespace_name, SUBSTR (file_name, 1, 22) PATH,SUM (BYTES) bytes 
                    FROM dba_data_files GROUP BY tablespace_name, ROLLUP (SUBSTR (file_name, 1, 22)) 
                ORDER BY tablespace_name, PATH) 
         WHERE PATH IS NOT NULL) a JOIN v$instance b on 1=1) a JOIN ( select name, round(alloc) alloc, 
        round(free) free, 
        round(alloc - free) used, 
        100 - round((max-(alloc - free))/max*100) pct_used,        
        decode(auto,dfs,'   ',0,'   ',' X') Ctl, 
        max Max_Size, 
        maxf Max_Size_file,         
        round(decode(max,0,0,(alloc/max)*100)) pct_max_alloc, 
auto from ( 
select nvl(b.tablespace_name, nvl(a.tablespace_name,'UNKNOW')) name, 
       alloc, 
       nvl(free,0) free, 
       auto, 
       dfs, 
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
) b on b.name=a.tablespace_name order by tablespace_name,path





****************



*****Datafile


SELECT a.*,b.free free_gb ,b.usado USADO_MB  FROM (
SELECT a.host_name servidor, a.instance_name DATABASE,
       b.tablespace_name TABLESPACE, b.file_name DATAFILE,
       ROUND (b.BYTES / 1024 / 1024 / 1024, 1) tam,
       ROUND (b.maxbytes / 1024 / 1024 / 1024, 1) tam_max
  FROM v$instance a JOIN dba_data_files b
       ON 1 = 1
     AND autoextensible = 'YES'
     AND (    tablespace_name NOT IN ('SYSTEM', 'TEMP', 'SYSAUX')
          AND tablespace_name NOT LIKE 'UNDO%'
         )) a join 
         (
 select tablespace_name ,file_name,round(total_bytes/1024/1024) total_bytes,round(free_bytes/1024/1024/1024) free,round(used_bytes/1024/1024) usado from 
 (SELECT  d.tablespace_name , MAX (d.BYTES) total_bytes, NVL (SUM (f.BYTES), 0) free_bytes,
         d.file_name, MAX (d.BYTES) - NVL (SUM (f.BYTES), 0) used_bytes
    FROM dba_free_space f, dba_data_files d
   WHERE f.tablespace_name(+) = d.tablespace_name
     AND f.file_id(+) = d.file_id
GROUP BY d.file_name,d.tablespace_name)
) b on b.tablespace_name=a.tablespace and b.FILE_NAME=a.datafile order by tablespace,datafile




******************
*****Datafile + pct used de tablespace


select c.host_name,c.instance_name,a.*,b.pct_used pct_used_tbs from (
select df.tablespace_name
,      df.file_name
,      round(df.bytes/1024/1024/1024,1)                        total_size
,       df.MAXBYTES/1024/1024/1024                    max_gb
,      round(nvl(fr.bytes/1024/1024/1024,0))                 free_space
,      round(((df.bytes-nvl(fr.bytes,0))/df.bytes)*100) pct_used_datafile
,       round((df.bytes- nvl(fr.bytes,0))/1024/1024/1024,1)            used_gb 
from   (select sum(bytes) bytes
        ,      file_id
        from   dba_free_space
        group by file_id)     fr
,       dba_data_files        df
where df.file_id = fr.file_id(+)
and df.autoextensible='YES'
order by 1, df.file_id) a join
(
select round(pct_used) pct_used, tablespace_name from (
select (
       (kbytes_alloc-nvl(kbytes_free,0))/ 
                          kbytes_alloc)*100 pct_used,
                          a.tablespace_name
from ( select sum(bytes)/1024 Kbytes_free, 
              tablespace_name
       from  sys.dba_free_space 
       group by tablespace_name ) a,
     ( select sum(bytes)/1024 Kbytes_alloc, 
              tablespace_name 
       from sys.dba_data_files 
       group by tablespace_name)b
where a.tablespace_name (+) = b.tablespace_name)
) b on b.tablespace_name=a.tablespace_name
join
v$instance c on 1=1