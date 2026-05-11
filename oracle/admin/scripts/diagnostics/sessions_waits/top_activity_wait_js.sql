/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  top_activity_wait.sql v1.0
-- Purpose:    Script To Get Cpu Usage And Wait Event Information In Oracle Database
-- Usage:       
--     @top_activity_wait_js <lastNminutes>
--
-- Example:
--     Last hour
--     @top_activity_wait_js 60
*/

set lines 100
set pages 1000
set trimout on
set tab off
set feed off

set serveroutput on

declare

cpu_cnt number;

CURSOR cursorValue IS 
select * from (
SELECT TO_CHAR(SAMPLE_TIME, 'YYYY-MM-DD HH24:MI') AS SAMPLE_TIME,
	   ROUND((OTHER*10) / 60, 3) AS OTHER,
       ROUND((CLUST*10) / 60, 3) AS CLUST,
       ROUND((QUEUEING*10) / 60, 3) AS QUEUEING,
       ROUND((NETWORK*10) / 60, 3) AS NETWORK,
       ROUND((ADMINISTRATIVE*10) / 60, 3) AS ADMINISTRATIVE,
       ROUND((CONFIGURATION*10) / 60, 3) AS CONFIGURATION,
       ROUND((COMMIT*10) / 60, 3) AS COMMIT,
       ROUND((APPLICATION*10) / 60, 3) AS APPLICATION,
       ROUND((CONCURRENCY*10) / 60, 3) AS CONCURRENCY,
       ROUND((SIO*10) / 60, 3) AS SYSTEM_IO,
       ROUND((UIO*10) / 60, 3) AS USER_IO,
       ROUND((SCHEDULER*10) / 60, 3) AS SCHEDULER,
       ROUND((CPU*10) / 60, 3) AS CPU,
       ROUND((BCPU*10) / 60, 3) AS BACKGROUND_CPU--,
	   /*(
			(SELECT (count(*)*10)/60 FROM DBA_HIST_ACTIVE_SESS_HISTORY where  
			TO_CHAR(SAMPLE_TIME, 'DD-MON-YY HH24:MI') = TO_CHAR(ASH.SAMPLE_TIME, 'DD-MON-YY HH24:MI') and session_type = 'FOREGROUND' )
		) as AAS --DB Time*/
		,
		(select value  from v$parameter
where name='cpu_count') as CPU_CNT
  FROM (SELECT TRUNC(SAMPLE_TIME, 'MI') AS SAMPLE_TIME,
               DECODE(SESSION_STATE,
                      'ON CPU',
                      DECODE(SESSION_TYPE, 'BACKGROUND', 'BCPU', 'ON CPU'),
                      WAIT_CLASS) AS WAIT_CLASS
          FROM DBA_HIST_ACTIVE_SESS_HISTORY
         WHERE SAMPLE_TIME > SYSDATE - INTERVAL '&1' MINUTE and sample_time < (select min(sample_time) from gv$active_session_history)
           ) ASH PIVOT(COUNT(*) 
  FOR WAIT_CLASS IN('ON CPU' AS CPU,'BCPU' AS BCPU,
'Scheduler' AS SCHEDULER,
'User I/O' AS UIO,
'System I/O' AS SIO, 
'Concurrency' AS CONCURRENCY,                                                                               
'Application' AS  APPLICATION,                                                                                  
'Commit' AS  COMMIT,                                                                             
'Configuration' AS CONFIGURATION,                     
'Administrative' AS   ADMINISTRATIVE,                                                                                 
'Network' AS  NETWORK,                                                                                 
'Queueing' AS   QUEUEING,                                                                                  
'Cluster' AS   CLUST,                                                                                      
'Other' AS  OTHER)) ASH
union all
SELECT TO_CHAR(SAMPLE_TIME, 'YYYY-MM-DD HH24:MI') AS SAMPLE_TIME,
	   ROUND(OTHER / 60, 3) AS OTHER,
       ROUND(CLUST / 60, 3) AS CLUST,
       ROUND(QUEUEING / 60, 3) AS QUEUEING,
       ROUND(NETWORK / 60, 3) AS NETWORK,
       ROUND(ADMINISTRATIVE / 60, 3) AS ADMINISTRATIVE,
       ROUND(CONFIGURATION / 60, 3) AS CONFIGURATION,
       ROUND(COMMIT / 60, 3) AS COMMIT,
       ROUND(APPLICATION / 60, 3) AS APPLICATION,
       ROUND(CONCURRENCY / 60, 3) AS CONCURRENCY,
       ROUND(SIO / 60, 3) AS SYSTEM_IO,
       ROUND(UIO / 60, 3) AS USER_IO,
       ROUND(SCHEDULER / 60, 3) AS SCHEDULER,
       ROUND(CPU / 60, 3) AS CPU,
       ROUND(BCPU / 60, 3) AS BACKGROUND_CPU,
		/*(SELECT count(*)/60 FROM gv$active_session_history a where  
			TO_CHAR(SAMPLE_TIME, 'DD-MON-YY HH24:MI') = TO_CHAR(ASH.SAMPLE_TIME, 'DD-MON-YY HH24:MI') and session_type = 'FOREGROUND'
		) as AAS,*/
		(select value  from v$parameter
where name='cpu_count') as CPU_CNT
  FROM (SELECT TRUNC(SAMPLE_TIME, 'MI') AS SAMPLE_TIME,
               DECODE(SESSION_STATE,
                      'ON CPU',
                      DECODE(SESSION_TYPE, 'BACKGROUND', 'BCPU', 'ON CPU'),
                      WAIT_CLASS) AS WAIT_CLASS
          FROM gv$active_session_history
         WHERE (SAMPLE_TIME > SYSDATE - INTERVAL '&1' MINUTE)) ASH PIVOT(COUNT(*) 
  FOR WAIT_CLASS IN(
 'ON CPU' AS CPU,'BCPU' AS BCPU,
'Scheduler' AS SCHEDULER,
'User I/O' AS UIO,
'System I/O' AS SIO, 
'Concurrency' AS CONCURRENCY,                                                                               
'Application' AS  APPLICATION,                                                                                  
'Commit' AS  COMMIT,                                                                             
'Configuration' AS CONFIGURATION,                     
'Administrative' AS   ADMINISTRATIVE,                                                                                 
'Network' AS  NETWORK,                                                                                 
'Queueing' AS   QUEUEING,                                                                                  
'Cluster' AS   CLUST,                                                                                      
'Other' AS  OTHER)) ASH
)
order by 1;

