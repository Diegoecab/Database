-- Buffer Gets : 10,000
-- Physical Reads : 1,000
-- Executions : 100
-- Parse Calls : 1,000
-- Sharable Memory : 1,048576
-- Version Count : 20

set linesize 180
set pagesize 0
set echo off
set head on

col sql format a80

prompt
prompt Top 10 by Buffer Gets:

set pagesize 100
SELECT * FROM
(SELECT substr(sql_text,1,80) sql,
        buffer_gets, executions, round(buffer_gets/executions,2) "Gets/Exec",
        hash_value,address
   FROM V$SQLAREA
  WHERE buffer_gets > 10000
 ORDER BY buffer_gets DESC)
WHERE rownum <= 10
;

prompt
prompt Top 10 by Physical Reads:

set pagesize 100
SELECT * FROM
(SELECT substr(sql_text,1,80) sql,
        disk_reads, executions, round(disk_reads/executions,2) "Reads/Exec",
        hash_value,address
   FROM V$SQLAREA
  WHERE disk_reads > 1000
 ORDER BY disk_reads DESC)
WHERE rownum <= 10
;

prompt
prompt Top 10 by Executions:

set pagesize 100
SELECT * FROM
(SELECT substr(sql_text,1,80) sql,
        executions, rows_processed, round(rows_processed/executions,2) "Rows/Exec",
        hash_value,address
   FROM V$SQLAREA
  WHERE executions > 100
 ORDER BY executions DESC)
WHERE rownum <= 10
;

prompt
prompt Top 10 by Parse Calls:

set pagesize 100
SELECT * FROM
(SELECT substr(sql_text,1,80) sql,
        parse_calls, executions, hash_value,address
   FROM V$SQLAREA
  WHERE parse_calls > 1000
 ORDER BY parse_calls DESC)
WHERE rownum <= 10
;

prompt
prompt Top 10 by Sharable Memory:

set pagesize 100
SELECT * FROM 
(SELECT substr(sql_text,1,80) sql,
        sharable_mem, executions, hash_value,address
   FROM V$SQLAREA
  WHERE sharable_mem > 1048576
 ORDER BY sharable_mem DESC)
WHERE rownum <= 10
;

prompt
prompt Top 10 by Version Count:


set pagesize 100
SELECT * FROM 
(SELECT substr(sql_text,1,80) sql,
        version_count, executions, hash_value,address
   FROM V$SQLAREA
  WHERE version_count > 20
 ORDER BY version_count DESC)
WHERE rownum <= 10
;

-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/top_sql.sql
-- Author       : DR Timothy S Hall
-- Description  : Displays a list of SQL statements that are using the most resources.
-- Comments     : The address column can be use as a parameter with SQL_Text.sql to display the full statement.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @top_sql (number)
-- Last Modified: 15/07/2000
-- Last Modified: 15/08/2007 Hernan Azpilcueta, lo agrego al top 10
-- -----------------------------------------------------------------------------------
SET LINESIZE 180
set pagesize 100
SET VERIFY OFF
col sql_text format a50

prompt
prompt Top 10 by Most Resources

SELECT *
FROM   (SELECT Substr(a.sql_text,1,50) sql_text,
               Trunc(a.disk_reads/Decode(a.executions,0,1,a.executions)) reads_per_execution, 
               a.buffer_gets, 
               a.disk_reads, 
               a.executions, 
               a.sorts,
               a.address
        FROM   v$sqlarea a
        ORDER BY 2 DESC)
WHERE  rownum <= 10
/
