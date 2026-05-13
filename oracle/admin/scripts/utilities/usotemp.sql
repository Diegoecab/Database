-- ------------------------------------------------------------------------------
-- File       : usotemp.sql
-- Purpose    : oracle/admin utilities helper: usotemp.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: usotemp.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
prompt 
prompt Uso Gral
prompt 

SELECT tablespace_name, extent_size, total_extents, used_extents,
free_extents, max_used_size
FROM v$sort_segment
/

prompt 
prompt Uso x Session
prompt

SELECT s.username, u.tablespace, u.contents, u.extents, u.blocks
FROM v$session s, v$sort_usage u
WHERE s.saddr=u.session_addr
/
