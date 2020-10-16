Quick installation guide

This is just a quick installation guide to install this script in a Linux environment. 
The system and software requirements are documented on Oracle confluence: https://confluence.oraclecorp.com/confluence/display/DTVDBA/ACS+DataPump+and+upload+to+OCI+storage+script

This example was executed on Linux RHEL 6 with Oracle DB 18c with the database OS owner (oracle).


1) Create a folder where will be the script home. In this case: /u01/app/oracle/oci_expdp2. Copy and extract file acs_exp_oci.tar.gz on it. E.g.:

[oracle@rgemdbp1546 oci_expdp2]$ pwd
/u01/app/oracle/oci_expdp2
[oracle@rgemdbp1546 oci_expdp2]$ ls
acs_exp_oci.tar.gz
[oracle@rgemdbp1546 oci_expdp2]$ tar -xvzf acs_exp_oci.tar.gz
cfg/
cfg/oracle.acs.oci.expdp.cfg
hist/
log/
log/dpexp/
par/
par/dev/
par/dev/exp.par
par/exp_full.par
par/exp_full_metadata.par
par/exp_schema_metadata.par
par/exp_tables.par
par/prod/
par/prod/exp.par
par/qa/
par/qa/exp.par
sh/
sh/oracle.acs.oci.expdp.ksh
stg/
tmp/
[oracle@rgemdbp1546 oci_expdp2]$

2) Change permissions to files and folders:

[oracle@rgemdbp1546 oci_expdp2]$ find . -type f -exec chmod 766 {} \;
[oracle@rgemdbp1546 oci_expdp2]$ find . -type d -exec chmod 766 {} \;

3) Edit the configuration files with the required values in the config file: cfg/oracle.acs.oci.expdp.cfg

4) Execute the script to make a test. In this case I'll use the example parfile exp_schema_metadata.par which is a metadata export for the schema SYSTEM. 

[oracle@rgemdbp1546 oci_expdp2]$ /u01/app/oracle/oci_expdp2/sh/oracle.acs.oci.expdp.ksh parfile=/u01/app/oracle/oci_expdp2/par/exp_schema_metadata.par
2020-10-15 18:09:42 (main) [INFO]: ################################################################################################################
2020-10-15 18:09:42 (main) [INFO]: #
2020-10-15 18:09:42 (main) [INFO]: # Oracle ACS Datapump script
2020-10-15 18:09:42 (main) [INFO]: #
2020-10-15 18:09:42 (main) [INFO]: # Executing script oracle.acs.oci.expdp with parameters: parfile=/u01/app/oracle/oci_expdp2/par/exp_schema_metadata.par
2020-10-15 18:09:42 (main) [INFO]: # Executed on rgemdbp1546.dtvpan.com by oracle
2020-10-15 18:09:42 (main) [INFO]: # General logfile: /u01/app/oracle/oci_expdp2/log/oracle.acs.oci.expdp.main.151020.log
2020-10-15 18:09:42 (main) [INFO]: #
2020-10-15 18:09:42 (main) [INFO]: ################################################################################################################
2020-10-15 18:09:42 (fn_exp) [INFO]: Executing datapump export with parameters:
2020-10-15 18:09:42 (fn_exp) [INFO]: parfile=/u01/app/oracle/oci_expdp2/par/exp_schema_metadata.par
2020-10-15 18:09:42 (fn_exp) [INFO]: Logfile: /u01/app/oracle/oci_expdp2/log/dpexp/oracle.acs.oci.expdp.151020.201015180942.log
2020-10-15 18:10:21 (fn_exp) [INFO]: DataPump export executed successfully
2020-10-15 18:10:21 (fn_exp) [INFO]:
Export: Release 18.0.0.0.0 - Production on Thu Oct 15 18:09:42 2020
Version 18.3.0.0.0

Copyright (c) 1982, 2018, Oracle and/or its affiliates.  All rights reserved.

