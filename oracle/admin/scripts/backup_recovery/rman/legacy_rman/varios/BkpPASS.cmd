REM ------------------------------------------------------------------------------
REM File       : BkpPASS.cmd
REM Purpose    : Oracle RMAN backup, restore or recovery helper: BkpPASS.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : BkpPASS.cmd
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
COPY C:\oracle\ora92\database\PWDdtest.ora /Y C:\oracle\disco3\varios\PWDdtest.ora
COPY C:\oracle\ora92\database\INITdtest.ora /Y C:\oracle\disco3\varios\INITdtest.ora
COPY C:\oracle\ora92\database\SPFILEdtest.ora /Y C:\oracle\disco3\varios\SPFILEdtest.ora