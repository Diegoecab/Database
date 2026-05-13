-- ------------------------------------------------------------------------------
-- File       : CurrentSQLRAC.sql
-- Purpose    : Oracle RAC or cluster administration helper: CurrentSQLRAC.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @CurrentSQLRAC.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--

REM Filename:  CurrentSQL.sql
REM

set lines 70
clear col

col "Total Memory" for 999,999,999,999
col "Average Memory" for 999,999,999,999
col Num_Statements for 999,999,999 head "Num of|Statements"
col "TotExecs" for 999,999,999

SELECT sum(sharable_mem) "Total Memory"
  ,avg(sharable_mem) "Average Memory"
 ,count(*) Num_Statements
 ,sum(executions) "Total Execs"
FROM gv$sql
/

/*----------------------------------------------------

Sample Output
                                        Num of
    Total Memory   Average Memory   Statements   TotExecs
---------------- ---------------- ------------ ----------
         937,400            9,374          100       3,294
*/