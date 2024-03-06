
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

