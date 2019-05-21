--dba_data_files_shrink.sql
set verify off
ACCEPT DB_BLOCK_SIZE PROMPT 'DB_BLOCK_SIZE : '
ACCEPT ts_name PROMPT 'TABLESPACE NAME: '

col cmd for a100
set lines 300

SELECT   bytes / 1024 / 1024 real_size,
         CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024) shrinked_size,
         bytes / 1024 / 1024
         - CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024)
            released_size,
            'alter database datafile '
         || ''''
         || file_name
         || ''''
         || ' resize '
         || CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024)
         || ' m;'
            cmd
  FROM   dba_data_files a, (  SELECT   file_id, MAX (block_id + blocks - 1) hwm
                                FROM   dba_extents
                            GROUP BY   file_id) b
 WHERE       tablespace_name = '&ts_name'
         AND a.file_id = b.file_id(+)
         AND CEIL (blocks * &DB_BLOCK_SIZE / 1024 / 1024)
            - CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024) > 0;