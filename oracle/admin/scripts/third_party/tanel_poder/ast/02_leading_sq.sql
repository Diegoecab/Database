-- ------------------------------------------------------------------------------
-- File       : 02_leading_sq.sql
-- Purpose    : oracle/admin third_party helper: 02 leading sq.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: 02_leading_sq.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

select 
/*+
  no_unnest(@my_sub)
  leading  (@my_sub emp_inner@my_sub)
  use_merge (@my_sub dept_inner@my_sub)
*/
   *
from 
   scott.emp emp_outer
where 
   emp_outer.deptno in (
       select /*+ qb_name(my_sub) */
           dept_inner.deptno
       from 
           scott.dept dept_inner
         , scott.emp  emp_inner
       where 
           dept_inner.dname like 'S%'
       and emp_inner.ename   = dept_inner.dname
       and dept_inner.deptno = emp_outer.deptno
   )
/
