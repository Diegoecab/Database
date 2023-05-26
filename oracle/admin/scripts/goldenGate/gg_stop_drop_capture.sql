set serveroutput on

begin
for r in (
 SELECT CAPTURE_NAME, QUEUE_NAME, RULE_SET_NAME, NEGATIVE_RULE_SET_NAME, STATUS 
   FROM DBA_CAPTURE) loop
dbms_output.put_line('dropping capture '||r.capture_name);
dbms_capture_adm.stop_capture(r.capture_name,true);
 DBMS_CAPTURE_ADM.DROP_CAPTURE(
    capture_name          => r.capture_name,
    drop_unused_rule_sets => true);
end loop;
end;
/