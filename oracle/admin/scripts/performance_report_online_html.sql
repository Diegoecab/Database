-- +----------------------------------------------------------------------------+
-- |                          Diego Cabrera	                                    |
-- |                      diego.ecab@gmail.com	                                |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 2020 Diego Cabrera	   . All rights reserved.       	|
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : performance_report_online_html.sql                            	|
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : This SQL script provides a detailed report (in HTML format) on  |
-- | VERSION  :                         										|
-- | USAGE    :                                                                 |
-- |                                                                            |
-- |sqlplus -s <dba>/<password> @performance_report_online_html.sql <minutes> <html_file_name>  			|
-- |                                                                            |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- |                                                                            |
-- |REQUIREMENTS:                                                               |
-- | top_activity_wait_js                                                       |
-- | top_activity_wait                                                          |
-- | active_session_history_wait                                              |
-- | dba_hist_sysmetric_summary_cpu_js                                          |
-- | dba_hist_sysmetric_summary_io_js                                           |
-- | dba_hist_sysmetric_all                                                     |
-- | ash\ashtop                                                                 |
-- | sessions_db_active                                                         |
-- | plan_change                                                                |
-- | diag_alert_ext.sql                                                       |
-- | sessions_locks                                                             |
-- | dc_perf_report_sqlid                                                       |
-- | report_sql_monitor_sqlid                                                   |
-- | dba_hist_snapshot_sqlid                                                    |
-- | plan_table_sqlid                                                           |
-- | plan_table_awr_sqlid                                                       |
-- | sql.sql                                                                      |
-- | sql_sqltext.sql															|
-- | dba_hist_sysmetric_history_sql_response_time								|
-- | sysmetric_history_sql_response_time										|
-- | dba_hist_sysmetric_history_sql_response_time_js							|
-- | ----------------------------------------------------------------------------+
--


-- +----------------------------------------------------------------------------+
-- |                   VAR								                        |
-- +----------------------------------------------------------------------------+

define filen=&2
define minutes=&1
define dba_hist_snapshot_days=120

set pagesize 1000
set feedback off
set heading off
set verify       off
set echo         off
set termout      off

prompt

-- +----------------------------------------------------------------------------+
-- |                   GATHER DATABASE REPORT INFORMATION                       |
-- +----------------------------------------------------------------------------+

COLUMN dbname NEW_VALUE _dbname NOPRINT
COLUMN version NEW_VALUE _version NOPRINT
COLUMN hostname NEW_VALUE _hostname NOPRINT
COLUMN sysdate NEW_VALUE sysdt NOPRINT


SELECT version, host_name hostname  FROM v$instance;
select name dbname from v$database;
SELECT sysdate FROM dual;


clear buffer computes columns breaks

set heading on


spool &filen

prompt <!DOCTYPE html>
prompt <html lang="de" xmlns="http://www.w3.org/1999/xhtml">
prompt   <title>Database performance report for database &_dbname</title> 
prompt <head>
prompt   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
prompt   <link rel="stylesheet" href="..\..\html-resources\bootstrap-4.4.1-dist\css\bootstrap.min.css">
prompt <!--ChartJs -->
prompt <script src="..\..\html-resources\moment.js\2.13.0\moment.min.js"></script>
prompt <script src="..\..\html-resources\Utils\utils.js"></script>
prompt <script src="..\..\html-resources\ChartJs2.9.3\Chart.bundle.js"></script>
prompt <script src="..\..\html-resources\ChartJs2.9.3\chartjs-plugin-annotation.js"></script>
prompt </head>
prompt  <body  class="hold-transition skin-blue sidebar-mini sidebar-collapse fixed bg-light">
  
set markup html off entmap off
prompt <div class="p-1 mb-0 bg-white">
prompt <span class="font-weight-bold"><mark style="color: red;background: transparent; padding-right: 0;">Oracle</mark> Advanced Customer Services</span>
prompt </div>
prompt <div class="p-2 mb-2 bg-dark text-light">
prompt <h3>Database performance report for database &_dbname</h3>
prompt </div>

set markup html off


set heading off
set feedback off


prompt <div class="p-2"> <!--head info-->

