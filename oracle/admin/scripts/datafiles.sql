-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2004 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_file_space_usage.sql                                        |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Reports on all data file usage. This script was designed to     |
-- |            work with Oracle8i or higher. It will include true TEMPORARY    |
-- |            tablespaces. (i.e. use of "tempfiles")                          |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY   OFF

COLUMN tablespace  FORMAT a18             HEADING 'Tablespace Name'
COLUMN filename    FORMAT a50             HEADING 'Filename'
COLUMN filesize    FORMAT 99,999,999,999  HEADING 'File Size'
COLUMN used        FORMAT 99,999,999,999  HEADING 'Used (in bytes)'
COLUMN pct_used    FORMAT 999             HEADING 'Pct. Used'

BREAK ON report
COMPUTE SUM OF filesize  ON report
COMPUTE SUM OF used      ON report
COMPUTE AVG OF pct_used  ON report

SELECT /*+ ordered */
    d.tablespace_name                     tablespace
  , d.file_name                           filename
  , d.file_id                             file_id
  , d.bytes                               filesize
  , NVL((d.bytes - s.bytes), d.bytes)     used
  , TRUNC(((NVL((d.bytes - s.bytes) , d.bytes)) / d.bytes) * 100)  pct_used
FROM
    sys.dba_data_files d
  , v$datafile v
  , ( select file_id, SUM(bytes) bytes
      from sys.dba_free_space
      GROUP BY file_id) s
WHERE
      (s.file_id (+)= d.file_id)
  AND (d.file_name = v.name)
UNION
SELECT
    d.tablespace_name                       tablespace 
  , d.file_name                             filename
  , d.file_id                               file_id
  , d.bytes                                 filesize
  , NVL(t.bytes_cached, 0)                  used
  , TRUNC((t.bytes_cached / d.bytes) * 100) pct_used
FROM
    sys.dba_temp_files d
  , v$temp_extent_pool t
  , v$tempfile v
WHERE 
      (t.file_id (+)= d.file_id)
  AND (d.file_id = v.file#)
/
