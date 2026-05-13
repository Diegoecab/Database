-- ------------------------------------------------------------------------------
-- File       : sga_usage_hist.sql
-- Purpose    : Oracle administration helper: sga usage hist.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sga_usage_hist.sql
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
select inst_id, component, parameter, initial_size/1024/1024 "INITIAL", final_size/1024/1024 "FINAL", status,
to_char(end_time ,'mm/dd/yyyy hh24:mi:ss') changed
from gv$sga_resize_ops
order by 1, 7
/

select component, current_size/1024/1024 "CURRENT_SIZE", min_size/1024/1024 "MIN_SIZE",
  user_specified_size/1024/1024 "USER_SPECIFIED_SIZE", last_oper_type "TYPE"
  from v$sga_dynamic_components;