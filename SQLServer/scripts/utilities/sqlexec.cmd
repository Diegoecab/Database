REM ------------------------------------------------------------------------------
REM File       : sqlexec.cmd
REM Purpose    : SQLServer utilities helper: sqlexec.
REM Engine     : SQLServer
REM Category   : utilities
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : sqlexec.cmd
REM Parameters : Review script body before running.
REM Risk       : REVIEW
REM Output     : Client, shell or script-defined output.
REM Notes      : Validate in a non-production environment before operational use.
REM Source     : internal
REM Change Log :
REM 2026-05-11 : Diego Cabrera - Header normalization.
REM ------------------------------------------------------------------------------
REM
echo @off
set connstring=%1
set script=%3
set user=%2
sqlcmd -U %user% -S %connstring% -i %script%