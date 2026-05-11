-- ------------------------------------------------------------------------------
-- File       : portal_docs.sql
-- Purpose    : Oracle administration helper: portal docs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @portal_docs.sql
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
--NAME,
--FILENAME,
--DOC_SIZE,
--LAST_UPDATED,
trunc(LAST_UPDATED),
sum(doc_size),
MIME_TYPE,
CONTENT_TYPE,
CREATOR,
IS_USED,
IS_MARKED_FOR_DELETE
from portal.WWDOC_DOCUMENT$
where last_updated > sysdate -30
group by MIME_TYPE,trunc(last_updated),CONTENT_TYPE,
CREATOR,
IS_USED,
IS_MARKED_FOR_DELETE
order by 1,2,3,4,5.6
/
