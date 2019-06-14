set verify off
PROMPT specify a password for sys as parameter 1;
DEFINE sysPassword = &1
PROMPT specify a password for system as parameter 2;
DEFINE systemPassword = &2
PROMPT specify a password for sysman as parameter 3;
DEFINE sysmanPassword = &3
PROMPT specify a password for dbsnmp as parameter 4;
DEFINE dbsnmpPassword = &4
host C:\oracle\database\10g\dba\bin\orapwd.exe file=C:\oracle\database\10g\dba\database\PWDdba.ora password=&&sysPassword force=y
@D:\oracle\DBA\Scripts\CloneRmanRestore.sql
@D:\oracle\DBA\Scripts\cloneDBCreation.sql
@D:\oracle\DBA\Scripts\postScripts.sql
host "echo SPFILE='C:\oracle\database\10g\dba/dbs/spfiledba.ora' > C:\oracle\database\10g\dba\database\initdba.ora"
@D:\oracle\DBA\Scripts\postDBCreation.sql
