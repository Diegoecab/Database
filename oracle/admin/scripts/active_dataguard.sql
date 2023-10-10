alter database recover managed standby database cancel;
alter database open read only;
alter database recover managed standby database using current logfile disconnect;