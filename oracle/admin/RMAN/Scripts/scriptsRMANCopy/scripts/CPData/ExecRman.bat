@rem Seteos de variables 

set nombre_base=CM

set dir_logs=C:\BackupCM\RMAN\CPData\logs

set ORACLE_SID=%NOMBRE_BASE%

rman target / log=%dir_logs%\log_rman_copy_%nombre_base%.log @C:\BackupCM\RMAN\CPData\CopyDatRMAN.rman

@ExecControlF.bat