--segments_by_datafile
set lines 900
col file_name for a50
col segment_name for a50
SELECT distinct a.owner, a.segment_name,
 a.SEGMENT_TYPE,
 a.TABLESPACE_NAME,partition_name,
 a.file_id
 --, b.file_name Datafile_name
 FROM dba_extents a, dba_data_files b
 WHERE a.file_id = b.file_id
 AND b.file_id = &file_id
/
