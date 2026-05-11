-- ------------------------------------------------------------------------------
-- File       : dba_undo_extents.sql
-- Purpose    : Oracle administration helper: dba undo extents.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_undo_extents.sql
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
--dba_undo_extents

col pct_inuse heading 'Porc|Uso' for 999

set feedback off

PROMPT
PROMPT DOC> Estado de extents en tablespace UNDO
PROMPT

SELECT STATUS, ROUND(SUM(BYTES)/1024/1024) Mb, COUNT(*) FROM DBA_UNDO_EXTENTS GROUP BY STATUS;

PROMPT
PROMPT DOC> Porcentaje de uso del tablespace de UNDO
PROMPT 

select round(
((select (nvl(sum(bytes),0))
from dba_undo_extents
where upper(tablespace_name)= upper((select value from v$parameter where name ='undo_tablespace'))
and status in ('ACTIVE','UNEXPIRED')) *100) /
(select sum(bytes)
from dba_data_files
where upper(tablespace_name)=upper((select value from v$parameter where name ='undo_tablespace'))))
"PCT_INUSE"
from dual; 

PROMPT
PROMPT DOC> Porcentaje de uso del tablespace de UNDO (considerando autoextend)
PROMPT

select round(
((select (nvl(sum(bytes),0))
from dba_undo_extents
where upper(tablespace_name)= upper((select value from v$parameter where name ='undo_tablespace'))
and status in ('ACTIVE','UNEXPIRED')) *100) /
(select sum(maxbytes)
from dba_data_files
where upper(tablespace_name)=upper((select value from v$parameter where name ='undo_tablespace'))))
"PCT_INUSE"
from dual; 

PROMPT

set feedback on