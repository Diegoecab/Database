-- ------------------------------------------------------------------------------
-- File       : lock_rows.sql
-- Purpose    : Oracle administration helper: lock rows.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @lock_rows.sql
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
set lines 300
set pages 300
col object_name for a40
col program for a20 truncate
col username for a20 truncate
col waiting_sid for 9999999
col serial# for 9999999
select o.owner, o.object_name, sid as waiting_sid, serial#, username, program,blocking_session, seconds_in_wait,  
row_wait_obj#, row_wait_file#, row_wait_block#, row_wait_row#,
dbms_rowid.rowid_create ( 1, o.DATA_OBJECT_ID, ROW_WAIT_FILE#, ROW_WAIT_BLOCK#, ROW_WAIT_ROW# )
from gv$session s, dba_objects o where sid like '%&waiting_sid%' and s.ROW_WAIT_OBJ# = o.OBJECT_ID 
and o.owner like upper('%&owner%')
and o.object_name like upper('%&object_name%')
order by SECONDS_IN_WAIT;