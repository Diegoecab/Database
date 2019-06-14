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