-- ------------------------------------------------------------------------------
-- File       : create_profile.sql
-- Purpose    : Oracle SQL performance and tuning helper: create profile.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_profile.sql
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

create user testprofile identified by testprofile1;


   CREATE PROFILE TESTPROFILE_PROFILE LIMIT PASSWORD_REUSE_TIME 10 PASSWORD_REUSE_MAX 10;
		 
	CREATE user testprofile identified by testprofile1 profile TESTPROFILE_PROFILE;
	
	ALTER user testprofile identified by testprofile1;
	
	CREATE PROFILE TESTPROFILE_PROFILE_UNLIMITED     LIMIT          PASSWORD_REUSE_TIME UNLIMITED         PASSWORD_REUSE_MAX UNLIMITED; 
	
	ALTER user testprofile profile TESTPROFILE_PROFILE_UNLIMITED;
	
	ALTER user testprofile identified by testprofile1;
	
	ALTER user testprofile profile TESTPROFILE_PROFILE;
	


ALTER user testprofile identified by testprofile1;

ALTER user testprofile profile TESTPROFILE_PROFILE;


SQL> ALTER user testprofile identified by testprofile1;

User altered.

SQL> ALTER user testprofile identified by testprofile1;
ALTER user testprofile identified by testprofile1
*
ERROR at line 1:
ORA-28007: the password cannot be reused


SQL>



ALTER user testprofile profile DEFAULT;

SQL> ALTER user testprofile identified by testprofile1;

User altered.

