-- ------------------------------------------------------------------------------
-- File       : select_query_exp_columns.sql
-- Purpose    : Oracle administration helper: select query exp columns.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @select_query_exp_columns.sql
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
select 'QUERY='||owner||'.'||TABLE_NAME||':"WHERE TRUNC('||column_name||') BETWEEN TRUNC(TO_DATE(''01/12/2010'',''DD/MM/YYYY'')) AND TRUNC(TO_DATE(''31/05/2011'',''DD/MM/YYYY''))"' QUERY
from dba_Tab_columns where owner='TNLRUY' and column_name in ('BOOK_DATE')
UNION ALL
select 'QUERY='||owner||'.'||TABLE_NAME||':"WHERE TRUNC('||column_name||') BETWEEN TRUNC(TO_DATE(''01/12/2010'',''DD/MM/YYYY'')) AND TRUNC(TO_DATE(''31/05/2011'',''DD/MM/YYYY''))"' QUERY
from dba_Tab_columns a where owner='TNLRUY' and column_name in ('FECHA_DATA',
'FECHA_TRAN',
'INSERT_TIME',
'LAST_PROCESSING_DATE',
'MONTH_DAY',
'VIGENCIA_DESDE',
'BAL_DATE',
'MIS_DATE',
'TXN_DATE',
'UPLOAD_DATE') AND not exists (select 1 from dba_tab_columns b where a.table_name=b.table_name and b.owner=a.owner and b.column_name='BOOK_DATE');


select 'QUERY='||owner||'.'||TABLE_NAME||':"WHERE 1=2"' QUERY
from dba_tables a where owner='&OWNER' and table_name like 'MLOG$%' and not exists (select 1 from dba_Tab_columns b where b.owner=a.owner
and b.table_name = a.table_name and column_name in ('FECHA_DATA',
'FECHA_TRAN',
'INSERT_TIME',
'LAST_PROCESSING_DATE',
'MONTH_DAY',
'VIGENCIA_DESDE',
'BAL_DATE',
'MIS_DATE',
'TXN_DATE',
'UPLOAD_DATE','BOOK_DATE'));




URYRR_EST_DEP_HIS:"WHERE TRUNC(BOOK_DATE) >=ADD_MONTHS(trunc(sysdate,'MONTH'),-6)"