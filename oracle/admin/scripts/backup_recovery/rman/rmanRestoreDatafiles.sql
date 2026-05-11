-- ------------------------------------------------------------------------------
-- File       : rmanRestoreDatafiles.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: rmanRestoreDatafiles.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rmanRestoreDatafiles.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
set echo off;
set serveroutput on;
select TO_CHAR(systimestamp,'YYYYMMDD HH:MI:SS') from dual;
variable devicename varchar2(255);
declare
omfname varchar2(512) := NULL;
  done boolean;
  begin
    dbms_output.put_line(' ');
    dbms_output.put_line(' Allocating device.... ');
    dbms_output.put_line(' Specifying datafiles... ');
       :devicename := dbms_backup_restore.deviceAllocate;
    dbms_output.put_line(' Specifing datafiles... ');
    dbms_backup_restore.restoreSetDataFile;
      dbms_backup_restore.restoreDataFileTo(1, '/u01/app/oracle/oradata/db01/system01.dbf', 0, 'SYSTEM');
      dbms_backup_restore.restoreDataFileTo(2, '/u01/app/oracle/oradata/db01/undotbs01.dbf', 0, 'UNDOTBS1');
      dbms_backup_restore.restoreDataFileTo(3, '/u01/app/oracle/oradata/db01/sysaux01.dbf', 0, 'SYSAUX');
      dbms_backup_restore.restoreDataFileTo(4, '/u01/app/oracle/oradata/db01/users01.dbf', 0, 'USERS');
    dbms_output.put_line(' Restoring ... ');
    dbms_backup_restore.restoreBackupPiece('/u01/app/oracle/product/10.2.0/assistants/dbca/templates/Seed_Database.dfb', done);
    if done then
        dbms_output.put_line(' Restore done.');
    else
        dbms_output.put_line(' ORA-XXXX: Restore failed ');
    end if;
    dbms_backup_restore.deviceDeallocate;
  end;
/
select TO_CHAR(systimestamp,'YYYYMMDD HH:MI:SS') from dual;
