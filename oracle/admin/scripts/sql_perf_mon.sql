REM SQL Performance monitoring
REM ======================================================================
REM sql_perf_mon.sql        Version 1.1    26 Enero 2011
REM
REM Author:
REM Diego Cabrera
REM
REM Proposito:
REM
REM Dependences:
REM
REM Notes:
REM    Ejecutar con usuario dba
REM    Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Warning:
REM
REM ======================================================================
REM
SET feedback off
SET term off
SET verify off
HOST del c:\temp\grafic\sql_perf_mon.html
SET serveroutput on
ALTER SESSION SET nls_date_format='dd/mm/yyyy hh24:mi:ss';

--accept narchivo prompt 'Ingrese nombre de archivo a generar con extension html (Ej. c:\check_security.html) :  '

--SPOOL &narchivo rep
SPOOL c:\temp\grafic\sql_perf_mon.html

DECLARE
   vaux     NUMBER         := 0;
   dbname   VARCHAR2 (100);
   countdbs NUMBER		   := 0;
   sizedbs  VARCHAR2 (1000);
   monthdbs  VARCHAR2 (1000);
   monthdbs2 VARCHAR2 (1000);
BEGIN
   SELECT display_value
     INTO dbname
     FROM v$parameter
    WHERE UPPER (NAME) = 'DB_NAME';

   DBMS_OUTPUT.put_line
      (   '
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<title>SQL Performance report : '
       || dbname
       || '   '
       || SYSDATE
       || '</title>
<style type="text/css">

body {font:bold 10pt Arial,Helvetica,Geneva,sans-serif;color:black; background:White;}
h1.sql_perf {font:bold 20pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;border-bottom:1px solid #cccc99;margin-top:0pt; margin-bottom:0pt;padding:0px 0px 0px 0px;}
h2.sql_perf {font:bold 16pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}
h3.sql_perf {font:bold 16pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}

table.infbody {border-width: 0px;border-spacing: 5px;border-style: none;border-color: gray;border-collapse: separate;background-color: white;}
table.infbody th {font:bold 10pt Arial;border-width: 0px;padding: 1px;float:left;border-style: none;border-color: gray;background-color: white;-moz-border-radius: ;}
table.infbody td {font:10pt Arial;border-width: 0px;padding: 1px;border-style: none;border-color: gray;background-color: white;-moz-border-radius: ;}

table.grid {text-align: left; border-width: 2px;border-spacing: 2px;border-style: float;border-color: gray;border-collapse: separate;background-color: white;}
table.grid th {font:bold 8pt Arial,Helvetica,Geneva,sans-serif; color:White; background:#0066CC;padding-left:1px; padding-right:1px;padding-bottom:2px}
table.grid td {align:left; border-width: 1px;padding: 1px;font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;}
table.grid2 td {border-width: 1px;padding: 1px;	border-style: inset;border-color: white;background-color: white;-moz-border-radius: ;}
</style>

   <script src="RGraph.common.core.js" ></script>
    <script src="RGraph.common.context.js" ></script>
    <script src="RGraph.common.annotate.js" ></script>
    <script src="RGraph.common.tooltips.js" ></script>
    <script src="RGraph.common.zoom.js" ></script>
    <script src="RGraph.common.effects.js" ></script>

    <script src="RGraph.common.key.js" ></script>
    <script src="RGraph.line.js" ></script>
    <script src="RGraph.common.key.js" ></script>
    <!--[if lt IE 9]><script src="../excanvas/excanvas.original.js"></script><![endif]-->
    <script src="libraries/jquery.min.js" ></script>');

execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT=''MMYY''';
for t in
(
select to_date(to_char(trunc(book_dt,'mm'),'mm/yyyy'),'mm/yyyy') book_dt, db_sid, round(sum(used_bytes/1024/1024/1024)) Gb
from DBADMIN.DLY_DATABASE_ALLOCATIONS_MVW@DBAREPO
where to_char(trunc(book_dt,'dd'),'dd/mm/yyyy') like '01%' and db_sid='amlpro'
group by to_date(to_char(trunc(book_dt,'mm'),'mm/yyyy'),'mm/yyyy'), db_sid order by 1
)
loop
countdbs := countdbs + 1;
if countdbs = 1 then
sizedbs  := t.Gb;
monthdbs := countdbs;
monthdbs2 := '"'||t.book_dt||'"';
else
sizedbs  := sizedbs||','||t.Gb;
monthdbs := monthdbs||','||countdbs;
monthdbs2 := monthdbs2||',"'||t.book_dt||'"';
end if;
--dbms_output.put_line(sizedbs);
end loop;

dbms_output.put_line ('
  <script>
        window.onload = function ()
        {
            var line1 = new RGraph.Line("line1", ['||sizedbs||']);
            line1.Set("chart.background.grid", true);
            line1.Set("chart.linewidth", 5);
            line1.Set("chart.gutter.left", 35);
            line1.Set("chart.hmargin", 5);

            if (!document.all || RGraph.isIE9up()) {
                line1.Set("chart.shadow", true);
            }
            line1.Set("chart.tickmarks", null);
            line1.Set("chart.units.post", "G");
            line1.Set("chart.colors", ["red", "green"]);
            line1.Set("chart.background.grid.autofit", true);
            line1.Set("chart.background.grid.autofit.numhlines", 10);
            line1.Set("chart.curvy", 1);
            line1.Set("chart.curvy.factor", 0.25);
            line1.Set("chart.labels",['||monthdbs2||']);
            line1.Set("chart.title","Database Growth");
			line1.Set("chart.gutter.right", 60);
			line1.Set("chart.gutter.left", 60);
			
			
			
			
            
            line1.Draw();
        }
    </script>
	
</head>

<body class="sql_perf">'
      );
execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT=''DD/MM/YYYY HH24:MI:SS''';
DBMS_OUTPUT.put_line
      (   '
<h1 class="sql_perf"> SQL Performance Daily report</h1>
<h5>
<table class="infbody"> 
<tr>
<th>Database</th>
<td>'  || dbname || '</td>
</tr>
<tr>
<th>Date</th>
<td>'  || SYSDATE || '</td>
</tr>
</table>

</h5>
<hr>

<a name="top"> </a>

<ul>
<li>Top SQL</li>
<li>Top Events</li>
<li>SQL Plan change</li>
</ul> 

<hr>
');




DBMS_OUTPUT.put_line('SQL Plan change');

DBMS_OUTPUT.put_line('<h3> SQL Plan change in last 3 days');

DBMS_OUTPUT.put_line('
<table class="grid"><tbody>
<th>sqlid</th>
<th>username</th>
<th>count_hash_val</th>
<th>exec_total</th>
<th>first_exec</th>
<th>last_exec</th>
<th>min_time(sec)</th>
<th>max_time(sec)</th>
<th>diff_time(sec)</th>
<th>diff_perc</th>
');

FOR r in
(
select sql_id, username, count_hash_val, exec_total,first_exec, last_exec, 
min_time, max_time, diff_time, decode(min_time,0,100,round((diff_time*100)/max_time)) diff_perc
from (
select s.sql_id,c.username,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
min (begin_interval_time) first_exec, max (begin_interval_time) last_exec,
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) min_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) max_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) -
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) diff_time
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate -3
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and rows_processed_total <> 0 --Excl Canceled
group by s.sql_id,c.username
having count(distinct plan_hash_value) > 1
order by diff_time)
where diff_time <> 0 
and username <> 'SYS'
and
((decode(min_time,0,100,round((diff_time*100)/max_time)) > 50) --Diff time perc 
or diff_time > 10)
)
loop

DBMS_OUTPUT.PUT_LINE('<tr><td><a href="#'||r.sql_id||'">'||r.sql_id||'</a></td><td>'||r.username||'</td><td>'||r.count_hash_val||'</td><td>'||r.exec_total||'</td><td>'||r.first_exec||'</td><td>'||r.last_exec||'</td><td>'||r.min_time||'</td><td>'||r.max_time||'</td><td>'||r.diff_time||'</td><td>'||r.diff_perc||'</td></tr>');

end loop;

DBMS_OUTPUT.put_line ('</tbody></table>');



DBMS_OUTPUT.put_line('<h3> SQL Plan change in last 60 days');

DBMS_OUTPUT.put_line('
<table class="grid"><tbody>
<th>sqlid</th>
<th>username</th>
<th>count_hash_val</th>
<th>exec_total</th>
<th>first_exec</th>
<th>last_exec</th>
<th>min_time(sec)</th>
<th>max_time(sec)</th>
<th>diff_time(sec)</th>
<th>diff_perc</th>
');

FOR r in
(
select sql_id, username, count_hash_val, exec_total,first_exec, last_exec, 
min_time, max_time, diff_time, decode(min_time,0,100,round((diff_time*100)/max_time)) diff_perc
from (
select s.sql_id,c.username,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
min (begin_interval_time) first_exec, max (begin_interval_time) last_exec,
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) min_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) max_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) -
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) diff_time
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate -60
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and rows_processed_total <> 0 --Excl Canceled
group by s.sql_id,c.username
having count(distinct plan_hash_value) > 1
order by diff_time)
where diff_time <> 0 
and username <> 'SYS'
and
(
((decode(min_time,0,100,round((diff_time*100)/max_time)) > 20) and diff_time > 20)--Diff perc
or (diff_time > 0 and exec_total > 100) --Diff time sec
)
)
loop

