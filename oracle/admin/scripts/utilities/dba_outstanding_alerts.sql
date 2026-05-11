-- ------------------------------------------------------------------------------
-- File       : dba_outstanding_alerts.sql
-- Purpose    : Oracle administration helper: dba outstanding alerts.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_outstanding_alerts.sql
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
--dba_outstanding_alerts
col suggested_action for a30
col reason for a50
col object_type for a10
col message_level heading 'mess|lvl' for 9
select
  to_char(creation_time, 'dd-mm-yyyy hh24:mi') crt,
  object_type,
  message_type,
  message_level,
  reason,
  suggested_action
from
  dba_outstanding_alerts
 order by
     creation_time
/