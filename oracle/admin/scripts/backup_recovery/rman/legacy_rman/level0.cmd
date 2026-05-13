REM ------------------------------------------------------------------------------
REM File       : level0.cmd
REM Purpose    : Oracle RMAN backup, restore or recovery helper: level0.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : level0.cmd
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
run {allocate channel c1 type disk format = 'c:\diego\oracle\rman\standb\%u.bkp';
allocate channel c2 type disk format = 'c:\diego\oracle\rman\standb\%u.bkp';
allocate channel c3 type disk format = 'c:\diego\oracle\rman\standb\%u.bkp';
sql 'alter system switch logfile';
backup incremental level = 0 database plus archivelog delete input;}
