select owner, segment_name, partition_name,segment_type, tablespace_name from
dba_extents where file_id= &file_id
and &block_id between block_id and block_id+blocks-1;