prompt <div class="table-responsive">
prompt <table class="table table-sm"><thead><tr><th>Database Version</th><th>Host Name</th><th>Db ID</th><th>DB Name</th><th>scn</th><th>Open Mode</th><th>Force logging</th><th>Database Role</th><th>Log mode</th><th>Archivelog Compression</th><th>Is RAC?</th></tr></thead>
prompt <tbody><tr>
SELECT '<td>'||version||'</td><td>'||host_name||'</td>' FROM v$instance;
select '<td>'||dbid||'</td><td>'||name||'</td><td>'||current_scn||'</td><td>'||open_mode||'</td><td>'||force_logging||'</td><td>'||database_role||'</td><td>'||log_mode||'</td><td>'||archivelog_compression||'</td>'  from v$database;
select '<td>'||value||'</td>' from v$parameter where name='cluster_database';
prompt </tr></tbody>
prompt </table>
prompt </div> <!--End table responsive-->


prompt <div class="table-responsive ">
set markup html on TABLE "class='table table-sm'" ENTMAP OFF
set heading on
set feed off

select * from (
select '*' C, '&sysdt' as "SysTime", instance_number as "Inst#",instance_name as "InstName",host_name as "HostName",version As "Version",startup_time as "Startup Time",status as Status, database_status as "Database Status", (select value from gv$parameter where name='cpu_count' and inst_id=a.instance_number) as "CPU Count"  from v$instance a
union 
select '' C, '' as "SysTime", instance_number as "Inst#",instance_name as "InstName",host_name as "HostName",version As "Version",startup_time as "Startup Time",status as Status, database_status as "Database Status", (select value from gv$parameter where name='cpu_count' and inst_id=b.instance_number) as "CPU Count"  from gv$instance b where instance_number <> (select instance_number from v$instance))
order by 2;

set markup html off
prompt </div> <!--End table responsive-->
prompt </div><!-- end head info-->



prompt <div class="p-3 mb-2">
prompt <h5>Top activity by wait </h5>

set heading on
set markup html off entmap off
prompt <div class="p-3 mb-2">
prompt <canvas id="canvas" class="chartjs-render-monitor"></canvas>
prompt </div>
@top_activity_wait_js &minutes
prompt <a href="&filen..top_activity_wait..txt" target="_blank">View in TXT</a>
spool off
set markup html off
spool &filen..top_activity_wait..txt
@top_activity_wait &minutes
@top_activity_wait_h &minutes
spool off
spool &filen append
prompt </div>



set markup html off
prompt
prompt <div class="p-3 mb-2">
prompt <h5> Waiting sessions for the last &minutes minutes</h5>

set heading on
prompt <div class="table-responsive small">
set markup html on entmap off
@active_session_history_wait &minutes
set markup html off entmap off
prompt </div>
prompt </div>



prompt <div class="p-3 mb-2">
prompt <h5>SQL Service Response time</h5>

set heading on
set markup html off entmap off
prompt <div class="p-3 mb-2">
prompt <canvas id="canvas_resptime" class="chartjs-render-monitor"></canvas>
prompt </div>
@dba_hist_sysmetric_history_sql_response_time_js &minutes
prompt <a href="&filen..dba_hist_sysmetric_history_sql_response_time..txt" target="_blank">View in TXT</a>
spool off
set markup html off
spool &filen..dba_hist_sysmetric_history_sql_response_time..txt
@dba_hist_sysmetric_history_sql_response_time &minutes
@sysmetric_history_sql_response_time &minutes
spool off
spool &filen append
prompt </div>



prompt <div class="p-3 mb-2">
prompt <h5>Database System Metrics</h5>

set heading on
set markup html off entmap off
prompt <div class="p-3 mb-2">
prompt <canvas id="canvas_sysmet" class="chartjs-render-monitor"></canvas>
prompt </div>
@dba_hist_sysmetric_summary_cpu_js &minutes

prompt <a href="&filen..dba_hist_sysmetric_all.txt" target="_blank">View in TXT</a>



prompt <div class="p-3 mb-2">
prompt <canvas id="canvas_sysmet_io" class="chartjs-render-monitor"></canvas>
prompt </div>
@dba_hist_sysmetric_summary_io_js &minutes

prompt <a href="&filen..dba_hist_sysmetric_all.txt" target="_blank">View in TXT</a>


spool off
set markup html off
spool &filen..dba_hist_sysmetric_all.txt
--prompt <pre>
@dba_hist_sysmetric_all &minutes
--prompt </pre>
spool off

