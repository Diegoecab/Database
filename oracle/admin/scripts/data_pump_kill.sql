 select * from dba_datapump_jobs
 /
 
DECLARE
   h1 NUMBER;
BEGIN
   h1 := DBMS_DATAPUMP.ATTACH('&job_name','&owner');
   DBMS_DATAPUMP.STOP_JOB (h1,1,0);
END;
/