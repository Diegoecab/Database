REM ------------------------------------------------------------------------------
REM File       : Copiar_Datafiles.bat
REM Purpose    : Oracle RMAN backup, restore or recovery helper: Copiar Datafiles.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : Copiar_Datafiles.bat
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
xcopy /Y \\192.168.200.5\g$\CMCopy\DADOS* c:\cm\DADOS\ >>c:\cm\scripts\logs\copia_datafiles.log
xcopy /Y \\192.168.200.5\g$\CMCopy\INDX* c:\cm\INDICES\ >>c:\cm\scripts\logs\copia_datafiles.log
xcopy /Y \\192.168.200.5\g$\CMCopy\STATSP* C:\cm\SYSAUX\ >>c:\cm\scripts\logs\copia_datafiles.log
xcopy /Y \\192.168.200.5\g$\CMCopy\SYSAUX* C:\cm\SYSAUX\ >>c:\cm\scripts\logs\copia_datafiles.log
xcopy /Y \\192.168.200.5\g$\CMCopy\SYSTEM01* C:\cm\SYSTEM\ >>c:\cm\scripts\logs\copia_datafiles.log
xcopy /Y \\192.168.200.5\g$\CMCopy\UNDO* C:\cm\UNDO\ >>c:\cm\scripts\logs\copia_datafiles.log
xcopy /Y \\192.168.200.5\g$\CMCopy\CONTROL01* C:\cm\CONTROLES\ >>c:\cm\scripts\logs\copia_datafiles.log