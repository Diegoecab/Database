06:11:08 SYS@TESTER1 SQL> alter system set db_recovery_file_dest_size=1g;
 
System altered.
 
Elapsed: 00:00:00.12
06:11:19 SYS@TESTER1 SQL> alter system set db_recovery_file_dest='/u03/testdb/TESTER1';
 
System altered.
 
Elapsed: 00:00:00.36
06:11:25 SYS@TESTER1 SQL> show parameter db_recovery_file_dest
 
NAME TYPE VALUE
------------------------------------ ----------- ------------------------------
db_recovery_file_dest string /u03/testdb/TESTER1
db_recovery_file_dest_size big integer 1G
 
 
 
06:11:33 SYS@TESTER1 SQL> alter database flashback on;
 
Database altered.
 
Elapsed: 00:00:21.13
06:12:03 SYS@TESTER1 SQL> select flashback_on from v$database;
 
FLASHBACK_ON
------------------
YES
 
1 row selected.
 






alter database convert to snapshot standby;
alter database open;
srvctl start instance -d <> -i <>

shut immediate;
startup mount;
alter database convert to physical standby;

recover managed standby database disconnect from session;