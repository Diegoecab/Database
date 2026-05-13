-- ------------------------------------------------------------------------------
-- File       : set_configuration.sql
-- Purpose    : AWS/RDS/DMS Oracle administration helper: set configuration.
-- Category   : cloud/aws
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @set_configuration.sql
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
begin
	   rdsadmin.rdsadmin_util.set_configuration(
		   name=> 'archivelog retention hours',
		   value=> '48');
end;
/
     
exec rdsadmin.rdsadmin_util.show_configuration ;

