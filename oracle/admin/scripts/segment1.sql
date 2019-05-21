col segment_name format a25
break   on report 
compute sum of MB on report 
select tablespace_name, segment_type, count(*), round(sum(bytes)/1024/1024,2) MB
from dba_segments
where owner like upper('&1')
group by tablespace_name, segment_type
/