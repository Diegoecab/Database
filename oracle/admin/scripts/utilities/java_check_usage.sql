-- ------------------------------------------------------------------------------
-- File       : java_check_usage.sql
-- Purpose    : Oracle administration helper: java check usage.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @java_check_usage.sql
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
--Is OJVM installed?
SELECT version, status FROM dba_registry WHERE comp_id='JAVAVM';





--Is OJVM used?
select count(*) from x$kglob where KGLOBTYP = 29 OR KGLOBTYP = 56;


col service_name format a20
col username format a20
col program format a20
set num 8

select sess.service_name, sess.username,sess.program, count(*)
from
gv$session sess,
dba_users usr,
x$kgllk lk,
x$kglob
where kgllkuse=saddr
and kgllkhdl=kglhdadr
and kglobtyp in (29,56)
and sess.user# = usr.user_id
and usr.oracle_maintained = 'N'      --#### omit this line on 11.2.0.4
group by sess.service_name, sess.username, sess.program
order by sess.service_name, sess.username, sess.program;