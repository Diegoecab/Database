/*
--
--------------------------------------------------------------------------------
-- 
-- File name:  dba_hist_sysmetric_summary_cpu_js.sql v1.0
-- Purpose:    
-- Usage:       
--     @dba_hist_sysmetric_summary_js <lastNminutes>
--
-- Example:
--     Last hour
--     @dba_hist_sysmetric_summary_js 60
*/

set lines 100
set pages 1000
set trimout on
set tab off
set feed off
set verify off

set serveroutput on

declare

CURSOR cursorValue IS
select to_char(b.b_sample_time,'YYYY-MM-DD HH24:MI') sample_time, b.* from (
select to_date(to_char(begin_time,'YYYY-MM-DD HH24:MI'),'YYYY-MM-DD HH24:MI') as b_sample_time,
       (sum(case metric_name when 'Physical Read Total Bytes Per Sec' then value end))/1024/1024 Physical_Read_Total_MBps,
       (sum(case metric_name when 'Physical Write Total Bytes Per Sec' then value end))/1024/1024 Physical_Write_Total_MBps,
       (sum(case metric_name when 'Redo Generated Per Sec' then value end))/1024/1024 Redo_MBytes_per_sec,
       sum(case metric_name when 'Physical Read Total IO Requests Per Sec' then value end) Physical_Read_IOPS,
       sum(case metric_name when 'Physical Write Total IO Requests Per Sec' then value end) Physical_write_IOPS,
       sum(case metric_name when 'Redo Writes Per Sec' then value end) Physical_redo_IOPS,
       sum(case metric_name when 'Current OS Load' then value end) OS_LOad,
	   sum(case metric_name when 'Database Time Per Sec' then value end) Database_Time_Per_Sec,
       sum(case metric_name when 'CPU Usage Per Sec' then value end) DB_CPU_Usage_per_sec,
       sum(case metric_name when 'Host CPU Utilization (%)' then value end) Host_CPU_util, --NOTE 100% = 1 loaded RAC node
       (sum(case metric_name when 'Network Traffic Volume Per Sec' then value end))/1024/1024 Network_Mbytes_per_sec,
	   sum(case metric_name when 'Logons Per Sec' then value end) Logons_Per_Sec
from v$sysmetric_history
where begin_time > SYSDATE - INTERVAL '&1' MINUTE
group by to_date(to_char(begin_time,'YYYY-MM-DD HH24:MI'),'YYYY-MM-DD HH24:MI')
order by 1) b
where (
Physical_Read_Total_MBps is not null
and Physical_Write_Total_MBps is not null
and Redo_MBytes_per_sec is not null
and Physical_Read_IOPS is not null
and Physical_write_IOPS is not null
and Physical_redo_IOPS is not null
and OS_LOad is not null
and Database_Time_Per_Sec is not null
and DB_CPU_Usage_per_sec is not null
and Host_CPU_util is not null
and Network_Mbytes_per_sec is not null
and Logons_Per_Sec is not null)
;

begin
dbms_output.put_line('<script>');

dbms_output.put_line('function newDate(daytime) {');
dbms_output.put_line('return moment(daytime).toDate();');
dbms_output.put_line('}');

dbms_output.put_line('var color = Chart.helpers.color;');

dbms_output.put_line('var config2 = {'); --Begin var config
dbms_output.put_line('	type: ''line'',');
dbms_output.put_line('	data: {');  --Begin data
dbms_output.put_line('		datasets: [');  --Begin datasets

--dbms_output.put_line('var data_ds1 = [');

FOR r IN cursorValue LOOP

if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 1 DB_CPU_Usage_per_sec
dbms_output.put_line('			label: ''DB CPU Usage per sec'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.green,');
dbms_output.put_line('			fill: false,');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: ['); --Begin data withing dataset 1
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.db_cpu_usage_per_sec);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 1
dbms_output.put_line	('},'); --End dataset 1

FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 2 Database_Time_Per_Sec
dbms_output.put_line('			label: ''DB Time Per Sec'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.blue,');
dbms_output.put_line('			fill: false,');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 2
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.Database_Time_Per_Sec);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 2
dbms_output.put_line	('},'); --End dataset 2

FOR r IN cursorValue LOOP
if cursorValue%ROWCOUNT = 1 then 
dbms_output.put_line	('{'); --Begin dataset 14 Host_CPU_util %
dbms_output.put_line('			label: ''Host CPU util'',');
dbms_output.put_line('			backgroundColor: color(window.chartColors.deepskyblue).alpha(0.5).rgbString(),');
dbms_output.put_line('			borderColor: window.chartColors.deepskyblue,');
dbms_output.put_line('			fill: false,');
dbms_output.put_line('		lineTension: 0,');
dbms_output.put_line('			data: [');--Begin data withing dataset 14
dbms_output.put_line('			{'); --Begin list of data
else
dbms_output.put_line	(',{');--Begin list of data
end if;
dbms_output.put_line	('x: newDate('''||r.sample_time||'''),');
dbms_output.put_line	('y: '||r.Host_CPU_util);
dbms_output.put_line	('}');--End list of data
END LOOP;
dbms_output.put_line(']'); -- End data withing dataset 14
dbms_output.put_line	('}'); --End dataset 14


dbms_output.put_line('],'); --End datasets
dbms_output.put_line('},'); --End data
dbms_output.put_line('	options: {');
dbms_output.put_line('		responsive: true,');
dbms_output.put_line('		legend: {');
dbms_output.put_line('			position: ''right''');
dbms_output.put_line('		},');
dbms_output.put_line('		title: {');
dbms_output.put_line('			display: true,');
dbms_output.put_line('			text: ''System Metrics for last &1 minutes''');
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
dbms_output.put_line('					labelString: ''value''');
dbms_output.put_line('				}');
dbms_output.put_line('			}]');
dbms_output.put_line('		}');
dbms_output.put_line('	}');
dbms_output.put_line('};');
dbms_output.put_line('</script>');
end;
/
