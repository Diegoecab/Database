mkdir C:\oracle\database\10g\admin\dba\adump
mkdir C:\oracle\database\10g\admin\dba\bdump
mkdir C:\oracle\database\10g\admin\dba\cdump
mkdir C:\oracle\database\10g\admin\dba\dpdump
mkdir C:\oracle\database\10g\admin\dba\pfile
mkdir C:\oracle\database\10g\admin\dba\udump
mkdir C:\oracle\database\10g\dba\cfgtoollogs\dbca\dba
mkdir C:\oracle\database\10g\dba\dbs
mkdir D:\oracle\DBA\DataFiles\dba
mkdir D:\oracle\DBA\flash_recovery_area
set ORACLE_SID=dba
C:\oracle\database\10g\dba\bin\oradim.exe -new -sid DBA -startmode manual -spfile 
C:\oracle\database\10g\dba\bin\oradim.exe -edit -sid DBA -startmode auto -srvcstart system 
C:\oracle\database\10g\dba\bin\sqlplus /nolog @D:\oracle\DBA\Scripts\dba.sql
