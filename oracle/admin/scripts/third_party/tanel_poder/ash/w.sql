-- ------------------------------------------------------------------------------
-- File       : w.sql
-- Purpose    : oracle/admin third_party helper: w.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: w.sql
-- Parameters : filter
-- Risk       : REVIEW
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

DEF filter=&1

PROMPT What's going on? Showing top timed events of last minute from ASH...
@ashtop session_state,event &filter sysdate-1/24/60 sysdate

PROMPT Showing top SQL and wait classes of last minute from ASH...
@ashtop sql_id,session_state,wait_class &filter sysdate-1/24/60 sysdate

