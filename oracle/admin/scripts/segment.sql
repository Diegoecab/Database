set linesize 150
col segment_name format a25
select owner, tablespace_name, segment_name, segment_type, round(sum(bytes)/1024/1024,2) MB
from dba_segments
where segment_name like upper('&1')
group by owner, tablespace_name, segment_name, segment_type
union
select s.owner, s.tablespace_name, s.segment_name||'-LOB', s.segment_type, round(sum(bytes)/1024/1024,2) MB
from dba_lobs l, dba_segments s
where s.segment_type = 'LOBSEGMENT'
and l.table_name like upper('&1')
and s.segment_name = l.segment_name
group by s.owner, s.tablespace_name, s.segment_name, segment_type
/