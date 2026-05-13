REM ------------------------------------------------------------------------------
REM File       : restoreFull.cmd
REM Purpose    : Oracle RMAN backup, restore or recovery helper: restoreFull.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : restoreFull.cmd
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
run {allocate channel c1 type disk;
allocate channel c2 type disk;
allocate channel c3 type disk;
restore database;
recover database;
sql 'alter database open';}