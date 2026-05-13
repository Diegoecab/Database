REM ------------------------------------------------------------------------------
REM File       : dba.bat
REM Purpose    : Oracle RMAN backup, restore or recovery helper: dba.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : dba.bat
REM Parameters : Review script arguments and environment variables before running.
REM Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
REM Oracle Ver.: Review compatibility before production use.
REM Risk       : REVIEW
REM Output     : Shell/command output and any script-defined log files.
REM Notes      : Validate in a non-production session before operational use.
REM Source     : internal
REM Change Log : 
REM 2026-05-11 : Diego Cabrera - Header normalization.
REM ------------------------------------------------------------------------------
REM
mkdir C:\oracle\database\10g\admin\dba\adump
mkdir C:\oracle\database\10g\admin\dba\bdump
mkdir C:\oracle\database\10g\admin\dba\cdump
mkdir C:\oracle\database\10g\admin\dba\dpdump
mkdir C:\oracle\database\10g\admin\dba\pfile
mkdir C:\oracle\database\10g\admin\dba\udump
mkdir C:\oracle\database\10g\dba\cfgtoollogs\dbca\dba
mkdir C:\oracle\database\10g\dba\dbs
mkdir D:\oracle\DBA\DataFiles\dba
mkdir D:\oracle\DBA\flash_recovery_area
set ORACLE_SID=dba
C:\oracle\database\10g\dba\bin\oradim.exe -new -sid DBA -startmode manual -spfile 
C:\oracle\database\10g\dba\bin\oradim.exe -edit -sid DBA -startmode auto -srvcstart system 
C:\oracle\database\10g\dba\bin\sqlplus /nolog @D:\oracle\DBA\Scripts\dba.sql
