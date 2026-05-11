REM ------------------------------------------------------------------------------
REM File       : sqlquery.cmd
REM Purpose    : SQLServer diagnostics/sessions helper: sqlquery.
REM Engine     : SQLServer
REM Category   : diagnostics/sessions
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : sqlquery.cmd
REM Parameters : Review script body before running.
REM Risk       : REVIEW
REM Output     : Client, shell or script-defined output.
REM Notes      : Validate in a non-production environment before operational use.
REM Source     : internal
REM Change Log :
REM 2026-05-11 : Diego Cabrera - Header normalization.
REM ------------------------------------------------------------------------------
REM
@echo off
set connstring=%1
set query=%3
set user=%2
sqlcmd -U %user% -S %connstring% -q %query%