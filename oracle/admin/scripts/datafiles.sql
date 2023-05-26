REM	Script para obtener el tamaño y espacio libre por datafile
REM ======================================================================
REM datafiles.sql		Version 1.1	10 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	
REM
REM Notas:
REM Precauciones:
REM	
REM ======================================================================
REM

SET LINESIZE 600
SET PAGESIZE 30
SET VERIFY   OFF

COLUMN tablespace  FORMAT a18             HEADING 'Tablespace Name'
COLUMN filename    FORMAT a100   truncate          HEADING 'Filename'
COLUMN filesize    FORMAT 9999999999999 HEADING 'File Size (Gb)'
COLUMN used        FORMAT 9999999999999  HEADING 'Used (in Gb)'
COLUMN pct_used    FORMAT 999             HEADING 'Pct. Used'

BREAK ON report
COMPUTE SUM OF filesize  ON report
COMPUTE SUM OF used      ON report
COMPUTE AVG OF pct_used  ON report

select * from (
SELECT /*+ ordered */
    d.tablespace_name                     tablespace
  , d.file_name                           filename
  , d.file_id                             file_id
  , autoextensible auto
  , CREATION_TIME
  , d.bytes/1024/1024/1024                               filesize
  , NVL((d.bytes - s.bytes), d.bytes)/1024/1024/1024     used
  , round(maxbytes/1024/1024/1024) maxsize_gb
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
  , autoextensible auto
  , CREATION_TIME
  , d.bytes/1024/1024/1024                                 filesize
  , NVL(t.bytes_cached/1024/1024/1024, 0)                  used
  , maxbytes/1024/1024/1024 maxsize_gb
  , TRUNC((t.bytes_cached / d.bytes) * 100) pct_used
FROM
    sys.dba_temp_files d
  , v$temp_extent_pool t
  , v$tempfile v
WHERE 
      (t.file_id (+)= d.file_id)
  AND (d.file_id = v.file#))
  where upper(tablespace) like upper('%&tablespace_name%')
and filename like ('%&file_name%')
/