DBMS_OUTPUT.PUT_LINE('<tr><td><a href="#'||r.sql_id||'">'||r.sql_id||'</a></td><td>'||r.username||'</td><td>'||r.count_hash_val||'</td><td>'||r.exec_total||'</td><td>'||r.first_exec||'</td><td>'||r.last_exec||'</td><td>'||r.min_time||'</td><td>'||r.max_time||'</td><td>'||r.diff_time||'</td><td>'||r.diff_perc||'</td></tr>');

end loop;

DBMS_OUTPUT.put_line ('</tbody></table></h3>');


FOR r in (
select sql_id, username, count_hash_val, exec_total,first_exec, last_exec, 
min_time, max_time, diff_time, decode(min_time,0,100,round((diff_time*100)/max_time)) diff_perc
from (
select s.sql_id,c.username,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
min (begin_interval_time) first_exec, max (begin_interval_time) last_exec,
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) min_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) max_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) -
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) diff_time
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate -3
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and rows_processed_total <> 0 --Excl Canceled
group by s.sql_id,c.username
having count(distinct plan_hash_value) > 1
order by diff_time)
where diff_time <> 0 
and username <> 'SYS'
and
((decode(min_time,0,100,round((diff_time*100)/max_time)) > 50) --Diff time perc 
or diff_time > 10)
union all
select sql_id, username, count_hash_val, exec_total,first_exec, last_exec, 
min_time, max_time, diff_time, decode(min_time,0,100,round((diff_time*100)/max_time)) diff_perc
from (
select s.sql_id,c.username,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
min (begin_interval_time) first_exec, max (begin_interval_time) last_exec,
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) min_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) max_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) -
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) diff_time
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate -60
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and rows_processed_total <> 0 --Excl Canceled
group by s.sql_id,c.username
having count(distinct plan_hash_value) > 1
order by diff_time)
where diff_time <> 0 
and username <> 'SYS'
and
(
((decode(min_time,0,100,round((diff_time*100)/max_time)) > 20) and diff_time > 20)--Diff perc
or (diff_time > 0 and exec_total > 100) --Diff time sec
)
)

