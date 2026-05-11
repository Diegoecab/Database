-- ------------------------------------------------------------------------------
-- File       : user_segments.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: user segments.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @user_segments.sql
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
--user_segments

set pages 1000
set verify off
set feedback off
set lines 600
set head on

undefine all
col owner for a20
col segment_name for a40
col partition_name for a20 truncate
col size_mb for 99999999


break on owner on report
compute sum of size_mb on report

select segment_type, segment_name, partition_name, tablespace_name, round(bytes/1024/1024) size_mb
from 
user_segments
where upper(segment_name) like upper('%&segment_name%')
and segment_name not like 'BIN$%' --Recycle bin
and segment_type like upper('%&segment_type%')
and nvl(partition_name,'null') like upper('%&partition_mame%')
and tablespace_name like upper('%&tablespace_name%')
and bytes/1024/1024/1024 > nvl ('&gb',0)
order by size_mb
/