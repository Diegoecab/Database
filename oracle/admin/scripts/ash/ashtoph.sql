--@ash/ashtoph event "machine like '%1454' and username='CAMPAIGN_AR'" to_date('11-11-20:01:00','DD-MM-YY:HH24:MI') to_date('11-11-20:10:00','DD-MM-YY:HH24:MI')
--

--@ash/ashtoph wait_class 1=1 to_date('28-09-21:03:30','DD-MM-YY:HH24:MI') to_date('28-09-21:04:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event,sql_id,object_name,module,machine,program sql_id='4ufsr1agt4kdz' to_date('06-12-21:19:20','DD-MM-YY:HH24:MI') to_date('06-12-21:19:40','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class 1=1 to_date('15-12-21:12:10','DD-MM-YY:HH24:MI') to_date('15-12-21:12:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph TO_CHAR(sample_time,'DD-MM-YY:HH24'),sql_id "event like 'latch: enqueue hash chain%'" trunc(sysdate-20) trunc(sysdate)
--@ash/ashtoph sql_id "event like 'library cache: mutex X%'" to_date('03-08-21:19:00','DD-MM-YY:HH24:MI') to_date('03-08-21:21:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,sql_id "sql_id='8uyczqp93ws6x'--module like 'dbclient_ora%'"  trunc(sysdate-30) sysdate
--@ash/ashtoph TO_CHAR(sample_time,'DD-MM-YY'),username "sql_id='d9j5zt3bvj3m6'--module like 'dbclient_ora%'"  trunc(sysdate-10) sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "sql_id='5hq4sk70mb9nx' and event='enq: TM - contention'--and wait_class='Other'" trunc(sysdate-60) sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "event='buffer busy waits'" trunc(sysdate-30) sysdate
--@ash/ashtoph username,machine,program,sql_id "username='SRVCENGINEERLAKE'" trunc(sysdate-30) sysdate
--@ash/ashtoph username "username <> 'SYS'" trunc(sysdate-30) sysdate
--@ash/ashtoph event,wait_class,object_name,sql_plan_operation,sql_plan_options "sql_id='8n0jvgdz8jv84' and sql_plan_hash_value='1593682286'" trunc(sysdate-30) sysdate
--@ash/ashtoph event "username like 'RECTOR%'" trunc(sysdate-10) sysdate
--@ash/ashtoph event "wait_class is null" trunc(sysdate-10) sysdate
--@ash/ashtoph module session_type='FOREGROUND' trunc(sysdate-10) sysdate
--@ash/ashtoph sql_id "username<>'SYS' and sql_id is not null" trunc(sysdate-2) sysdate
--@ash/ashtoph username "username<>'SYS' and sql_id is not null" trunc(sysdate-2) sysdate
--@ash/ashtoph event 1=1 to_date('03-08-21:19:00','DD-MM-YY:HH24:MI') to_date('03-08-21:20:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph event username='CAMPAIGN_CH' to_date('02-12-20:12:00','DD-MM-YY:HH24:MI') to_date('02-12-20:13:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,sql_id,object_name,sql_plan_operation,sql_plan_options,SQL_OPCODE,SQL_OPNAME "event='External Procedure call'" sysdate-5 sysdate
--@ash/ashtoph wait_class,sql_id,object_name,sql_plan_operation,sql_plan_options,SQL_OPCODE,SQL_OPNAME "username='CAMPAIGN_CH' and event is null" to_date('02-12-20:12:00','DD-MM-YY:HH24:MI') to_date('02-12-20:13:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph object_name,SQL_OPNAME "username='CAMPAIGN_CH' and event is null" to_date('02-12-20:12:00','DD-MM-YY:HH24:MI') to_date('02-12-20:13:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event "username='CAMPAIGN_CH' and object_name is null" to_date('02-12-20:12:00','DD-MM-YY:HH24:MI') to_date('02-12-20:13:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph event "sql_id='1yxm1319bwrb'" to_date('02-12-20:12:00','DD-MM-YY:HH24:MI') to_date('02-12-20:14:00','DD-MM-YY:HH24:MI')

--@ash/ashtoph  TO_CHAR(sample_time,'YY-MM-DD:HH24') "sql_id='5hq4sk70mb9nx'" trunc(sysdate-7) sysdate

--@ash/ashtoph event,object_name,sql_plan_operation,sql_plan_options,SQL_OPCODE,SQL_OPNAME,round(temp_space_allocated/1024/1024/1024) "sql_id='0tpqv24664f7s'" trunc(sysdate-15) sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD'),round((temp_space_allocated/1024/1024/1024)) 1=1 trunc(sysdate-15) sysdate
--@ash/ashtoph sql_id,round(temp_space_allocated/1024/1024/1024) "(TEMP_SPACE_ALLOCATED/1024/1024/1024) > 100 and username='CAM_01'" trunc(sysdate-15) sysdate
--@ash/ashtoph username "(TEMP_SPACE_ALLOCATED/1024/1024/1024) > 100" trunc(sysdate-15) sysdate
--@ash/ashtoph sql_id,event,sql_plan_operation,sql_plan_options,SQL_OPCODE,SQL_OPNAME "(SQL_PLAN_OPERATION ='JOIN FILTER' or SQL_PLAN_OPERATION like '%GROUP BY%')" trunc(sysdate-2) sysdate
--@ash/ashtoph sql_id "(SQL_PLAN_OPERATION ='JOIN FILTER' or SQL_PLAN_OPERATION like '%GROUP BY%')" trunc(sysdate-2) sysdate
--@ash/ashtoph sql_id "object_name in ('DA_GEO_GEOGRAFIA','SA_REL_PCOMERCIAL_CLIENTE_HIST','FA_FOTO_CONTRATO_PRODUCTO_D','F_FOTO_CONTRATO_PRODUCTO','F_CONTACTO','D_ECO_ENCUESTA_COMPLETA')" trunc(sysdate-2) sysdate
--@ash/ashtoph sql_id,sql_plan_operation,sql_plan_options "object_name ='SCHEDULE_RECORD_IDX001'" trunc(sysdate-30) sysdate

--@ash/ashtoph object_name 1=1 trunc(sysdate-2) sysdate
--@ash/ashtoph sql_id,username "event like 'direct path % temp'" trunc(sysdate-30) sysdate

--@ash/ashtoph event "machine like '%1454' and username='CAMPAIGN_AR'" to_date('10-11-20:01:00','DD-MM-YY:HH24:MI') to_date('10-11-20:10:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph username,plsql_object_id,plsql_entry_object_id,plsql_entry_subprogram_id,objt "machine like '%1454'" to_date('11-11-20:01:00','DD-MM-YY:HH24:MI') to_date('11-11-20:10:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph  wait_class,event "machine like '%1454'" to_date('10-11-20:01:00','DD-MM-YY:HH24:MI') to_date('10-11-20:10:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph sql_id 1=1 to_date('02-11-20:12:00','DD-MM-YY:HH24:MI') to_date('02-11-20:17:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph sql_id 1=1 trunc(sysdate) (sysdate)
--@ash/ashtoph sql_id "sql_id=" to_date('02-11-20:12:00','DD-MM-YY:HH24:MI') to_date('02-11-20:17:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,instance_number,module,machine,sql_id "username='S_CO_PRD_SSIS_DB' and wait_class like '%User I/O%'" to_date('28-08-20:00:00','DD-MM-YY:HH24:MI') to_date('28-08-20:23:59','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,instance_number,module,machine,sql_id "username='S_CO_PRD_SSIS_DB' and wait_class like '%User I/O%'" to_date('28-08-20:00:00','DD-MM-YY:HH24:MI') to_date('28-08-20:23:59','DD-MM-YY:HH24:MI')
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD'),wait_class "username='S_RG_PRO_CONS'" sysdate-30 sysdate
--@ash/ashtoph SERVICE_HASH 1=1 trunc(sysdate-7) sysdate
--@ash/ashtoph SERVICE_HASH "wait_class='User I/O'" trunc(sysdate-7) sysdate
--@ash/ashtoph username 1=1 sysdate-4 sysdate
--@ash/ashtoph wait_class 1=1 sysdate-4 sysdate
--@ash/ashtoph wait_class,event,instance_number,username,module,machine,sql_id 1=1 to_date('25-07-20:00:00','DD-MM-YY:HH24:MI') to_date('31-07-20:10:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph username,sql_id "session_type='BACKGROUND' and event2 like 'db file seque%'" sysdate-10 sysdate
--@ash/ashtoph event,sql_id "wait_class='User I/O' and instance_number=2" to_date('05-10-20:04:00','DD-MM-YY:HH24:MI') to_date('05-10-20:05:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,username,sql_id "module like 'JDBC Thin%'" to_date('25-09-20:01:00','DD-MM-YY:HH24:MI') to_date('25-09-20:05:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event,wait_class,session_state,username,sql_id 1=1 to_date('25-07-20:00:00','DD-MM-YY:HH24:MI') to_date('31-07-20:10:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph session_type,wait_class,event2,username,sql_id 1=1 to_date('04-09-20:01:00','DD-MM-YY:HH24:MI') to_date('04-09-20:05:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event 1=1 to_date('01-03-21:01:00','DD-MM-YY:HH24:MI') to_date('01-03-21:03:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event 1=1 trunc(sysdate) sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD'),session_type,wait_class,instance_number "event2='Disk file operations I/O'" to_date('14-07-20:00:00','DD-MM-YY:HH24:MI') to_date('14-07-20:23:59','DD-MM-YY:HH24:MI')
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD'),session_type,wait_class,machine,module,instance_number "event2='Disk file operations I/O' and module like 'oraagent%'" trunc(sysdate-1) sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD:HH24'),session_type,wait_class,machine,module,instance_number " module like 'oraagent%'" sysdate-1 sysdate
--@ash/ashtoph event,username,objec_name "wait_class='Application'" sysdate-30 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "sql_id='3sbmd3ybv4fbb'" sysdate-60 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD'),session_type " module like 'oraagent%' and instance_number=1" sysdate-1 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD'),session_type " module like 'oraagent%'" sysdate-1 sysdate
--Lunes a viernes de 9 a 15Hs, todo lo session_state WAITING
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "session_state='WAITING' and to_char(sample_time,'d') between 2 and 6 and to_char(sample_time,'HH24') between 9 and 15 " sysdate-30 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "session_state='WAITING' and to_char(sample_time,'d') between 2 and 6 and to_char(sample_time,'HH24') between 9 and 15 and username='S_RG_ESB'" sysdate-30 sysdate
--
--@ash/ashtoph wait_class,event2,username 1=1 to_date('22-07-20:20:00','DD-MM-YY:HH24:MI') to_date('23-07-20:02:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph instance_number,session_state,event,machine,module,sql_id,object_name,sql_child_number,sql_plan_hash_value sql_id='1t92x6dsgkxk5' sysdate-10 sysdate
--@ash/ashtoph instance_number,session_state,event,machine,module,sql_id,sql_child_number,sql_plan_hash_value sql_id='4jxjv0mtr7xzh' sysdate-30 sysdate
--@ash/ashtoph instance_number,username,session_state,event,sql_id "event2='free buffer waits'" sysdate-2 sysdate
--@ash/ashtoph instance_number,username,session_state,event,sql_id "event2='gc cr failure'" sysdate-30 sysdate
--@ash/ashtoph instance_number,username,session_type,session_state,event "session_state='WAITING'" sysdate-30 sysdate
--@ash/ashtoph username,sql_id,object_name,event "event2 like 'enq: TX - row l%'" sysdate-1 sysdate
--@ash/ashtoph event,username,sql_id "username like 'S_EC_PRD_SSRS_DB%'" sysdate-15 sysdate
--@ash/ashtoph instance_number,event,wait_class,session_state,username,time_model_name,IN_CONNECTION_MGMT,session_type,plsql_object_id,plsql_entry_object_id,plsql_entry_subprogram_id,objt,sql_id 1=1 to_date('06-08-20:13:00','DD-MM-YY:HH24:MI') to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--
--@ash/ashtoph event,wait_class,session_state,username 1=1 to_date('12-08-20:10:00','DD-MM-YY:HH24:MI') to_date('12-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event,wait_class,session_state,time_model_name,instance_number,sql_id "username='S_RG_ESB' and wait_class='Commit' and EVENT='log file sync'" sysdate-120 to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event,wait_class,session_state,instance_number,to_char(sample_time,'YY-MM-DD') "wait_class='Commit'" sysdate-120 to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph instance_number,event,wait_class,session_state,username,object_name,sql_plan_operation,sql_plan_options 1=1 to_date('20-08-20:09:00','DD-MM-YY:HH24:MI') to_date('20-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph instance_number,event,wait_class,session_state,username,sid,serial,machine,object_name,objt,sql_plan_operation,sql_plan_options,sql_id  "object_name like 'CI_CELL_PACKAGE' and username like 'CDM_PE'" to_date('21-08-20:00:00','DD-MM-YY:HH24:MI') to_date('25-08-20:18:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph username,wait_class,event,session_state,sql_id "sid='1967' and serial='32760'" to_date('06-11-20:09:00','DD-MM-YY:HH24:MI') to_date('09-11-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event,wait_class,username 1=1 to_date('20-08-20:09:00','DD-MM-YY:HH24:MI') to_date('20-08-20:18:00','DD-MM-YY:HH24:MI')

--User IO
--@ash/ashtoph event,sql_id,username,object_name,sql_plan_operation,sql_plan_options "wait_class='User I/O'" trunc(sysdate) sysdate
--@ash/ashtoph sql_id "wait_class='User I/O'" trunc(sysdate) sysdate

--@ash/ashtoph event,sql_id,username,object_name,sql_plan_operation,sql_plan_options "wait_class='User I/O' and object_name='GO_EVENTS'" trunc(sysdate-30) sysdate
--@ash/ashtoph event,sql_id,module "wait_class='User I/O' and object_name='GO_EVENTS'" trunc(sysdate-30) sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "wait_class='Network' --and username='S_AR_PRD_SAS_RED'" sysdate-15 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD'),sql_id "wait_class='User I/O' and object_name='GO_EVENTS'" sysdate-2 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "wait_class='User I/O'" sysdate-30 sysdate
--@ash/ashtoph wait_class,TO_CHAR(sample_time,'YYYY-MM-DD') "wait_class='User I/O' and session_state='WAITING'" sysdate-15 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "sql_id='11bn3uvjfpr2b' and wait_class='User I/O' and event='direct path read' and session_state='WAITING' --and to_char(sample_time,'d') between 1 and 5" sysdate-30 sysdate
--@ash/ashtoph wait_class,event,module "to_char(sample_time,'hh24') between 1 and 6" sysdate-10 sysdate
--@ash/ashtoph username "to_char(sample_time,'hh24') between 1 and 6  " sysdate-10 sysdate
--@ash/ashtoph username,sql_id "to_char(sample_time,'hh24') between 1 and 6 and wait_class='User I/O' and username='REPLICA_ASPECT' " sysdate-15 sysdate
--@ash/ashtoph username,sql_id,plsql_object_id,plsql_entry_object_id,plsql_entry_subprogram_id "sql_id='4cf08zmz80mu8'" sysdate-30 sysdate
--Top sql por objeto
--@ash/ashtoph sql_id,module "wait_class='User I/O' and object_name='GO_EVENTS' and event like '%read'" trunc(sysdate-30) sysdate
--@ash/ashtoph username,sql_id,module,sql_plan_operation,sql_plan_options "object_name='AGREEMENT_DETAIL' and module<>'GoldenGate' " trunc(sysdate-10) sysdate



--@ash/ashtoph event,wait_class,session_state,instance_number,sql_id username='S_RG_ESB' to_date('06-08-20:13:00','DD-MM-YY:HH24:MI') to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph username 1=1 to_date('06-08-20:13:00','DD-MM-YY:HH24:MI') to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')

--@ash/ashtoph instance_number,event,event2,wait_class,session_state,username,time_model_name,object_name,sql_plan_options,sql_plan_operation "sql_id='f11tc34f7mjru'" sysdate-15 sysdate
--@ash/ashtoph instance_number,event,event2,wait_class,session_state,username,time_model_name,object_name,sql_plan_options,sql_plan_operation "sql_id='2znpkwwdb0kq7'" sysdate-15 sysdate
--@ash/ashtoph event "sql_id='bau85hwztavnw'" TRUNC(sysdate) sysdate




--@ash/ashtoph event,wait_class,session_state,username,time_model_name "sql_id='1hw6qzhtbf0f8'" sysdate-5 sysdate

--@ash/ashtoph username,sql_id,machine,module,event "event = 'enq: TM - contention' and username like 'CDM%'" trunc(sysdate-180) sysdate
--@ash/ashtoph username,sql_id,machine,module,event "sql_id='ch5v0wxajrjzd'" trunc(sysdate-3) sysdate
--@ash/ashtoph wait_class,event,sql_id "username='REPLICA_ASPECT' and wait_class='User I/O'" sysdate-20 sysdate
--@ash/ashtoph username,sql_id,plsql_object_id,plsql_entry_object_id,plsql_entry_subprogram_id "username='REPOPER_RAO' and  (plsql_entry_object_id, plsql_entry_subprogram_id) in (select object_id, subprogram_id from dba_procedures where object_name='PKG_REPORTES_SGI' and PROCEDURE_NAME='SP_CARGA_AGE_FIN_MES')" to_date('28-06-20:00:00','DD-MM-YY:HH24:MI') to_date('08-07-20:10:00','DD-MM-YY:HH24:MI')

--@ash/ashtoph wait_class,event,session_state,username,plsql_object_id,plsql_entry_object_id,plsql_entry_subprogram_id,sql_id "username='FACTURACION' and (plsql_entry_object_id, plsql_entry_subprogram_id) in (select object_id, subprogram_id from dba_procedures where object_name='SP_TABLAS_UNIVERSALES')" to_date('25-07-20:00:00','DD-MM-YY:HH24:MI') to_date('31-07-20:10:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph username,plsql_entry_object_id,plsql_entry_subprogram_id "plsql_entry_object_id is not null" sysdate-7 sysdate
--@ash/ashtoph username,sql_id,machine,module,instance_number "plsql_entry_object_id =242065 and plsql_entry_subprogram_id=13" sysdate-7 sysdate
--@ash/ashtoph username,module 1=1 sysdate-7 sysdate
--@ash/ashtoph wait_class,event2 "session_type='FOREGROUND'" sysdate-10 sysdate
--@ash/ashtoph session_type,wait_class 1=1 sysdate-10 sysdate
--@ash/ashtoph wait_class,event,instance_number,username,module,machine,sql_id "upper(machine) like 'RGBAAPP14%' " sysdate-30 sysdate
--@ash/ashtoph wait_class,event,instance_number,username,module,machine,sql_id "sql_id in ('cgrvv9rp0a7qz','cjvjwxjs5q9z0') " sysdate-30 sysdate
--
-- Entre las 9 y 14 hs los ultimos N días
--@ash/ashtoph wait_class,event,module,username " upper(machine) like 'RGBAAPP14%' and session_state='WAITING' and to_char(sample_time,'HH24') between 9 and 14 " sysdate-120 sysdate
--@ash/ashtoph event,session_state "to_char(sample_time,'HH24') between 9 and 15 and username = 'CUSTOMER' and wait_class like 'like '%I/O'" sysdate-10 sysdate
--@ash/ashtoph sql_id,module "wait_class='User I/O' and object_name='GO_EVENTS' and event like '%read'" trunc(sysdate-30) sysdate
--@ash/ashtoph sql_id,module,sql_plan_options,sql_plan_operation "wait_class='User I/O' and to_char(sample_time,'HH24') between 9 and 15 and object_name='GO_EVENTS' and event like '%read'" trunc(sysdate-10) sysdate
--@ash/ashtoph sql_id,module "wait_class='User I/O' and to_char(sample_time,'HH24') between 9 and 15 and object_name='GO_EVENTS' and event like '%read'" trunc(sysdate-20) trunc(sysdate-10)
--@ash/ashtoph wait_class,event,session_state,sql_id "to_char(sample_time,'HH24') between 9 and 15 " trunc(sysdate) sysdate
--@ash/ashtoph event,wait_class,session_state,instance_number,to_char(sample_time,'YY-MM-DD') "to_char(sample_time,'HH24') between 9 and 15 " sysdate-45 to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph event,wait_class,session_state,instance_number,to_char(sample_time,'YY-MM-DD') "wait_class='Commit'" sysdate-120 to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,session_state,machine,username,sql_id "to_char(sample_time,'HH24') between 9 and 15 " to_date('06-08-20:09:00','DD-MM-YY:HH24:MI') to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,session_state,machine,username,sql_id "to_char(sample_time,'HH24') between 9 and 15 " to_date('11-08-20:09:00','DD-MM-YY:HH24:MI') to_date('11-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,session_state,username,sql_id "to_char(sample_time,'HH24') between 9 and 15 and username=' " to_date('11-08-20:09:00','DD-MM-YY:HH24:MI') to_date('11-08-20:15:00','DD-MM-YY:HH24:MI')

--@ash/ashtoph username,sql_id " sql_id is not null and upper(machine) like 'RGBAAPP14%' and session_state='WAITING' and to_char(sample_time,'HH24') between 9 and 14 " sysdate-30 sysdate
--
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "wait_class like '%I/O' and event like 'direct path % temp'" sysdate-30 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD-HH24:MI') "event='log file sync'--sql_id='8uyczqp93ws6x'"  trunc(sysdate-60) sysdate
--@ash/ashtoph event,username,object_name,owner "wait_class like '%I/O' and event like 'direct path rea%'" sysdate+(1/1440*-120) sysdate
--@ash/ashtoph username,object_name,owner "wait_class like '%I/O' and username <>'SYS' and instance_number=2" to_date('05-10-20:04:00','DD-MM-YY:HH24:MI') to_date('05-10-20:05:30','DD-MM-YY:HH24:MI')
--@ash/ashtoph object_name "1=1--wait_class like '%I/O' and username like 'ENRI%' " trunc(sysdate) sysdate
--@ash/ashtoph wait_class,event,module,session_state,username,sql_id,instance_number "(wait_class like '%I/O' or wait_class='Commit')" sysdate+(1/1440*-120) sysdate
--@ash/ashtoph wait_class,event,session_state,sql_id "(username='S_RG_ESB' and sql_id is not null)" to_date('14-08-20:09:00','DD-MM-YY:HH24:MI') to_date('14-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event,module,session_state,instance_number "sql_id='11bn3uvjfpr2b'" sysdate+(1/1440*-60) sysdate
--@ash/ashtoph wait_class,event "module='w3wp.exe' and instance_number=2" sysdate+(1/1440*-60) sysdate
--
--@ash/ashtoph event,wait_class,p1,p2 "sql_id='92586z0ty5r0x'" sysdate-30 sysdate
--Uso de CPU por sqlid
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "sql_id='2xkaw74uaajbp' and wait_class is null" sysdate-30 sysdate
--@ash/ashtoph username "sql_id='2xkaw74uaajbp' and wait_class is null" sysdate-30 sysdate
--@ash/ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') "sql_id='2xkaw74uaajbp' and wait_class is null and username='BUSINESSDATA_CHILE'" sysdate-30 sysdate
----@ash/ashtoph sql_id,event,event2,object_name "event like 'enq:%' and username like 'EDW_PROD_LOADER%'" sysdate+(1/1440*-600) sysdate
--col event for a30 truncate
--col event2 for a30 truncate
--col object_name for a20 truncate
--@ash/ashtoph wait_class,event,event2,sql_id,object_name "upper(machine) like 'RGBAAPP1%'" to_date('02-11-20:01:00','DD-MM-YY:HH24:MI') to_date('02-11-20:05:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event "upper(machine) like 'RGBAAPP1454'" to_date('02-11-20:01:00','DD-MM-YY:HH24:MI') to_date('02-11-20:05:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph wait_class,event "upper(machine) like 'RGBAAPP1454' and sql_id='07yc32snxnd9p'" to_date('02-11-20:01:00','DD-MM-YY:HH24:MI') to_date('02-11-20:05:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph sql_id "upper(machine) like 'RGBAAPP1454' and event='cell list of blocks physical read'" to_date('02-11-20:01:00','DD-MM-YY:HH24:MI') to_date('02-11-20:05:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph sql_id "object_name like 'F_FOTO_CONTRATO_PROD%' and username like 'EDW_PROD_LOADER%'" to_date('23-10-20:10:00','DD-MM-YY:HH24:MI') to_date('23-10-20:17:00','DD-MM-YY:HH24:MI')
--@ash/ashtop object_name,event,sql_id "event like 'enq:%' and username like 'EDW_PROD_LOADER%'" sysdate+(1/1440*-60) sysdate
--@ash/ashtoph "TO_CHAR(sample_time,'YYYY-MM-DD HH24')" "event like 'direct path % temp' --and module like 'osh@rgbisapp%'" sysdate-4 sysdate
--@ash/ashtoph module "event like 'direct path % temp' --and username like 'EDW_PROD_LOADER%'" sysdate-4 sysdate
--@ash/ashtoph instance_number "event like 'direct path % temp' --and username like 'EDW_PROD_LOADER%'" sysdate-4 sysdate
--@ash/ashtoph lpad(program,4) "event like 'direct path % temp' --and username like 'EDW_PROD_LOADER%'" sysdate-4 sysdate
--@ash/ashtoph username "event like 'direct path % temp' --and username like 'EDW_PROD_LOADER%'" sysdate-4 sysdate
--@ash/ashtoph sql_id "event like 'direct path % temp' --and username like 'EDW_PROD_LOADER%'" sysdate-4 sysdate

--@ash/ashtoph event,event2 "wait_class='User I/O' " sysdate-4 sysdate

--@ash/ashtoph sql_id,object_name,sql_plan_operation,sql_plan_options "event like 'direct path % temp' and username like 'EDW_PROD_LOADER%'" sysdate-5 sysdate
--@ash/ashtoph sql_id,object_name,sql_plan_operation,sql_plan_options "event like 'direct path % temp' -- and username like 'EDW_PROD_LOADER%'" sysdate-5 sysdate
--@ash/ashtoph sql_id "event like 'direct path write temp' and username like 'EDW_PROD_LOADER%'" sysdate-5 sysdate
--@ash/ashtoph username "event like 'direct path % temp' -- and username like 'EDW_PROD_LOADER%'" sysdate-5 sysdate
--From the preceding output, using the data in P1 and P2, the related object information could be obtained using
--the following query:
/*
SELECT segment_name
FROM dba_extents
WHERE file_id = &file
AND &block BETWEEN block_id AND block_id + blocks - 1
AND ROWNUM = 1;
*/


COL "%This" FOR A7
--COL p1     FOR 99999999999999
--COL p2     FOR 99999999999999
--COL p3     FOR 99999999999999
COL p1text              FOR A30 word_wrap
COL p2text              FOR A30 word_wrap
COL p3text              FOR A30 word_wrap
COL p1hex               FOR A17
COL p2hex               FOR A17
COL p3hex               FOR A17
COL AAS                 FOR 999.9
COL totalseconds HEAD "Tot|Sec" FOR 999999
COL dist_sqlexec_seen HEAD "Dis|tin|ct|Execs|Seen" FOR 999999
COL event               FOR A25 TRUNCATE
COL EVENT2              FOR A25 TRUNCATE
COL time_model_name     FOR A15 TRUNCATE
COL program2            FOR A40 TRUNCATE
COL username            FOR A15 TRUNCATE
col owner 				FOR A15 TRUNCATE
COL sql_text 			FOR A15 TRUNCATE
COL obj                 FOR A30 TRUNCATE
COL objt                FOR A40 truncate
col object_name 		FOR A40 truncate
COL sql_opname          FOR A20
COL top_level_call_name FOR A30
COL wait_class          FOR A15
COL machine 			FOR A25 TRUNCATE
COL program 			FOR A20 TRUNCATE
COL module 				FOR A12 TRUNCATE
COL awr_info			FOR A20 TRUNCATE 
COL instance_number 			HEAD "Inst|ID" FOR 99 
col plsql_entry_object_id HEAD "PLSQL|ENT|OBJ|ID" FOR 999999
col plsql_entry_subprogram_id HEAD "PLSQL|ENT|SUBP|ID" FOR 9999
col plsql_object_id HEAD "PLSQL|OBJ|ID" FOR 999999
col sid 				FOR 9999
col serial 				FOR 99999
col sql_child_number heading 'Child#' for 99
col sql_plan_operation for a15 truncate 
col sql_plan_options for a15 truncate 
set lines 300
set pages 10000
set verify off


select inst_id, cpu_count, AAS, case when AAS < cpu_count then 'OK' when AAS = cpu_count then 'WARNING' else 'CRITICAL' end status from (
select instance_number inst_id, ( select to_number(value) cpu_count from gv$parameter
                 where name='cpu_count' and inst_id=a.instance_number) cpu_count,
ROUND(10*COUNT(*) / ((CAST(&4 AS DATE) - CAST(&3 AS DATE)) * 86400), 1) AAS from 
DBA_HIST_ACTIVE_SESS_HISTORY a
where sample_time BETWEEN &3 AND &4
group by instance_number);


select max(AAS) from (
select instance_number inst_id, ( select to_number(value) cpu_count from gv$parameter
                 where name='cpu_count' and inst_id=a.instance_number) cpu_count,
TO_CHAR(sample_time,'YYYY-MM-DD HH24'),
ROUND(10*COUNT(*) / ((CAST(&4 AS DATE) - CAST(&3 AS DATE)) * 86400), 1) AAS from 
DBA_HIST_ACTIVE_SESS_HISTORY a
where sample_time BETWEEN &3 AND &4
group by instance_number,TO_CHAR(sample_time,'YYYY-MM-DD HH24'));


SELECT
    h.*--, (select sql_text from dba_hist_sqltext s where s.sql_id = h.sql_id) sql_text--,
	--(select name from v$services a where a.NAME_HASH=SERVICE_HASH) service_name
	/*(select 'Execs: '||round(sum(executions_delta))||', rows processed: '||round(sum(rows_processed_delta))||', total secs: '||round(sum(elapsed_time_delta)/1e6)
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
           and ss.instance_number = stat.instance_number
		   and ss.begin_interval_time >= &3
		   and ss.end_interval_time <= &4
           and stat.snap_id = ss.snap_id
		   and stat.executions_total > 0
           and stat.dbid = (select dbid from v$database)
           and stat.sql_id =  h.sql_id) awr_info*/
FROM (
    WITH bclass AS (SELECT class, ROWNUM r from v$waitstat)
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)*10                                                     totalseconds
      , ROUND(10*(COUNT(*) / ((CAST(&4 AS DATE) - CAST(&3 AS DATE)) * 86400)), 1) AAS
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , &1
      , TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') first_seen
      , TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') last_seen
	  --, time_model_name
	  --, program
	  --,sid
	  --,serial
	  --, machine
	  --, module
--    , MAX(sql_exec_id) - MIN(sql_exec_id) 
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
	  --, event2
	  --, instance_number as inst_id
	  --, objt
    FROM
        (SELECT
             a.*
           , session_id sid
           , session_serial# serial
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p1 ELSE null END, '0XXXXXXXXXXXXXXX') p1hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p2 ELSE null END, '0XXXXXXXXXXXXXXX') p2hex
           , TO_CHAR(CASE WHEN session_state = 'WAITING' THEN p3 ELSE null END, '0XXXXXXXXXXXXXXX') p3hex
           , NVL(event, session_state)||
                CASE 
                    WHEN event like 'enq%' AND session_state = 'WAITING'
                    THEN ' [mode='||BITAND(p1, POWER(2,14)-1)||']'
                    WHEN a.event IN (SELECT name FROM v$event_name WHERE parameter3 = 'class#')
                    THEN ' ['||CASE WHEN a.p3 <= (SELECT MAX(r) FROM bclass) 
                               THEN (SELECT class FROM bclass WHERE r = a.p3)
                               ELSE (SELECT DECODE(MOD(BITAND(a.p3,TO_NUMBER('FFFF','XXXX')) - 17,2),0,'undo header',1,'undo data', 'error') FROM dual)
                               END  ||']' 
                    ELSE null 
                END event2 -- event is NULL in ASH if the session is not waiting (session_state = ON CPU)
           , CASE WHEN a.session_type = 'BACKGROUND' OR REGEXP_LIKE(a.program, '.*\([PJ]\d+\)') THEN
                REGEXP_REPLACE(SUBSTR(a.program,INSTR(a.program,'(')), '\d', 'n')
             ELSE
                '('||REGEXP_REPLACE(REGEXP_REPLACE(a.program, '(.*)@(.*)(\(.*\))', '\1'), '\d', 'n')||')'
             END || ' ' program2
           , CASE WHEN BITAND(time_model, POWER(2, 01)) = POWER(2, 01) THEN 'DBTIME '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 02)) = POWER(2, 02) THEN 'BACKGROUND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 03)) = POWER(2, 03) THEN 'CONNECTION_MGMT '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 04)) = POWER(2, 04) THEN 'PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 05)) = POWER(2, 05) THEN 'FAILED_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 06)) = POWER(2, 06) THEN 'NOMEM_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 07)) = POWER(2, 07) THEN 'HARD_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 08)) = POWER(2, 08) THEN 'NO_SHARERS_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 09)) = POWER(2, 09) THEN 'BIND_MISMATCH_PARSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 10)) = POWER(2, 10) THEN 'SQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 11)) = POWER(2, 11) THEN 'PLSQL_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 12)) = POWER(2, 12) THEN 'PLSQL_RPC '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 13)) = POWER(2, 13) THEN 'PLSQL_COMPILATION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 14)) = POWER(2, 14) THEN 'JAVA_EXECUTION '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 15)) = POWER(2, 15) THEN 'BIND '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 16)) = POWER(2, 16) THEN 'CURSOR_CLOSE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 17)) = POWER(2, 17) THEN 'SEQUENCE_LOAD '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 18)) = POWER(2, 18) THEN 'INMEMORY_QUERY '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 19)) = POWER(2, 19) THEN 'INMEMORY_POPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 20)) = POWER(2, 20) THEN 'INMEMORY_PREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 21)) = POWER(2, 21) THEN 'INMEMORY_REPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 22)) = POWER(2, 22) THEN 'INMEMORY_TREPOPULATE '  END
           ||CASE WHEN BITAND(time_model, POWER(2, 23)) = POWER(2, 23) THEN 'TABLESPACE_ENCRYPTION ' END time_model_name 
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
      , dba_users u
      , (SELECT
             object_id,data_object_id,owner,object_name,subobject_name,object_type
           , owner||'.'||object_name obj
           , owner||'.'||object_name||' ['||object_type||']' objt
         FROM dba_objects) o
    WHERE
        a.user_id = u.user_id (+)
    AND a.current_obj# = o.object_id(+)
    AND &2
    AND sample_time BETWEEN &3 AND &4
    GROUP BY
        &1--, event2, --instance_number, objt, time_model_name
    ORDER BY
        TotalSeconds DESC
       , &1
) h
WHERE
    ROWNUM <= 15
/