SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY OFF

COLUMN parameter FORMAT a45 HEADING 'Option Name'
COLUMN value FORMAT a10 HEADING 'Installed?'

SELECT
parameter
, value
FROM
v$option
ORDER BY
parameter
/
