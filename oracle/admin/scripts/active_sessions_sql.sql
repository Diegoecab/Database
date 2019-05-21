REM	Script buscar los sqls activos
REM ======================================================================
REM active_sessions_sql.sql		Version 1.1	30 Abril 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set serverout on size 999999
     declare
     begin
     dbms_output.put_line(' ');
     dbms_output.put_line('************* Start report for WAITING sessions with current SQL ***************');
     for x in (select vs.inst_id, vs.sid || ',' || vs.serial# sidser, vs.sql_address, vs.sql_hash_value,
     vs.last_call_et, vsw.seconds_in_wait, vsw.event, vsw.state
     from gv$session_wait vsw, gv$session vs
     where vsw.sid = vs.sid
     and vsw.inst_id = vs.inst_id
     and vs.type <> 'BACKGROUND'
     and vsw.event NOT IN ('rdbms ipc message'
     ,'smon timer'
     ,'pmon timer'
     ,'SQL*Net message from client'
     ,'lock manager wait for remote message'
     ,'ges remote message'
     ,'gcs remote message'
     ,'gcs for action'
     ,'client message'
     ,'pipe get'
     ,'Null event'
     ,'PX Idle Wait'
     ,'single-task message'
     ,'PX Deq: Execution Msg'
     ,'KXFQ: kxfqdeq - normal deqeue'
     ,'listen endpoint status'
     ,'slave wait'
     ,'wakeup time manager'))
     loop
     begin
     dbms_output.put_line('Event WaitState InstID SidSerial LastCallEt SecondsInWait');
     dbms_output.put_line('************************* ******************** ****** *********** ********** *************');
     dbms_output.put_line(rpad(x.event,25) ||' '|| rpad(x.state,20) ||' '|| lpad(x.inst_id,6) ||' '|| lpad(x.sidser,11) ||'
     '|| lpad(x.last_call_et,10) ||' '|| lpad(x.seconds_in_wait,13));
     dbms_output.put_line(' SQLText ');
     dbms_output.put_line('****************************************************************');
     for y in (select sql_text
     from gv$sqltext
     where address = x.sql_address
     and hash_value = x.sql_hash_value
     and inst_id = x.inst_id
     order by piece)
     loop
     dbms_output.put_line(y.sql_text);
     end loop;
     end;
     end loop;
     dbms_output.put_line('************** End re! port for sessions waiting with current SQL ****************');
     dbms_output.put_line(' ');
     end;
     /