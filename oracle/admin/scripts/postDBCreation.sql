connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /u01/app/oracle/admin/db01/scripts/postDBCreation.log
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='/u01/app/oracle/product/10.2.0/dbs/spfiledb01.ora' FROM pfile='/u01/app/oracle/admin/db01/scripts/init.ora';
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup ;
alter user SYSMAN identified by "&&sysmanPassword" account unlock;
alter user DBSNMP identified by "&&dbsnmpPassword" account unlock;
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
host /u01/app/oracle/product/10.2.0/bin/emca -config dbcontrol db -silent -DB_UNIQUE_NAME db01 -PORT 1521 -EM_HOME /u01/app/oracle/product/10.2.0 -LISTENER LISTENER -SERVICE_NAME db01 -SYS_PWD &&sysPassword -SID db01 -ORACLE_HOME /u01/app/oracle/product/10.2.0 -DBSNMP_PWD &&dbsnmpPassword -HOST vtrtest.ryaco.local.com -LISTENER_OH /u01/app/oracle/product/10.2.0 -LOG_FILE /u01/app/oracle/admin/db01/scripts/emConfig.log -SYSMAN_PWD &&sysmanPassword;
spool /u01/app/oracle/admin/db01/scripts/postDBCreation.log
exit;
