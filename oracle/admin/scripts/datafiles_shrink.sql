--datafiles_shrink.sql
--Author Diego Cabrera Apr 2012
set verify off
ACCEPT DB_BLOCK_SIZE PROMPT 'DB_BLOCK_SIZE [8192] : ' default 8192
ACCEPT ts_name PROMPT 'TABLESPACE NAME: '

col cmd for a200
set lines 600
set pages 1000

BREAK ON report

COMPUTE SUM LABEL 'TOTAL' OF released_size ON report;
COMPUTE SUM LABEL 'TOTAL' OF real_size ON report;
COMPUTE SUM LABEL 'TOTAL' OF shrinked_size ON report;

SELECT   ROUND(bytes / 1024 / 1024) real_size,
         CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024) shrinked_size,
         round(bytes / 1024 / 1024
         - CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024))
            released_size,
            'alter database datafile '
         || ''''
         || name
         || ''''
         || ' resize '
         || CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024)
         || ' m; -- (current size '||bytes/1024/1024||' MB)'
            cmd
  FROM   v$datafile a, (  SELECT   file_id, MAX (block_id + blocks - 1) hwm
                                FROM   dba_extents where file_id in (select FILE# from v$datafile where TS# = (select ts# from v$tablespace where name = '&ts_name'))
                            GROUP BY   file_id) b
 WHERE       TS# = (select ts# from v$tablespace where name = '&ts_name')
         AND a.FILE# = b.file_id
         AND CEIL (blocks * &DB_BLOCK_SIZE / 1024 / 1024)
            - CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024) > 0 order by 3;