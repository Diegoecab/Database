-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2004 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_options.sql                                                 |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Report on all Oracle installed options.                         |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY   OFF

COLUMN parameter  FORMAT a45   HEADING 'Option Name'
COLUMN value      FORMAT a10   HEADING 'Installed?'

SELECT
    parameter
  , value
FROM
    v$option
ORDER BY
    parameter;