--Main Table
LOOP
DBMS_OUTPUT.PUT_LINE('<p><a name="'||r.sql_id||'"></a></p>');
DBMS_OUTPUT.PUT_LINE('<h5>Distinct plan values for sql id <a href="#'||r.sql_id||'fullt">'||r.sql_id||'</a>');

DBMS_OUTPUT.put_line('
<table class="grid"><tbody>
<th>snapid</th>
<th>username</th>
<th>node</th>
<th>begin_interval_time</th>
<th>plan_hash_value</th>
<th>sql_profile</th>
<th>execs</th>
<th>rows_processed_total</th>
<th>avg_etime</th>
<th>avg_etime_min</th>
<th>avg_lio</th>
');

FOR i in (
select ss.snap_id, c.username,ss.instance_number node, begin_interval_time, plan_hash_value,
nvl(executions_delta,0) execs, rows_processed_total,
round((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000) avg_etime,
round(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000)/60) avg_etime_min,
round((buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta))) avg_lio,sql_profile
from DBA_HIST_SNAPSHOT SS, DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where s.sql_id = r.sql_id
and begin_interval_time > sysdate -60
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
and c.username <> 'SYS'
order by 1,5,2
)

--Details by SQLID
LOOP
DBMS_OUTPUT.PUT_LINE('<tr><td>'||i.snap_id||'</td><td>'||i.username||'</td><td>'||i.node||'</td><td>'||i.begin_interval_time||'</td><td>'||i.plan_hash_value||'</td><td>'||i.sql_profile||'</td><td>'||i.execs||'</td><td>'||i.rows_processed_total||'</td><td>'||i.avg_etime||'</td><td>'||i.avg_etime_min||'</td><td>'||i.avg_lio||'</td></tr>');
END LOOP;
DBMS_OUTPUT.put_line ('</tbody></table><a href="#top">Back to Top</a></h5>');

