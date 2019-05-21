-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2004 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_jobs.sql                                                    |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Provides summary report on all registered and scheduled jobs.   |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY   OFF

COLUMN job        FORMAT 999   HEADING 'Job ID'
COLUMN username   FORMAT a15   HEADING 'User'
COLUMN what       FORMAT a30   HEADING 'What'
COLUMN next_date               HEADING 'Next Run Date'
COLUMN interval   FORMAT a30   HEADING 'Interval'
COLUMN last_date               HEADING 'Last Run Date'
COLUMN failures                HEADING 'Failures'
COLUMN broken     FORMAT a7    HEADING 'Broken?'

SELECT
    job
  , log_user username
  , what
  , TO_CHAR(next_date, 'DD-MON-YYYY HH24:MI:SS') next_date
  , interval
  , TO_CHAR(last_date, 'DD-MON-YYYY HH24:MI:SS') last_date
  , failures
  , broken
FROM
    dba_jobs;
