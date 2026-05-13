-- ------------------------------------------------------------------------------
-- File       : create_mview.sql
-- Purpose    : Oracle administration helper: create mview.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_mview.sql
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
SELECT 'PROMPT SNAPSHOT '||LOG_OWNER||'.'||MASTER||'...
CREATE MATERIALIZED VIEW LOG ON '||LOG_OWNER||'.'||MASTER||'
TABLESPACE GEMLOGS
NOLOGGING
WITH ROWID, PRIMARY KEY
INCLUDING NEW VALUES;' FROM DBA_SNAPSHOT_LOGS WHERE PRIMARY_KEY='YES' AND ROWIDS='YES' AND INCLUDE_NEW_VALUES='YES'
UNION
SELECT 'PROMPT SNAPSHOT '||LOG_OWNER||'.'||MASTER||'... 
CREATE MATERIALIZED VIEW LOG ON '||LOG_OWNER||'.'||MASTER||'
TABLESPACE GEMLOGS
NOLOGGING
WITH ROWID
INCLUDING NEW VALUES;' FROM DBA_SNAPSHOT_LOGS WHERE PRIMARY_KEY='NO' AND ROWIDS='YES' AND INCLUDE_NEW_VALUES='YES'
UNION
SELECT 'PROMPT SNAPSHOT '||LOG_OWNER||'.'||MASTER||'... 
CREATE MATERIALIZED VIEW LOG ON '||LOG_OWNER||'.'||MASTER||'
TABLESPACE GEMLOGS
NOLOGGING
WITH PRIMARY KEY
INCLUDING NEW VALUES;' FROM DBA_SNAPSHOT_LOGS WHERE PRIMARY_KEY='YES' AND ROWIDS='NO' AND INCLUDE_NEW_VALUES='YES';