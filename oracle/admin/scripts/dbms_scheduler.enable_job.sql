--dbms_scheduler.enable_job
BEGIN
      sys.dbms_scheduler.enable(name=>'"DBADMIN"."DBS_STATISTICS"');
END;
/