REM ------------------------------------------------------------------------------
REM File       : SwitchOverSTB.bat
REM Purpose    : Oracle RMAN backup, restore or recovery helper: SwitchOverSTB.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : SwitchOverSTB.bat
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
title SwitchOver
set ORACLE_SID=CM
echo Inciando SwitchOver...
set acep=
set /p acep=Desea iniciar SwitchOver? [S/N] N:
if not defined acep exit
echo Copiando archives...
call C:\CM\Scripts\Copiar_Archives.bat
echo Recover StandBy...
call C:\CM\Scripts\ExecRecover.bat
echo spool c:\cm\scripts\logs\switchOver.log >>c:\cm\scripts\switchOver.sql
echo shutdown immediate >>c:\cm\scripts\switchOver.sql
echo host del c:\cm\controles\CONTROL01.CTL >>c:\cm\scripts\switchOver.sql
echo host del c:\cm\controles\REDO01.LOG >>c:\cm\scripts\switchOver.sql
echo host del c:\cm\controles\REDO02.LOG >>c:\cm\scripts\switchOver.sql
echo host del c:\cm\controles\REDO03.LOG >>c:\cm\scripts\switchOver.sql
echo host del c:\cm\controles\REDO04.LOG >>c:\cm\scripts\switchOver.sql
echo host del c:\cm\controles\REDO05.LOG >>c:\cm\scripts\switchOver.sql
echo @C:\CM\Scripts\CONTROLFSTB.CTL  >>c:\cm\scripts\switchOver.sql
echo spool off  >>c:\cm\scripts\switchOver.sql
echo quit  >>c:\cm\scripts\switchOver.sql
sqlplus / as sysdba @c:\cm\scripts\switchOver.sql
del c:\cm\scripts\switchOver.sql
echo SwitchOver ejecutado. Logs : c:\cm\scripts\logs\switchOver.log
pause