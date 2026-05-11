-- ------------------------------------------------------------------------------
-- File       : archive_dest_status.sql
-- Purpose    : Oracle Data Guard administration helper: archive dest status(1).
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @archive_dest_status(1).sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--archive_dest_status
set lines 400
set pages 300
select ads.dest_id,
ads.db_unique_name,
max(sequence#) "Current Sequence",
max(log_sequence) "Last Archived",
max(applied_seq#) "Last Sequence Applied"
from v$archived_log al, v$archive_dest ad, v$archive_dest_status ads
where ad.dest_id=al.dest_id
and al.dest_id=ads.dest_id
group by ads.dest_id, ads.db_unique_name
/
