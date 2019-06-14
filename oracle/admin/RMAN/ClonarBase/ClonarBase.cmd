oradim -new -sid DBCLONE
set ORACLE_SID=DBA
echo create pfile='d:\oracle\dba\dbclone\initDBCLONE.ora' from spfile; >>temp.sql
echo quit >>temp.sql
sqlplus / as sysdba @temp
del temp.sql
echo Modificar PFile d:\oracle\dba\dbclone\initDBCLONE.ora y crear directorios necesarios!!!
Pause
set ORACLE_SID=DBCLONE
orapwd file=C:\oracle\database\10g\dba\database\ORAPWDdbclone.ora password=dbclone entries=10;
echo Modificar TNSNAMES y LISTENER ...
pause
echo startup nomount force; >>temp.sql
echo quit >>temp.sql
sqlplus / as sysdba @temp
del temp.sql
echo	run	>>temp.sql
echo	{	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\SYSTEM01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\SYSTEM01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\UNDOTBS01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\UNDOTBS01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\SYSAUX01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\SYSAUX01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\USERS01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\USERS01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\EXAMPLE01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\EXAMPLE01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA_LOBS01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA_LOBS01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA_LOBS02.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA_LOBS02.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA_LOBS03.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA_LOBS03.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA_LOBS04.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA_LOBS04.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\STATSPACK01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\STATSPACK01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\STATSPACK02.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\STATSPACK02.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\STATSPACK03.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\STATSPACK03.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\HTMLDB01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\HTMLDB01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\HTMLDB02.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\HTMLDB02.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\HTMLDB03.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\HTMLDB03.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA02.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA02.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA03.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA03.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA04.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA04.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA05.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA05.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA06.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA06.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA07.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA07.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA08.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA08.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA09.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA09.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA10.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA10.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA11.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA11.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA12.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA12.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA13.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA13.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\DBA14.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\DBA14.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\APEX02.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\APEX02.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\APEX01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\APEX01.DBF'	;	>>temp.sql
echo	set newname for datafile 	'D:\ORACLE\DBA\DATAFILES\DBA\SYSTEM02.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\SYSTEM02.DBF'	;	>>temp.sql
echo	set newname for tempfile 	'D:\ORACLE\DBA\DATAFILES\DBA\TEMP01.DBF'	to	'D:\oracle\DBA\DBClone\DATAFILES\TEMP01.DBF'	;	>>temp.sql
echo DUPLICATE TARGET DATABASE TO DBCLONE >>temp.sql
echo LOGFILE >>temp.sql
echo GROUP 1 ('D:\oracle\DBA\DBClone\DATAFILES\REDO01.log') size 10m,>>temp.sql
echo GROUP 2 ('D:\oracle\DBA\DBClone\DATAFILES\REDO02.log') size 10m;>>temp.sql
echo } >>temp.sql
echo quit >>temp.sql
rman target sys/dba@dba CATALOG rman/catalog@catalog AUXILIARY / @temp.sql
rem del temp.sql