END LOOP;

DBMS_OUTPUT.put_line('<h3>Complete List of SQL Text</h3>');

DBMS_OUTPUT.put_line('<h5>
<table class="grid"><tbody>
<th>SQLID</th><th>SqlText</th>');

FOR r in (
select sql_id, username, count_hash_val, exec_total,first_exec, last_exec, 
min_time, max_time, diff_time, decode(min_time,0,100,round((diff_time*100)/max_time)) diff_perc
from (
select s.sql_id,c.username,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
min (begin_interval_time) first_exec, max (begin_interval_time) last_exec,
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) min_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) max_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) -
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) diff_time
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate -3
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and rows_processed_total <> 0 --Excl Canceled
group by s.sql_id,c.username
having count(distinct plan_hash_value) > 1
order by diff_time)
where diff_time <> 0 
and username <> 'SYS'
and
((decode(min_time,0,100,round((diff_time*100)/max_time)) > 50) --Diff time perc 
or diff_time > 10)
union all
select sql_id, username, count_hash_val, exec_total,first_exec, last_exec, 
min_time, max_time, diff_time, decode(min_time,0,100,round((diff_time*100)/max_time)) diff_perc
from (
select s.sql_id,c.username,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
min (begin_interval_time) first_exec, max (begin_interval_time) last_exec,
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) min_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) max_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) -
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) diff_time
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate -60
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and rows_processed_total <> 0 --Excl Canceled
group by s.sql_id,c.username
having count(distinct plan_hash_value) > 1
order by diff_time)
where diff_time <> 0 
and username <> 'SYS'
and
(
((decode(min_time,0,100,round((diff_time*100)/max_time)) > 20) and diff_time > 20)--Diff perc
or (diff_time > 0 and exec_total > 100) --Diff time sec
)
)
LOOP

--SQLs Full


FOR p in (
select SQL_TEXT from DBA_HIST_SQLTEXT where SQL_ID= r.sql_id
)
loop
DBMS_OUTPUT.PUT_LINE('<tr><td><a name="'||r.sql_id||'fullt"></a>'||r.sql_id||'</td><td>'||p.sql_text||'</td></tr>');
end loop;


/*
FOR i in (
select ss.snap_id, ss.instance_number node, begin_interval_time, plan_hash_value,
nvl(executions_delta,0) execs, rows_processed_total,
round((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000) avg_etime,
round(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000)/60) avg_etime_min,
round((buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta))) avg_lio
from DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS
where sql_id = r.sql_id
and begin_interval_time > sysdate -3
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
order by 1, 2, 3
)
loop

DBMS_OUTPUT.put_line('<h5><table class="grid"><tbody>
<th>SQLID: '||r.sql_id||', hash_value : '||i.plan_hash_value||'</th>');
--DBMS_OUTPUT.PUT_LINE('<td>');

for h in (
SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR(r.sql_id,i.plan_hash_value,null,'ADVANCED'))
)
loop
DBMS_OUTPUT.put_line('<tr>'||h.PLAN_TABLE_OUTPUT||'</tr>');
end loop;

DBMS_OUTPUT.put_line ('</tbody></table></h5>');
end loop;
*/

end loop;
DBMS_OUTPUT.put_line ('</tbody></table><a href="#top">Back to Top</a></h5>');

  DBMS_OUTPUT.put_line ('<div> <div style="text-align: center"> <canvas id="line1" width="1200" height="250">[Please wait...]</canvas> </div>');

DBMS_OUTPUT.put_line ('</body> </html>');

END;
/

spool off