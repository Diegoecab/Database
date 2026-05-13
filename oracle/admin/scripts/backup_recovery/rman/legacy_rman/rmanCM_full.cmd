REM ------------------------------------------------------------------------------
REM File       : rmanCM_full.cmd
REM Purpose    : Oracle RMAN backup, restore or recovery helper: rmanCM full.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : rmanCM_full.cmd
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

set nombre_base=DBA

set dir_logs=D:\oracle\DBA\RMAN\Logs

set dir_backup=D:\oracle\DBA\RMAN

set ORACLE_SID=%NOMBRE_BASE%

rman target / catalog rman/catalog@catalog log=%dir_logs%\log_rman_full_%nombre_base%.log @D:\ORACLE\DBA\Scripts\FullCM.rman