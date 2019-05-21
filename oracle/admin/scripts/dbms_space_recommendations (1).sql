col c1 for a40
col segment_name for a20
col segment_type for a15
col partition_name for a10
col segment_owner for a15
col tablespace_name for a15
col allocated_space for 99999
col reclaimable_space for 99999
set linesize 300
set pagesize 1000
select  round(allocated_space/1024/1024) allocated_space,
round(reclaimable_space/1024/1024) reclaimable_space,
c1,tablespace_name,segment_owner, segment_name, segment_type
 from
table(dbms_space.asa_recommendations('FALSE', 'FALSE', 'FALSE'))
order by 2,4,5;