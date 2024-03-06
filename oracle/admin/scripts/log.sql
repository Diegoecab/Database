--v$log.sql

col status for a10

SELECT group#, thread#, sequence#, ROUND (BYTES / 1024 / 1024) mb, members,
       archived, status, first_change#, first_time
  FROM v$log;