Connected to: Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
Starting "SYS"."SYS_EXPORT_SCHEMA_01":  /******** AS SYSDBA parfile=/u01/app/oracle/oci_expdp2/par/exp_schema_metadata.par
Processing object type SCHEMA_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
Processing object type SCHEMA_EXPORT/SYSTEM_GRANT
Processing object type SCHEMA_EXPORT/ROLE_GRANT
Processing object type SCHEMA_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
Processing object type SCHEMA_EXPORT/DEFAULT_ROLE
Processing object type SCHEMA_EXPORT/PRE_SCHEMA/PROCACT_SCHEMA
Processing object type SCHEMA_EXPORT/STATISTICS/MARKER
Processing object type SCHEMA_EXPORT/TABLE/TABLE
Processing object type SCHEMA_EXPORT/TABLE/GRANT/OWNER_GRANT/OBJECT_GRANT
Processing object type SCHEMA_EXPORT/VIEW/VIEW
Processing object type SCHEMA_EXPORT/VIEW/GRANT/OWNER_GRANT/OBJECT_GRANT
Master table "SYS"."SYS_EXPORT_SCHEMA_01" successfully loaded/unloaded
******************************************************************************
Dump file set for SYS.SYS_EXPORT_SCHEMA_01 is:
  /backup/EM/emrep/exp_full_metadata.01.dmp
  /backup/EM/emrep/exp_full_metadata.02.dmp
  /backup/EM/emrep/exp_full_metadata.03.dmp
  /backup/EM/emrep/exp_full_metadata.04.dmp
Job "SYS"."SYS_EXPORT_SCHEMA_01" successfully completed at Thu Oct 15 18:10:20 2020 elapsed 0 00:00:38
2020-10-15 18:10:21 (fn_exp) [INFO]: Dumpfiles:
2020-10-15 18:10:21 (fn_exp) [INFO]: /backup/EM/emrep/exp_full_metadata.01.dmp
2020-10-15 18:10:21 (fn_exp) [INFO]: /backup/EM/emrep/exp_full_metadata.02.dmp
2020-10-15 18:10:21 (fn_exp) [INFO]: /backup/EM/emrep/exp_full_metadata.03.dmp
2020-10-15 18:10:21 (fn_exp) [INFO]: /backup/EM/emrep/exp_full_metadata.04.dmp
2020-10-15 18:10:21 (main) [INFO]: Upload to bucket is disabled
2020-10-15 18:10:21 (main) [INFO]: Moving files to hist folder
2020-10-15 18:10:21 (fn_move_hist) [INFO]: Moving files to history folder /u01/app/oracle/oci_expdp2/hist
2020-10-15 18:10:21 (fn_move_hist) [INFO]: Moving file /backup/EM/emrep/exp_full_metadata.01.dmp to /u01/app/oracle/oci_expdp2/hist/151020_18_09
2020-10-15 18:10:21 (fn_move_hist) [INFO]: Moving file /backup/EM/emrep/exp_full_metadata.02.dmp to /u01/app/oracle/oci_expdp2/hist/151020_18_09
2020-10-15 18:10:21 (fn_move_hist) [INFO]: Moving file /backup/EM/emrep/exp_full_metadata.03.dmp to /u01/app/oracle/oci_expdp2/hist/151020_18_09
2020-10-15 18:10:21 (fn_move_hist) [INFO]: Moving file /backup/EM/emrep/exp_full_metadata.04.dmp to /u01/app/oracle/oci_expdp2/hist/151020_18_09
2020-10-15 18:10:21 (fn_purge) [INFO]: 0 files deleted on /u01/app/oracle/oci_expdp2/log (retention of 30 days)
2020-10-15 18:10:21 (fn_purge) [INFO]: 0 files deleted on /u01/app/oracle/oci_expdp2/tmp (retention of 30 days)
2020-10-15 18:10:21 (fn_purge) [INFO]: 0 directories deleted on /u01/app/oracle/oci_expdp2/hist (retention of 7 days)
2020-10-15 18:10:21 (main) [INFO]: ################################################################################################################
2020-10-15 18:10:21 (main) [INFO]: #End of script
2020-10-15 18:10:21 (main) [INFO]: ################################################################################################################
[oracle@rgemdbp1546 oci_expdp2]$
