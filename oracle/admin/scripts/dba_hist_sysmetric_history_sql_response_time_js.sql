/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  dba_hist_sysmetric_history_sql_response_time_js.sql v1.0
-- Purpose:    
-- Usage:       
--     @dba_hist_sysmetric_history_sql_response_time_js <lastNminutes>
--
-- Example:
--     Last hour
--     @dba_hist_sysmetric_history_sql_response_time_js 60
*/

set lines 100
set pages 1000
set trimout on
set tab off
set feed off
set verify off



COLUMN avgplusstddev NEW_VALUE _avgplusstddev NOPRINT
COLUMN avg_standard_deviation NEW_VALUE _standard_deviation NOPRINT
COLUMN Average NEW_VALUE _Average NOPRINT


with ucpsec
as
(select avg(average - STANDARD_DEVIATION ) m1,
        avg(average +  STANDARD_DEVIATION ) m2
from dba_hist_sysmetric_summary
where metric_name='User Calls Per Sec'
)
select avg(a.average) "Average",
       avg(a.average + a.STANDARD_DEVIATION)  "avgplusstddev",
	   avg(a.STANDARD_DEVIATION) avg_standard_deviation
from dba_hist_sysmetric_summary a,
dba_hist_sysmetric_summary b,
ucpsec e
where a.metric_name='SQL Service Response Time'
and b.metric_name='User Calls Per Sec'
and a.snap_id = b.snap_id
and b.average between e.m1 and e.m2
/


set serveroutput on

declare

avg_hist number;
avgplusstddev number;

CURSOR cursorValue IS 
(select to_char(begin_time,'YYYY-MM-DD HH24:MI') begin_time, value value, &_Average as avg_hist, &_standard_deviation stddev, &_avgplusstddev avgplusstddev, round(value/&_standard_deviation,1) timesplusstddev
 from dba_hist_sysmetric_history
 where 
 (begin_time > SYSDATE - INTERVAL '&1' MINUTE  and begin_time < (select min(begin_time) from gv$sysmetric_history))
 and METRIC_NAME in ('SQL Service Response Time')
union all
select to_char(begin_time,'YYYY-MM-DD HH24:MI') btime,
 value, &_Average as avg_hist, &_standard_deviation stddev, &_avgplusstddev avgplusstddev, round(value/&_standard_deviation,1) timesplusstddev
 from gv$sysmetric_history
 where 
 begin_time > SYSDATE - INTERVAL '&1' MINUTE
 and METRIC_NAME in ('SQL Service Response Time')
)
 ORDER BY 1
;

begin
dbms_output.put_line('<script>');

dbms_output.put_line('function newDate(daytime) {');
dbms_output.put_line('return moment(daytime).toDate();');
dbms_output.put_line('}');

dbms_output.put_line('var color = Chart.helpers.color;');

dbms_output.put_line('var config4 = {'); --Begin var config
dbms_output.put_line('	type: ''bar'',');
dbms_output.put_line('	data: {');  --Begin data
dbms_output.put_line('		datasets: [');  --Begin datasets

--dbms_output.put_line('var data_ds1 = [');

FOR r IN cursorValue LOOP

avg_hist:=r.avg_hist;
avgplusstddev:=r.avgplusstddev;

if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 1 SQL Service Response Time
dbms_output.put_line('			label: ''SQL Service Response Time'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.red,');
dbms_output.put_line('			borderWidth: 0,');
dbms_output.put_line('			data: ['); --Begin data withing dataset 1
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.begin_time||'''),');
dbms_output.put_line	('y: '||r.value);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 1
dbms_output.put_line	('}'); --End dataset 1


dbms_output.put_line(']'); --End datasets
dbms_output.put_line('},'); --End data
dbms_output.put_line('	options: {');
dbms_output.put_line('		responsive: true,');
dbms_output.put_line('annotation: {');
dbms_output.put_line('drawTime: ''afterDatasetsDraw'',');
dbms_output.put_line('						annotations: [{');
dbms_output.put_line('							type: ''line'',');
dbms_output.put_line('							mode: ''horizontal'',');
dbms_output.put_line('							scaleID: ''y-axis-0'',');
dbms_output.put_line('							value: '||avg_hist||',');
dbms_output.put_line('							borderColor: window.chartColors.green,');
dbms_output.put_line('							borderWidth: 1,');
dbms_output.put_line('							label: {');
dbms_output.put_line('								enabled: true,');
dbms_output.put_line('								content: ''average''');
dbms_output.put_line('							}');
dbms_output.put_line('						},');
dbms_output.put_line(' {');
dbms_output.put_line('							type: ''line'',');
dbms_output.put_line('							mode: ''horizontal'',');
dbms_output.put_line('							scaleID: ''y-axis-0'',');
dbms_output.put_line('							value: '||avgplusstddev||',');
dbms_output.put_line('							borderColor: window.chartColors.red,');
dbms_output.put_line('							borderWidth: 1,');
dbms_output.put_line('							label: {');
dbms_output.put_line('								enabled: true,');
dbms_output.put_line('								content: ''avg plus stddev''');
dbms_output.put_line('							}');
dbms_output.put_line('						}]');
dbms_output.put_line('		},');
dbms_output.put_line('		legend: {');
dbms_output.put_line('			display: false');
dbms_output.put_line('		},');
dbms_output.put_line('		title: {');
dbms_output.put_line('			display: true,');
dbms_output.put_line('			text: ''SQL Service Response Time for last &1 minutes''');
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
dbms_output.put_line('				scaleLabel: {');
dbms_output.put_line('					display: true,');
dbms_output.put_line('					labelString: ''centisecs''');
dbms_output.put_line('				}');
dbms_output.put_line('			}]');
dbms_output.put_line('		}');
dbms_output.put_line('	}');
dbms_output.put_line('};');
dbms_output.put_line('</script>');
end;
/