spool &filen append

prompt </div>




prompt <div class="p-3 mb-2">
prompt <h5> ASH:Top SQL Over Last &minutes Minutes</h5>
set heading on
set feedback off
set markup html off entmap off
prompt <div class="table-responsive small">
set markup html on entmap off
@ash/ashtop username,sql_id session_type='FOREGROUND' "SYSDATE-INTERVAL '&minutes' MINUTE" sysdate
set markup html off entmap off
prompt </div>
prompt </div>


prompt <div class="p-3 mb-2">
prompt <h5> ASH:Top Background consumers over Last &minutes Minutes</h5>

set heading on
set feedback off
set markup html off entmap off
prompt <div class="table-responsive small">
set markup html on entmap off
@ash/ashtop username,sql_id session_type='BACKGROUND' "SYSDATE-INTERVAL '&minutes' MINUTE" sysdate
set markup html off entmap off
prompt </div>
prompt </div>

set feedback on

set markup html off
prompt <div class="p-3 mb-2">
prompt <h5> Current active sessions <small>excluding username SYS</small></h5>
set markup html off entmap off
prompt <div class="table-responsive small">
set markup html on entmap off
set heading on
set feedback off
set markup html on entmap off
@sessions_db_active %%
set markup html off entmap off
prompt </div>
spool off
set markup html off
spool sessions_db_active.txt
--Spool en txt
@sessions_db_active %%
spool off
spool &filen append
prompt </div>



set markup html off

prompt <div class="p-3 mb-2">
prompt<h5>Changed SQL execution plans</h5>

set heading on
set feedback off
set markup html on entmap off
prompt <div class="table-responsive small">
@plan_change 10 600 &minutes
set markup html off entmap off
prompt </div>
spool off
set markup html off
spool plan_change.txt
--Spool en txt
@plan_change 10 600 &minutes
spool off
spool &filen append
prompt </div>


set markup html off

prompt <div class="p-3 mb-2">
prompt<h5> ORA- errors in alert log</h5>

set heading on
set feedback off
set markup html on entmap off
prompt <div class="table-responsive small">
@diag_alert_ext.sql &minutes
set markup html off entmap off
prompt </div>
prompt </div>


set markup html off

prompt <div class="p-3 mb-2">
prompt<h5> Current Sessions locks</h5>

set heading on
set feedback off
set markup html off entmap off
prompt <pre style="max-height: 350px;">
@sessions_locks
prompt </pre>
prompt </div>
spool off
set markup html off
spool sessions_locks.txt
--Spool en txt
@sessions_locks
spool off
spool &filen append



prompt <div class="p-3 mb-2">
prompt <h5>SQL details </h5>


spool off
set markup html off
spool &filen..tmp
@dc_perf_report_sqlid.sql username,sql_id session_type='FOREGROUND' "SYSDATE-INTERVAL '&minutes' MINUTE" sysdate &dba_hist_snapshot_days &filen 600 50 
spool off

@&filen..tmp

spool &filen append

prompt </div>

set markup html off

prompt <script>
prompt window.onload = function() {
prompt var ctx = document.getElementById('canvas').getContext('2d')
prompt window.myLine = new Chart(ctx, config)
prompt var ctx2 = document.getElementById('canvas_sysmet').getContext('2d')
prompt window.myLine2 = new Chart(ctx2, config2)
prompt var ctx3 = document.getElementById('canvas_sysmet_io').getContext('2d')
prompt window.myLine3 = new Chart(ctx3, config3)
prompt var ctx4 = document.getElementById('canvas_resptime').getContext('2d')
prompt window.myLine4 = new Chart(ctx4, config4)
prompt }
prompt </script>

prompt <footer class="my-5 pt-5 text-muted text-center text-small">
prompt     <p class="mb-1">End of report</p>
prompt     <ul class="list-inline">
prompt       <!--<li class="list-inline-item"><a href="#">Privacy</a></li>-->
prompt       <li class="list-inline-item"><a href="#">About</a></li>
prompt       <li class="list-inline-item"><a href="#">Support</a></li>
prompt     </ul>
prompt   </footer>
  
prompt </body>
prompt </html>

spool off
set markup html off
set termout on
clear buffer computes columns breaks
exit