REM ------------------------------------------------------------------------------
REM File       : script_ejec_rman.cmd
REM Purpose    : Oracle RMAN backup, restore or recovery helper: script ejec rman.
REM Category   : backup_recovery/rman
REM Author     : Diego Cabrera
REM Created    : Unknown
REM Version    : 1.0
REM Usage      : script_ejec_rman.cmd
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

set nombre_base=

set dir_logs=

set dir_backup=

set fecha=%date:~3,2%%date:~0,2%%date:~8,2%

set ORACLE_SID=%NOMBRE_BASE%

rman log=%dir_logs%/log_rman_%fecha%_full_%nombre_base%.log <<EOF
connect target / 
run {
     # Comienzo del Backup ..."';
     backup database format '%dir_backup%\%oracle_sid%/full/%u_%d_%s_%t_%fecha%_full.rman';}
run {
     # Validando los logs archivados ...
     change archivelog all validate;
     crosscheck backup;
     # Elimino backups expirados / obsoletos
     delete noprompt expired backup;
     report obsolete;
     delete noprompt obsolete;
     sql 'alter system archive log current';
     delete noprompt archivelog until time 'sysdate-3';
     # Archivos que necesitan Backup:
     report need backup;
    }
EOF