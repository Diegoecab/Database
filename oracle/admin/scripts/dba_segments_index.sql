set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col segment_type heading "Segment|Type" for a20
col segment_name heading "Segment|Name" for a40
col tablespace_name heading "Tablespace|Name" for a20

Break on segment_name on report 
compute sum of mb on report 

select segment_type,segment_name,tablespace_name,bytes/1024/1024 MB, count(*) num_parts from dba_Segments
where owner=upper('&OWNER') and segment_name='&segment_name'
group by segment_type,segment_name,tablespace_name

clear break
ttitle off
