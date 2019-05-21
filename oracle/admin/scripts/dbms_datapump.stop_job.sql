--dbms_datapump.stop_job.sql
@datapump_status
SET serveroutput on
SET lines 100
DECLARE
   h1 NUMBER;
BEGIN
  -- Format: DBMS_DATAPUMP.ATTACH('[job_name]','[owner_name]');
   h1 := DBMS_DATAPUMP.ATTACH('&JOB_NAME','&OWNER_NAME');
   DBMS_DATAPUMP.STOP_JOB (h1,1,0);
END;
/