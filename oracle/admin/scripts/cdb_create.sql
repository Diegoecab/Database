CREATE DATABASE cdb
	/*LOGFILE GROUP 1 ('/u01/app/oracle/oradata/kdb121/redo01a.rdo',
			'/u02/app/oracle/oradata/kdb121/redo01b.rdo',
			'/u03/app/oracle/oradata/kdb121/redo01c.rdo') SIZE 100M,
	GROUP 2 ('/u01/app/oracle/oradata/kdb121/redo02a.rdo',
		'/u02/app/oracle/oradata/kdb121/redo02b.rdo',
		'/u03/app/oracle/oradata/kdb121/redo02c.rdo') SIZE 100M,
	GROUP 3 ('/u01/app/oracle/oradata/kdb121/redo03a.rdo',
		'/u02/app/oracle/oradata/kdb121/redo03b.rdo',
		'/u03/app/oracle/oradata/kdb121/redo03c.rdo') SIZE 100M*/
        CHARACTER SET AL32UTF8
        NATIONAL CHARACTER SET AL16UTF16
        EXTENT MANAGEMENT LOCAL
        /*DATAFILE '/u02/app/oracle/oradata/kdb121/system01.dbf'
	SIZE 700M AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED
        SYSAUX DATAFILE '/u02/app/oracle/oradata/kdb121/sysaux01.dbf'
	SIZE 500M AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED
        DEFAULT TEMPORARY TABLESPACE temp TEMPFILE '/u02/app/oracle/oradata/kdb121/temp01.dbf'
	SIZE 100M AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED
        UNDO TABLESPACE undo DATAFILE '/u02/app/oracle/oradata/kdb121/undo01.dbf'
	SIZE 100M AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED*/
        ENABLE PLUGGABLE DATABASE
        SEED
    /*    FILE_NAME_CONVERT = ('/u02/app/oracle/oradata/kdb121/', '/u02/app/oracle/oradata/pdbseed/')*/
        SYSTEM DATAFILES SIZE 125M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
        SYSAUX DATAFILES SIZE 100M
        USER_DATA TABLESPACE users --DATAFILE '/u02/app/oracle/oradata/pdbseed/users01.dbf'
	SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;