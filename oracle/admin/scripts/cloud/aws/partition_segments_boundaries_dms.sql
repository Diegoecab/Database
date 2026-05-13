-- ------------------------------------------------------------------------------
-- File       : partition_segments_boundaries_dms.sql
-- Purpose    : AWS/RDS/DMS Oracle administration helper: partition segments boundaries dms.
-- Category   : cloud/aws
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @partition_segments_boundaries_dms.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--Scripts which can be used to fetch the ranges/buckets for the boundaries from the source table:
SELECT nt, Max(<column_name>), Count(*) 
FROM (SELECT <column_name>, Ntile(4) over( ORDER BY <column_name>) nt FROM <table_name>) 
GROUP BY nt 
ORDER BY nt;
