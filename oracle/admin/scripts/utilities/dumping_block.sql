-- ------------------------------------------------------------------------------
-- File       : dumping_block.sql
-- Purpose    : Oracle administration helper: dumping block.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dumping_block.sql
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
126541


SELECT SEGMENT_NAME, SEGMENT_TYPE, RELATIVE_FNO FROM DBA_EXTENTS WHERE FILE_ID = 1 AND BLOCK_ID BETWEEN BLOCK_ID AND BLOCK_ID + BLOCKS - 1 /


select
   p1 "File #",
   p2 "Block #",
   p3 "Reason Code"
from
   v$session_wait
where
   event = 'buffer busy waits';


alter system dump datafile 1 block 126553;


select name from obj$ where obj# = 5927;
