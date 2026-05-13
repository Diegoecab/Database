-- ------------------------------------------------------------------------------
-- File       : custom.sql
-- Purpose    : Oracle administration helper: custom.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @custom.sql
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
select owner, object_type, count(*)
from dba_objects where object_name like 'XX_%'
group by owner, object_type
order by owner, object_type
/

PROMPT
PROMPT OBJETOS QUE DEBERIAN ESTAR EN BOLINF
PROMPT

select owner, object_type, object_name, CREATED, LAST_DDL_TIME
from dba_objects
where object_name like 'XX_%'
and owner <> 'BOLINF'
AND OBJECT_TYPE NOT IN ('SYNONYM','PACKAGE','PACKAGE BODY','VIEW','FUNCTION','PROCEDURE','TRIGGER')
UNION ALL
select owner, object_type, object_name, CREATED, LAST_DDL_TIME
from dba_objects
where object_name like 'XX_%'
and owner <> 'BOLINF'
AND OBJECT_TYPE = 'TRIGGER'
AND EXISTS (SELECT 1 FROM DBA_TRIGGERS WHERE TRIGGER_NAME=OBJECT_NAME AND TABLE_OWNER ='BOLINF')
/


select owner, TABLE_NAME, TABLESPACE_NAME
from dba_TABLES
where TABLE_NAME like 'XX_%'
and owner <> 'BOLINF'
/

select owner, INDEX_NAME, TABLESPACE_NAME
from dba_INDEXES
where INDEX_NAME like 'XX_%'
and owner <> 'BOLINF'
/


PROMPT
PROMPT OBJETOS QUE DEBERIAN ESTAR EN APPS O APPLSYS
PROMPT

select owner, object_type, object_name, CREATED, LAST_DDL_TIME
from dba_objects
where object_name like 'XX_%'
and owner = 'BOLINF'
AND OBJECT_TYPE IN ('SYNONYM','PACKAGE','PACKAGE BODY','VIEW','FUNCTION','PROCEDURE')
UNION ALL
select owner, object_type, object_name, CREATED, LAST_DDL_TIME
from dba_objects
where object_name like 'XX_%'
and owner = 'BOLINF'
AND OBJECT_TYPE = 'TRIGGER'
AND NOT EXISTS (SELECT 1 FROM DBA_TRIGGERS WHERE TRIGGER_NAME=OBJECT_NAME AND TABLE_OWNER ='BOLINF')
/

PROMPT
prompt NOTAS:
PROMPT
PROMPT La tabla XX_AD_APPLIED_PATCHES es una excepción (confirmado por Hector el 21/01/2008)
PROMPT La tabla XX_BKP_AP_CHECKS_ALL_20071101 parece ser un backup tomado excepcionalmente (confirmado por Hector)
PROMPT






