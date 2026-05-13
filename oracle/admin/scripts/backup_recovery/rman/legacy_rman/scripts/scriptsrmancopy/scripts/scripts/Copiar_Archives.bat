REM ------------------------------------------------------------------------------
REM File       : Copiar_Archives.bat
REM Purpose    : Oracle RMAN backup, restore or recovery helper: Copiar Archives.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : Copiar_Archives.bat
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
xcopy /D \\192.168.200.5\g$\cm\ARCHIVES\* c:\cm\ARCHIVES\ >>c:\cm\scripts\logs\copia_archives.log