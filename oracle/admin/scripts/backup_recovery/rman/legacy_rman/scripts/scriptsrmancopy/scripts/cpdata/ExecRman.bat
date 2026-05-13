REM ------------------------------------------------------------------------------
REM File       : ExecRman.bat
REM Purpose    : Oracle RMAN backup, restore or recovery helper: ExecRman.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : ExecRman.bat
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
@rem Seteos de variables 

set nombre_base=CM

set dir_logs=C:\BackupCM\RMAN\CPData\logs

set ORACLE_SID=%NOMBRE_BASE%

rman target / log=%dir_logs%\log_rman_copy_%nombre_base%.log @C:\BackupCM\RMAN\CPData\CopyDatRMAN.rman

@ExecControlF.bat