-- ------------------------------------------------------------------------------
-- File       : rg_sqlprof3.sql
-- Purpose    : Oracle administration helper: rg sqlprof3.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rg_sqlprof3.sql
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
/* Randolf Giest */
-- creates a sql profile from shared pool
-- sql_id_from child_no_from sql_id_to child_no_to category force_matching
declare
ar_profile_hints sys.sqlprof_attr;
cl_sql_text clob;
begin
select
extractvalue(value(d), '/hint') as outline_hints
bulk collect
into
ar_profile_hints
from
xmltable('/*/outline_data/hint'
passing (
select
xmltype(other_xml) as xmlval
from
gv$sql_plan
where
sql_id = '&&1'
and child_number = &&2
and other_xml is not null
)
) d;

select
sql_fulltext
into
cl_sql_text
from
gv$sql
where
sql_id = '&&3'
and child_number = &&4;

dbms_sqltune.import_sql_profile(
sql_text => cl_sql_text
, profile => ar_profile_hints
, category => '&&5'
, name => 'PROFILE_'||'&&3'||'_attach'
-- use force_match => true
-- to use CURSOR_SHARING=SIMILAR
-- behaviour, i.e. match even with
-- differing literals
, force_match => &&6
);
end;
/

