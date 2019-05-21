set pagesize 100
set linesize 200
col segment_name format a30
col segment_type format a20
col sizeM format 99999.99
select owner, tablespace_name, segment_type, segment_name, trunc(sum(bytes)/1024/1024) 
from dba_segments where tablespace_name=upper('&1')  
group by owner, tablespace_name, segment_type, segment_name 
having  trunc(sum(bytes)/1024/1024) > &2 
order by  trunc(sum(bytes)/1024/1024) desc
/
