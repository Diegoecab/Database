@echo off
title SwitchBack
set ORACLE_SID=CM
echo Inciando SwitchBack...
set acep=
set /p acep=Desea iniciar SwitchBack? [S/N] N:
if not defined acep exit
echo shutdown Abort..
echo shutdown abort >>c:\cm\scripts\switchBack.sql
echo quit >>c:\cm\scripts\switchBack.sql
sqlplus / as sysdba @c:\cm\scripts\switchBack.sql
del c:\cm\scripts\switchBack.sql
echo Copiando archives...
call C:\CM\Scripts\Copiar_Archives.bat
echo Copy DataFiles...
call C:\CM\Scripts\Copiar_Datafiles.bat
echo spool c:\cm\scripts\logs\switchBack.log >>c:\cm\scripts\switchBack.sql
echo startup nomount pfile='c:\cm\scripts\initcm.ora' >>c:\cm\scripts\switchBack.sql
echo alter database mount standby database;  >>c:\cm\scripts\switchBack.sql
echo spool off  >>c:\cm\scripts\switchBack.sql
echo quit  >>c:\cm\scripts\switchBack.sql
sqlplus / as sysdba @c:\cm\scripts\switchBack.sql
del c:\cm\scripts\switchBack.sql
echo Recover StandBy...
call c:\cm\scripts\ExecRecover.bat
echo create spfile from pfile; >>c:\cm\scripts\switchBack.sql
echo quit >>c:\cm\scripts\switchBack.sql
sqlplus / as sysdba @c:\cm\scripts\switchBack.sql
del c:\cm\scripts\switchBack.sql
echo SwitchBack ejecutado. Logs : c:\cm\scripts\logs\switchBack.log
pause