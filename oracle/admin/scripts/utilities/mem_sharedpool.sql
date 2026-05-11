-- ------------------------------------------------------------------------------
-- File       : mem_sharedpool.sql
-- Purpose    : Oracle administration helper: mem sharedpool.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @mem_sharedpool.sql
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
--mem_sharedpool.sql
prompt
prompt Esta consulta es valida cuando existe un valor fijo para shared_pool_size. (ver nota 396940.1) 
prompt

set numwidth 15
column shared_pool_size format 999999999
column sum_obj_size format 999999999
column sum_sql_size format 999999999
column sum_user_size format 999999999
column min_shared_pool format 999999999
column pct_shared_pool_used format a20
select to_number(value) shared_pool_size, 
                         sum_obj_size,
                         sum_sql_size, 
                         sum_user_size, 
  (sum_obj_size + sum_sql_size+sum_user_size)* 1.3 min_shared_pool, 
'  '||to_char(round(((sum_obj_size + sum_sql_size+sum_user_size)* 1.3) * 100 / to_number(value) ))||'%' pct_shared_pool_used
  from (select sum(sharable_mem) sum_obj_size 
          from v$db_object_cache where type <> 'CURSOR'),
               (select sum(sharable_mem) sum_sql_size
          from v$sqlarea),
               (select sum(250 * users_opening) sum_user_size
          from v$sqlarea), v$parameter
 where name = 'shared_pool_size'
/