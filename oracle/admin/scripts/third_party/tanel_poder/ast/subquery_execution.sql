-- ------------------------------------------------------------------------------
-- File       : subquery_execution.sql
-- Purpose    : oracle/admin third_party helper: subquery execution.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: subquery_execution.sql
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

-- starting from 10g, the push_subq hint must be specified in the subquery block
-- you wish to push earlier (or with the @subq hint addressing)

select
   e.*
 , d.dname
from
   scott.emp   e
 , scott.dept  d
where
    e.deptno = d.deptno
and exists (
        select /*+ no_unnest push_subq */
            1
        from 
            scott.bonus b
        where
            b.ename = e.ename
        and b.job   = e.job
)
/

