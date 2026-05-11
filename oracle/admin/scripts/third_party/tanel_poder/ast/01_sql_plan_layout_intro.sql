-- ------------------------------------------------------------------------------
-- File       : 01_sql_plan_layout_intro.sql
-- Purpose    : oracle/admin third_party helper: 01 sql plan layout intro.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: 01_sql_plan_layout_intro.sql
-- Parameters : Review script body before running.
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

-- view merging

select * from dual;

select * from table(dbms_xplan.display_cursor);

create or replace view v as select * from dual;

select * from (select * from v);

alter session set "_simple_view_merging"=false;

select * from (select * from v);

alter session set "_simple_view_merging"=true;

select * from (select /*+ NO_MERGE */ * from v);

select * from (select rownum r, v.* from v);


-- scalar subqueries, run a subquery for populating a value in a single column or a row (9i+)

select owner, count(*) from test_objects o group by owner;

-- another way (excludes nulls if any)

select u.username, (select count(*) from test_objects o where u.username = o.owner) obj_count from test_users u;

select * from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


