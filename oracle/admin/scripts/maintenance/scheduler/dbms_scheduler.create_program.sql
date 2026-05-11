-- ------------------------------------------------------------------------------
-- File       : dbms_scheduler.create_program.sql
-- Purpose    : Oracle database maintenance helper: dbms scheduler create program.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_scheduler.create_program.sql
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
--dbms_scheduler.create_program.sql


prompt program_name:	"DBADMIN"."PRG_STATISTICS"
prompt program_type:	plsql_block / stored_procedure
prompt program_action:	"STAT_GATHER_PKG"."GATHER_STATISTICS"



begin
dbms_scheduler.create_program (
   program_name          => '&program_name',
   program_type          => '&program_type',
   program_action        => '&program_action',
   number_of_arguments   => 0,
   enabled               => &enabled,
   comments              => '&comments');
end;
/

commit;