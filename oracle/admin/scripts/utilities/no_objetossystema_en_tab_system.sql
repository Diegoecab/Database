-- ------------------------------------------------------------------------------
-- File       : no_objetossystema_en_tab_system.sql
-- Purpose    : Oracle administration helper: no objetossystema en tab system.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @no_objetossystema_en_tab_system.sql
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
SELECT owner, segment_name, partition_name,
       segment_type, ROUND(bytes / 1048576, 2) size_in_mb
FROM   dba_segments
WHERE  owner NOT IN ('SYS', 'SYSTEM')
AND    tablespace_name = 'SYSTEM'
ORDER BY owner, segment_type, segment_name;