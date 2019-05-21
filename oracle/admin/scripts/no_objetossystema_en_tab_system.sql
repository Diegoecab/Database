SELECT owner, segment_name, partition_name,
       segment_type, ROUND(bytes / 1048576, 2) size_in_mb
FROM   dba_segments
WHERE  owner NOT IN ('SYS', 'SYSTEM')
AND    tablespace_name = 'SYSTEM'
ORDER BY owner, segment_type, segment_name;