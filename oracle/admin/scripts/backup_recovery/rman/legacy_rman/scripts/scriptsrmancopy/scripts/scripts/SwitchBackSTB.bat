REM ------------------------------------------------------------------------------
REM File       : SwitchBackSTB.bat
REM Purpose    : Oracle RMAN backup, restore or recovery helper: SwitchBackSTB.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : SwitchBackSTB.bat
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
@echo off
title SwitchBack
set ORACLE_SID=CM
echo Inciando SwitchBack...
set acep=
set /p acep=Desea iniciar SwitchBack? [S/N] N:
if not defined acep exit
echo shutdown Abort..
echo shutdown abort >>c:\cm\scripts\switchBack.sql
echo quit >>c:\cm\scripts\switchBack.sql
sqlplus / as sysdba @c:\cm\scripts\switchBack.sql
del c:\cm\scripts\switchBack.sql
echo Copiando archives...
call C:\CM\Scripts\Copiar_Archives.bat
echo Copy DataFiles...
call C:\CM\Scripts\Copiar_Datafiles.bat
echo spool c:\cm\scripts\logs\switchBack.log >>c:\cm\scripts\switchBack.sql
echo startup nomount pfile='c:\cm\scripts\initcm.ora' >>c:\cm\scripts\switchBack.sql
echo alter database mount standby database;  >>c:\cm\scripts\switchBack.sql
echo spool off  >>c:\cm\scripts\switchBack.sql
echo quit  >>c:\cm\scripts\switchBack.sql
sqlplus / as sysdba @c:\cm\scripts\switchBack.sql
del c:\cm\scripts\switchBack.sql
echo Recover StandBy...
call c:\cm\scripts\ExecRecover.bat
echo create spfile from pfile; >>c:\cm\scripts\switchBack.sql
echo quit >>c:\cm\scripts\switchBack.sql
sqlplus / as sysdba @c:\cm\scripts\switchBack.sql
del c:\cm\scripts\switchBack.sql
echo SwitchBack ejecutado. Logs : c:\cm\scripts\logs\switchBack.log
pause