begin
dbms_output.put_line('<script>');

dbms_output.put_line('function newDate(daytime) {');
dbms_output.put_line('return moment(daytime).toDate();');
dbms_output.put_line('}');

dbms_output.put_line('function newDateString(days) {');
dbms_output.put_line('return moment(''2020-04-05 20:30'').add(days, ''d'').format();');
dbms_output.put_line('}');
dbms_output.put_line('var color = Chart.helpers.color;');

dbms_output.put_line('var config = {'); --Begin var config
dbms_output.put_line('	type: ''line'',');
dbms_output.put_line('	data: {');  --Begin data
dbms_output.put_line('		datasets: [');  --Begin datasets

--dbms_output.put_line('var data_ds1 = [');

FOR r IN cursorValue LOOP

cpu_cnt:=to_number(r.cpu_cnt);

if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 1 CPU
dbms_output.put_line('			label: ''CPU'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.green,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''origin'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: ['); --Begin data withing dataset 1
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.cpu);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 1
dbms_output.put_line	('},'); --End dataset 1

FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 2 User IO 
dbms_output.put_line('			label: ''User IO '',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.blue,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 2
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.user_io);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 2
dbms_output.put_line	('},'); --End dataset 2

FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 3 SCHEDULER 
dbms_output.put_line('			label: ''Scheduler'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.red,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 3
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.scheduler);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 3
dbms_output.put_line	('},'); --End dataset 3


FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 4 CONCURRENCY
dbms_output.put_line('			label: ''Concurrency'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.purple).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.purple,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 4
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.concurrency);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 4
dbms_output.put_line	('},'); --End dataset 4


FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 5 APPLICATION
dbms_output.put_line('			label: ''Application'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.yellow).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.yellow,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 5
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.application);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 5
dbms_output.put_line	('},'); --End dataset 5


FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 6 COMMIT
dbms_output.put_line('			label: ''Commit'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.gold).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.gold,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 6
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.commit);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 6
dbms_output.put_line	('},'); --End dataset 6

FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 7 CONFIGURATION
dbms_output.put_line('			label: ''Configuration'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.olive).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.olive,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 7
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.configuration);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 7
dbms_output.put_line	('},'); --End dataset 7

FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 8 ADMINISTRATIVE
dbms_output.put_line('			label: ''Administrative'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.orange).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.orange,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 8
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.administrative);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 8
dbms_output.put_line	('},'); --End dataset 8



FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 9 NETWORK
dbms_output.put_line('			label: ''Network'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.magenta).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.magenta,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 9
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.NETWORK);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 9
dbms_output.put_line	('},'); --End dataset 9


FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 10 QUEUEING
dbms_output.put_line('			label: ''Queueing'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.orange).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.orange,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 9
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.queueing);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 10
dbms_output.put_line	('},'); --End dataset 10


FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 11 CLUST
dbms_output.put_line('			label: ''Cluster'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.maroon).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.maroon,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 9
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.clust);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 11
dbms_output.put_line	('},'); --End dataset 11


FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 12 Other
dbms_output.put_line('			label: ''Other'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.silver).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.silver,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 9
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.Other);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 12
dbms_output.put_line	('},'); --End dataset 12


FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 13 SYSTEM_IO
dbms_output.put_line('			label: ''System IO'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.mediumblue).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.mediumblue,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 13
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.system_io);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 13
dbms_output.put_line	('},'); --End dataset 13

FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 14 BACKGROUND_CPU
dbms_output.put_line('			label: ''Background CPU'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.deepskyblue).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.deepskyblue,');
dbms_output.put_line('			borderWidth:1,');
dbms_output.put_line('			pointRadius: 1,');
dbms_output.put_line('			fill: ''-1'',');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 14
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.background_cpu);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 14
dbms_output.put_line	('}'); --End dataset 14
dbms_output.put_line(']'); --End datasets
dbms_output.put_line('},'); --End data
dbms_output.put_line('	options: {');
dbms_output.put_line('		responsive: true,');
dbms_output.put_line('		title: {');
dbms_output.put_line('			display: true,');
dbms_output.put_line('			text: ''Top activity by wait''');
dbms_output.put_line('		},');
dbms_output.put_line('		legend: {');
dbms_output.put_line('			position: ''right''');
dbms_output.put_line('		},');
dbms_output.put_line('		scales: {');
dbms_output.put_line('			xAxes: [{');
dbms_output.put_line('				type: ''time'',');
dbms_output.put_line('				display: true,');
dbms_output.put_line('				scaleLabel: {');
dbms_output.put_line('					display: true,');
dbms_output.put_line('					labelString: ''Date''');
dbms_output.put_line('				},');
dbms_output.put_line('				ticks: {');
dbms_output.put_line('					major: {');
dbms_output.put_line('						fontStyle: ''bold'',');
dbms_output.put_line('						fontColor: ''#FF0000''');
dbms_output.put_line('					}');
dbms_output.put_line('				}');
dbms_output.put_line('			}],');
dbms_output.put_line('			yAxes: [{');
dbms_output.put_line('				display: true,');
dbms_output.put_line('				stacked: true,');
dbms_output.put_line('				ticks: {');
dbms_output.put_line('				 suggestedMax: '||cpu_cnt);
dbms_output.put_line('				},');
dbms_output.put_line('				scaleLabel: {');
dbms_output.put_line('					display: true,');
dbms_output.put_line('					labelString: ''value''');
dbms_output.put_line('				}');
dbms_output.put_line('			}]');
dbms_output.put_line('		}');
dbms_output.put_line('	}');
dbms_output.put_line('};');
dbms_output.put_line('</script>');
end;
/
