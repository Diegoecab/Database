-- ------------------------------------------------------------------------------
-- File       : sys_time_model_vview.sql
-- Purpose    : Oracle administration helper: v$sys time model (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @v$sys_time_model (1).sql
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
select  case db_stat_name
            when 'parse time elapsed' then 
                'soft parse time'
            else db_stat_name
            end db_stat_name,
        case db_stat_name
            when 'sql execute elapsed time' then 
                time_secs - plsql_time 
            when 'parse time elapsed' then 
                time_secs - hard_parse_time
            else time_secs
            end time_secs,
        case db_stat_name
            when 'sql execute elapsed time' then 
                round(100 * (time_secs - plsql_time) / db_time,2)
            when 'parse time elapsed' then 
                round(100 * (time_secs - hard_parse_time) / db_time,2)  
            else round(100 * time_secs / db_time,2)  
            end pct_time
from
(select stat_name db_stat_name,
        round((value / 1000000),3) time_secs
    from sys.v_$sys_time_model
    where stat_name not in('DB time','background elapsed time',
                            'background cpu time','DB CPU')),
(select round((value / 1000000),3) db_time 
    from sys.v_$sys_time_model 
    where stat_name = 'DB time'),
(select round((value / 1000000),3) plsql_time 
    from sys.v_$sys_time_model 
    where stat_name = 'PL/SQL execution elapsed time'),
(select round((value / 1000000),3) hard_parse_time 
    from sys.v_$sys_time_model 
    where stat_name = 'hard parse elapsed time')
order by 2 desc;