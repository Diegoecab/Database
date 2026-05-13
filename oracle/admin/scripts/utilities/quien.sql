-- ------------------------------------------------------------------------------
-- File       : quien.sql
-- Purpose    : Oracle administration helper: quien.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @quien.sql
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
set pages 66
set linesize 120
col username format a10 trunc
col osuser format a10 trunc
col machine format a15 trunc
col term format a12 trunc
col program format a13 trunc
col logon format a6
col lockwait format a2
col sid format 999
col serial# format 99999
col spid format 99999
col s format a1
select a.username,a.OSUSER,a.program prg, to_char(a.logon_time,'dd-mm HH24:MI') logon ,a.sid,a.serial#, spid,a.lockwait
from sys.v_$session a, sys.v_$process b
where
a.type = 'USER' and a.username is not null
and  b.addr = a.paddr
order by username;
