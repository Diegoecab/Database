#

RUN 
{
  # Optionally, set upper limit for eligible time stamps of control file 
  # backups
  # SET UNTIL TIME '09/10/2000 13:45:00';
  # Specify a nondefault autobackup format only if required
  # SET CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK 
  #   TO '?/oradata/%F.bck';
  ALLOCATE CHANNEL c1 DEVICE TYPE sbt PARMS='...'; # allocate manually
  RESTORE CONTROLFILE FROM AUTOBACKUP
    MAXSEQ 100           # start at sequence 100 and count down
    MAXDAYS 180;         # start at UNTIL TIME and search back 6 months
  ALTER DATABASE MOUNT DATABASE;
}
# uses automatic channels configured in restored control file
RESTORE DATABASE UNTIL SEQUENCE 13243;
RECOVER DATABASE UNTIL SEQUENCE 13243; # recovers to latest archived log


#

If recovery was successful, then open the database and reset the online logs:

ALTER DATABASE OPEN RESETLOGS;
