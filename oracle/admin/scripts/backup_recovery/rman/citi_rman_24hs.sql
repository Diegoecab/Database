-- ------------------------------------------------------------------------------
-- File       : citi_rman_24hs.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: citi rman 24hs.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @citi_rman_24hs.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
set pagesize 35
col type     format a4
col handle   format a35 trunc
col file#    format 9999999
col duration format a9

select decode(BACKUP_TYPE, 'L', 'ARCH', 'D', 'DB', 'I', 'INC',
              'Unknown type='||BACKUP_TYPE) TYPE,
       to_char(a.start_time, 'DDMON HH24:MI') start_time,
       to_char(a.elapsed_seconds/60, '99.9')||' Min' DURATION,
       substr(handle, -35) handle,
       nvl(d.file#, l.sequence#) file#, nvl(d.blocks, l.blocks) blocks
from   SYS.V_$BACKUP_SET a, SYS.V_$BACKUP_PIECE b,
       SYS.V_$BACKUP_DATAFILE d, SYS.V_$BACKUP_REDOLOG l
where  a.start_time between sysdate-1 and sysdate
  and  a.SET_STAMP = b.SET_STAMP
  and  a.SET_STAMP = d.SET_STAMP(+)
  and  a.SET_STAMP = l.SET_STAMP(+)
order  by start_time, file#
/
