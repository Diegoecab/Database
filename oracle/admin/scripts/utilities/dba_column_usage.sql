-- ------------------------------------------------------------------------------
-- File       : dba_column_usage.sql
-- Purpose    : Oracle administration helper: dba column usage.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_column_usage.sql
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
--dba_column_usage.sql
/*
create view dba_column_usage
as
select oo.name owner,
o.name,
c.name column_name,
u.equality_preds,
u.equijoin_preds,
u.nonequijoin_preds,
u.range_preds,
u.like_preds,
u.null_preds,
u.timestamp
from sys.col_usage$ u,
sys.obj$ o,
sys.user$ oo,
sys.col$ c
where o.obj# = u.obj#
and oo.user# = o.owner#
and c.obj# = u.obj#
and c.col# = u.intcol#;

create public synonym dba_column_usage for dba_column_usage;


*/

set lines 400

select * from dba_column_usage 
where owner like upper ('%&owner%')
and name like upper ('%&name%')
and column_name like upper ('%&column_name%')
order by 1,2,10
/