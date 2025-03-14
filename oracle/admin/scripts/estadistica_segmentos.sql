Create task and objects script
DECLARE

taskname varchar2(100);
taskdesc varchar2(128);
task_id number;
object_id number;
timeLimit varchar2(25);
numDaysToRetain varchar2(25);
objectName varchar2(100);
objectType varchar2(100);

BEGIN
taskname := 'SEGMENTADV_10032010_DATA';
taskdesc :='Estadisticas de segmentos - TBS DATA';
numDaysToRetain :='30';
dbms_advisor.create_task('Segment Advisor',?,taskname,taskdesc,NULL);
dbms_advisor.create_object(taskname, 'TABLESPACE', 'DATA', ' ', ' ', NULL, object_id);
dbms_advisor.set_task_parameter(taskname, 'RECOMMEND_ALL', 'TRUE');
timeLimit :='12600';
dbms_advisor.set_task_parameter(taskname, 'TIME_LIMIT', timeLimit);
dbms_advisor.set_task_parameter(taskname, 'DAYS_TO_EXPIRE', numDaysToRetain);
END;
	
Execute task script
	
DECLARE
taskname varchar2(100);
BEGIN
taskname := 'SEGMENTADV_10032010_DATA';
dbms_advisor.reset_task(taskname);
dbms_advisor.execute_task(taskname);
END;