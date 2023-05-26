select a.tablespace_name, round(sum(bytes)/1024/1024/1024,2) "Occupied GB",
round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) "MAX GB",
round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) - round(sum(bytes)/1024/1024/1024,2)
as "Free GB",
round(100-((((((sum(decode(maxbytes,0,bytes,maxbytes))) -
(sum(bytes)))*100) /
((sum(decode(maxbytes,0,bytes,maxbytes))))))))
 as "Current percent Used" from dba_data_files a
group by tablespace_name order by 5
/
