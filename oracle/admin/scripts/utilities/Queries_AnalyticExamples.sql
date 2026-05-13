-- ------------------------------------------------------------------------------
-- File       : Queries_AnalyticExamples.sql
-- Purpose    : Oracle administration helper: Queries AnalyticExamples.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Queries_AnalyticExamples.sql
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
Analytic Example

The following example calculates, for each employee in the employees table, the moving count of employees earning salaries in the range 50 less than through 150 greater than the employee's salary.

SELECT last_name, salary,
   COUNT(*) OVER (ORDER BY salary RANGE BETWEEN 50 PRECEDING
      AND 150 FOLLOWING) AS mov_count FROM employees;

LAST_NAME                     SALARY  MOV_COUNT
------------------------- ---------- ----------
Olson                           2100          3
Markle                          2200          2
Philtanker                      2200          2
Landry                          2400          8
Gee                             2400          8
Colmenares                      2500         10
Patel                           2500         10