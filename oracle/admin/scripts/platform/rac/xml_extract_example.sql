-- ------------------------------------------------------------------------------
-- File       : xml_extract_example.sql
-- Purpose    : Oracle RAC or cluster administration helper: xml extract example.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @xml_extract_example.sql
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
 select * from xmltable('VaPolicies/VaPolicy' passing xmltype(bfilename('EXP_MQ38255','citi-ora-udr-dsm6-v32037.xml'), nls_charset_id('AL32UTF8'))
	columns
policy_name varchar(2000) path 'name',
keywords varchar(2000) path 'keywords',
state varchar(2000) path 'state',
obsolete varchar(2000) path 'obsolete',
classification varchar(2000) path 'classification',
severity varchar(2000) path 'severity',
category varchar(2000) path 'category',
db_type varchar(2000) path 'db_type',
exec_type varchar(2000) path 'exec_type',
serverLevel varchar(2000) path 'serverlevel',
maxcollectedresults varchar(2000) path 'maxCollectedResults',
description varchar(2000) path 'description',
impactedVersions varchar(2000) path 'impactedVersions',
otherReferences varchar(2000) path 'otherReferences',
overview varchar(2000) path 'overview',
policyReference varchar(2000) path 'policyReference',
remediationAdvice varchar(2000) path 'remediationAdvice',
resultColumnLabels varchar(2000) path 'resultColumnLabels',
resultColumnNames varchar(2000) path 'resultColumnNames',
osType varchar(2000) path 'cmd/osType',
source varchar(2000) path 'cmd/source'
)
/

Los ‘path’ son los tag xml
El bfilename es el directorio y el file,
Y el primer argumento serian los tag de raíz del xml.
