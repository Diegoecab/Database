-- ------------------------------------------------------------------------------
-- File       : sess.sql
-- Purpose    : Oracle diagnostic query/report helper: sess.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sess.sql
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
-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2004 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : sess_user_sessions.sql                                          |
-- | CLASS    : Session Management                                              |
-- | PURPOSE  : Report on all User Sessions.                                    |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

ttitle ' '
SET LINESIZE 145
SET PAGESIZE 9999

COLUMN max_sess_allowed  FORMAT 999,999       JUSTIFY r HEADING 'Max sessions allowed'
COLUMN num_sessions      FORMAT 999,999,999   JUSTIFY r HEADING 'Number of sessions'
COLUMN pct_utl           FORMAT a19           JUSTIFY r HEADING 'Percent Utilization'
COLUMN username          FORMAT a30           JUSTIFY r HEADING 'Oracle User'
COLUMN num_user_sess     FORMAT 999,999       JUSTIFY r HEADING 'Number of Logins'
COLUMN count_a           FORMAT 999,999       JUSTIFY r HEADING 'Active Logins'
COLUMN count_i           FORMAT 999,999       JUSTIFY r HEADING 'Inactive Logins'

SET verify off

select * 
from 
(SELECT
    TO_NUMBER(a.value)         max_sess_allowed
  , TO_NUMBER(count(*))        num_sessions
  , LPAD(ROUND((count(*)/a.value)*100,0) || '%', 19)  pct_utl
FROM 
    v$session    b
  , v$parameter  a
WHERE 
    a.name = 'sessions'
GROUP BY 
    a.value) sess,
(SELECT
    TO_NUMBER(a.value)         max_procs_allowed
  , TO_NUMBER(count(*))        num_processes
  , LPAD(ROUND((count(*)/a.value)*100,0) || '%', 19)  pct_utl
FROM 
    v$session    b
  , v$parameter  a
WHERE 
    a.name = 'processes'
GROUP BY 
    a.value) procs
/

prompt Nota: #sess = #procs * 1.1 + 5

