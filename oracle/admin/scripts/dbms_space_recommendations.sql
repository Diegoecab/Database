--dbms_space_recommendations
col c1 for a120
col segment_name for a40
col partition_name for a40
col segment_type for a20
col segment_owner for a20
col tablespace_name for a30
col allocated_space for 99999
col diff_alloc_space for 99999
col reclaimable_space for 99999
COL rec_space_real for 99999
break on segment_name on report 
set feedback off
set verify off
set lines 400
set pages 1000

compute sum of reclaimable_space on report 
compute sum of rec_space_real on report 


select  round(allocated_space/1024/1024) allocated_space, 
round(bytes/1024/1024) alloc_space_seg, 
(round(allocated_space/1024/1024)) - (round(bytes/1024/1024)) diff_alloc_space,
round(reclaimable_space/1024/1024) reclaimable_space,
round(reclaimable_space/1024/1024) - ((round(allocated_space/1024/1024)) - (round(bytes/1024/1024))) rec_space_real,
a.tablespace_name,a.segment_owner, a.segment_name, a.partition_name,a.segment_type,c1
from table(dbms_space.asa_recommendations('FALSE', 'FALSE', 'FALSE')) a, dba_segments b
where b.owner=a.segment_owner and b.segment_name=a.segment_name and b.segment_type=a.segment_type and nvl(b.partition_name,'null')=nvl(a.partition_name,'null')
and a.segment_owner like upper('%&segment_owner%')
and a.tablespace_name like upper('%&tablespace_name%')
and a.segment_name like upper('%&segment_name%')
and a.segment_type like upper('%&segment_type%')
order by rec_space_real
/

PROMPT
PROMPT Group by tbs
PROMPT
select a.tablespace_name,
round(sum(reclaimable_space)/1024/1024) reclaimable_space,
round(sum(reclaimable_space)/1024/1024) - ((round(sum(allocated_space)/1024/1024)) - (round(sum(bytes)/1024/1024))) rec_space_real
from table(dbms_space.asa_recommendations('FALSE', 'FALSE', 'FALSE')) a, dba_segments b
where b.owner=a.segment_owner and b.segment_name=a.segment_name and b.segment_type=a.segment_type and nvl(b.partition_name,'null')=nvl(a.partition_name,'null')
group by a.tablespace_name order by rec_space_real
/

PROMPT
PROMPT Para ver SQLs: dbms_space_recommendations_sql.sql
PROMPT

set feedback on