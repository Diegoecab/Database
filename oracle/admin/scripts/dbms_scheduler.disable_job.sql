--dbms_scheduler.disable
BEGIN
      sys.dbms_scheduler.disable(name=>'"SYS"."FULL_BACKUP"');
END;
/Bostero