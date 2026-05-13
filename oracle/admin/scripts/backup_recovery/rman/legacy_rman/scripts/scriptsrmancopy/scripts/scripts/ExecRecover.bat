REM ------------------------------------------------------------------------------
REM File       : ExecRecover.bat
REM Purpose    : Oracle RMAN backup, restore or recovery helper: ExecRecover.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : ExecRecover.bat
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

set ORACLE_SID=cm

sqlplus / as sysdba @C:\CM\Scripts\cRecoverStb.sql