-- ------------------------------------------------------------------------------
-- File       : apex_logs.sql
-- Purpose    : Oracle administration helper: apex logs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @apex_logs.sql
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
select
apex_debug_messages.APEX_USER,
apex_debug_messages.APPLICATION_ID,
APEX_WORKSPACE_ACTIVITY_LOG.APPLICATION_NAME,
apex_debug_messages.PAGE_ID,
apex_debug_messages.MESSAGE,
apex_debug_messages.MESSAGE_TIMESTAMP,
apex_debug_messages.PAGE_VIEW_ID,
apex_debug_messages.SESSION_ID
from APEX_WORKSPACE_ACTIVITY_LOG
inner join apex_debug_messages on APEX_WORKSPACE_ACTIVITY_LOG.DEBUG_PAGE_VIEW_ID = apex_debug_messages.PAGE_VIEW_ID
and apex_debug_messages.MESSAGE_TIMESTAMP > trunc(sysdate);