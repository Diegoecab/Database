-- ------------------------------------------------------------------------------
-- File       : scalar_subquery_in_where_clause.sql
-- Purpose    : oracle/admin third_party helper: scalar subquery in where clause.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: scalar_subquery_in_where_clause.sql
-- Parameters : arg2, prev_child_number, prev_sql_id
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

-- A-Times were misestimated with the default sampling 
-- ALTER SESSION SET "_rowsource_statistics_sampfreq"=1; 
ALTER SESSION SET "_serial_direct_read"=ALWAYS;

SELECT /*+ MONITOR test2a */
    SUM(LENGTH(object_name)) + SUM(LENGTH(object_type)) + SUM(LENGTH(owner))
FROM
    test_objects_100m o
WHERE
    o.owner = (SELECT u.username FROM test_users u WHERE user_id = 13)
/
@getprev
@xpi &prev_sql_id
@xia &prev_sql_id &prev_child_number

-- @ash/asqlmon &prev_sql_id &prev_child_number
-- @sqlidx &prev_sql_id &prev_child_number

SELECT /*+ MONITOR NO_PUSH_SUBQ(@"SEL$2") test2b */
    SUM(LENGTH(object_name)) + SUM(LENGTH(object_type)) + SUM(LENGTH(owner))
FROM
    test_objects_100m o
WHERE
    o.owner = (SELECT u.username FROM test_users u WHERE user_id = 13)
/
@getprev
-- @ash/asqlmon &prev_sql_id &prev_child_number
-- @sqlidx &prev_sql_id &prev_child_number
@xpi &prev_sql_id
@xia &prev_sql_id &prev_child_number

-- ALTER SESSION SET "_rowsource_statistics_sampfreq"=128;


SELECT /*+ MONITOR OPT_PARAM('cell_offload_processing', 'false') test3a */
    SUM(LENGTH(object_name)) + SUM(LENGTH(object_type)) + SUM(LENGTH(owner))
FROM
    test_objects_100m o
WHERE
    o.owner = (SELECT u.username FROM test_users u WHERE user_id = 13)
/

SELECT /*+ MONITOR NO_PUSH_SUBQ(@"SEL$2") OPT_PARAM('cell_offload_processing', 'false') test3b */
    SUM(LENGTH(object_name)) + SUM(LENGTH(object_type)) + SUM(LENGTH(owner))
FROM
    test_objects_100m o
WHERE
    o.owner = (SELECT u.username FROM test_users u WHERE user_id = 13)
/


SELECT /*+ MONITOR PUSH_SUBQ(@"SEL$2") OPT_PARAM('cell_offload_processing', 'true') test4a */
    SUM(LENGTH(object_name)) + SUM(LENGTH(object_type)) + SUM(LENGTH(owner))
FROM
    test_objects_100m o
WHERE
    o.owner = (SELECT u.username FROM test_users u WHERE user_id = 13)
/

SELECT /*+ MONITOR NO_PUSH_SUBQ(@"SEL$2") OPT_PARAM('cell_offload_processing', 'true') test4b */
    SUM(LENGTH(object_name)) + SUM(LENGTH(object_type)) + SUM(LENGTH(owner))
FROM
    test_objects_100m o
WHERE
    o.owner = (SELECT u.username FROM test_users u WHERE user_id = 13)
/



