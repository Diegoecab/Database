@rem Seteos de variables 

set nombre_base=DBA

set dir_logs=D:\oracle\DBA\RMAN\Logs

set dir_backup=D:\oracle\DBA\RMAN

set ORACLE_SID=%NOMBRE_BASE%

rman target / catalog rman/catalog@catalog log=%dir_logs%\log_rman_full_%nombre_base%.log @D:\ORACLE\DBA\Scripts\FullCM.rman