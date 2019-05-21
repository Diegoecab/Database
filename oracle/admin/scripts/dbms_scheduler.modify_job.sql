--dbms_scheduler.modify_job.sql

prompt Examples on script
/*
BEGIN
sys.dbms_scheduler.set_attribute( name => '"DBADMIN"."DBS_STATISTICS"', attribute => 'comments', value => 'Citi - Statistics Job');

END; 
/

BEGIN
sys.dbms_scheduler.set_attribute( name => '"DBADMIN"."DBS_STATISTICS"', attribute => 'auto_drop', value => FALSE);

END; 
/


BEGIN
      sys.dbms_scheduler.enable(name=>'"DBADMIN"."DBS_STATISTICS"');
END;
*/