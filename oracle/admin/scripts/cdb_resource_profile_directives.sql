COLUMN plan FORMAT A30
COLUMN pluggable_database FORMAT A25
COLUMN profile FORMAT A25
SET LINESIZE 150 VERIFY OFF

SELECT plan,
       pluggable_database,
       profile,
       shares,
       utilization_limit AS util,
       parallel_server_limit AS parallel
FROM   dba_cdb_rsrc_plan_directives
WHERE  plan = DECODE(UPPER('&1'), 'ALL', plan, UPPER('&1'))
ORDER BY plan, pluggable_database, profile;

SET VERIFY ON