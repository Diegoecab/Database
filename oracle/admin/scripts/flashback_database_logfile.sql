----- 
-- Listing 2.7: Flashback Log Query
-----

-- What Flashback Logs are available?
TTITLE 'Current Flashback Logs Available'
COL log#                FORMAT 9999     HEADING 'FLB|Log#'
COL bytes               FORMAT 99999999 HEADING 'Flshbck|Log Size'
COL first_change#       FORMAT 9999999999 HEADING 'Flshbck|SCN #'
COL first_time          FORMAT A24      HEADING 'Flashback Start Time'

SELECT 
    LOG#
    ,bytes
    ,first_change#
    ,first_time
  FROM v$flashback_database_logfile;
