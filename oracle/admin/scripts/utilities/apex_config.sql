-- ------------------------------------------------------------------------------
-- File       : apex_config.sql
-- Purpose    : Oracle administration helper: apex config.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @apex_config.sql
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
SET SERVEROUTPUT ON
begin 
    apex_instance_admin.set_parameter(
        p_parameter => 'IMAGE_PREFIX',
        p_value     => 'https://static.oracle.com/cdn/apex/23.1.1/' );

    commit;
end;

begin 
    apex_instance_admin.get_parameter(
		p_parameters      
        p_NAME => 'IMAGE_PREFIX');
end;


	select * from apex_instance_parameters where name = 'IMAGE_PREFIX';

	NAME                           VALUE                                              CREATED_O LAST_UPDA
	------------------------------ -------------------------------------------------- --------- ---------
	IMAGE_PREFIX                   /i/                                                08-DEC-23 08-DEC-23

	SQL>


	SET SERVEROUTPUT ON
	begin 
		apex_instance_admin.set_parameter(
			p_parameter => 'IMAGE_PREFIX',
			p_value     => 'https://static.oracle.com/cdn/apex/23.1.1/' );

		commit;
	end;
	/
	
	
	SQL> select * from apex_instance_parameters where name = 'IMAGE_PREFIX';

	NAME                           VALUE                                              CREATED_O LAST_UPDA
	------------------------------ -------------------------------------------------- --------- ---------
	IMAGE_PREFIX                   https://static.oracle.com/cdn/apex/23.1.1/         08-DEC-23 12-DEC-23

	SQL>






select workspace from APEX_230100.apex_workspaces;
select user_name from APEX_230100.wwv_flow_fnd_user;




SET SERVEROUTPUT ON
begin 
    apex_instance_admin.set_parameter(
        p_parameter => 'IMAGE_PREFIX',
        p_value     => '/i/' );

    commit;
end;



