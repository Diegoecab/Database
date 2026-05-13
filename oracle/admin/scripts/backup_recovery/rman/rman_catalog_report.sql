--------------------------------------------------------------------------------
-- 
-- File name:   rman_catalog_report.sql v1.2
-- Purpose:     Genera reporte html de lo registrado en el catalogo de rman en los ultimos 8 dias
--              incluyendo las bases que no hayan respaldado. Incluye log de errores
--              
-- Author:      Diego Cabrera
--              
-- Usage:       
--     @rman_catalog_report <htmlfile>
--
-- Example:
--     
--     @rman_catalog_report c:\temp\rman_catalog_report.html
--	  @rman_catalog_report /tmp/rman_catalog_report.html


set echo         off
set verify       off
set feedback off

set pagesize 1000
set serveroutput on

set heading off




whenever oserror exit 9;
whenever sqlerror exit sql.sqlcode;

variable spoolpath varchar2(100);
variable  default_path varchar2(100);
variable  input_val varchar2(100);

set termout off;
column dflt_name new_value dflt_name noprint;
select 'rman_catalog_report.html' dflt_name from dual;
set termout on;


set termout on;
set heading off;
column report_name new_value report_name noprint;

select nvl('&&1','&dflt_name') report_name
  from sys.dual;
  

set define on

select 'Report name: &report_name'
  from sys.dual;


set termout on;
spool &report_name;


set termout      off

set define off

alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';


DECLARE
   vaux     NUMBER         := 0;
   dbname   VARCHAR2 (100);
   tdclass  VARCHAR2 (100);
   sessionk NUMBER := -1;
   dbidk NUMBER := -1;
   aname VARCHAR2 (100);
   asession VARCHAR2 (100);
   ahref  VARCHAR2 (100);
   exitnum NUMBER := 0;
   exitmessage VARCHAR2 (100);
   filename VARCHAR2 (1000);
BEGIN
   

   DBMS_OUTPUT.put_line
      (   '
<html>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"><html lang="en">
<head>
<title>Oracle RMAN backup details registered in catalog '
       || '   '
       || SYSDATE
       || '</title>
<style type="text/css">
body {font:bold 10pt Arial,Helvetica,Geneva,sans-serif;color:black; background:White;}
pre  {font:8pt Courier;color:black; background:White;}
h1   {font:bold 20pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;border-bottom:1px solid #cccc99;margin-top:0pt; margin-bottom:0pt;padding:0px 0px 0px 0px;}
h2   {font:bold 18pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}
h3 {font:bold 16pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}
li {font: 8pt Arial,Helvetica,Geneva,sans-serif; color:black; background:White;}
th.awrnobg {font:bold 8pt Arial,Helvetica,Geneva,sans-serif; color:black; background:White;padding-left:4px; padding-right:4px;padding-bottom:2px}
th {font:bold 8pt Arial,Helvetica,Geneva,sans-serif; color:White; background:#0066CC;padding-left:4px; padding-right:4px;padding-bottom:2px;}
td {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;  text-align: right;}
td.tdwarning    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;}
td.tdcritical    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top; color: red; font:bold 8pt Arial,Helvetica,sans-serif;}
.tdlf {text-align: left;}
td.awrnclb {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-left: thin solid black;}
td.awrncbb {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-left: thin solid black;border-right: thin solid black;}
td.awrncrb {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-right: thin solid black;}
td.awrcrb    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-right: thin solid black;}
td.awrclb    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-left: thin solid black;}
td.awrcbb    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-left: thin solid black;border-right: thin solid black;}
a {font: bold 8pt Arial,Helvetica,sans-serif;color: #663300; vertical-align: top;    margin-top: 0pt;    margin-bottom: 0pt;}
td.awrnct {font:8pt Arial,Helvetica,Geneva,sans-serif;border-top: thin solid black;color:black;background:White;vertical-align:top;}
td.awrct   {font:8pt Arial,Helvetica,Geneva,sans-serif;border-top: thin solid black;color:black;background:#FFFFCC; vertical-align:top;}
td.awrnclbt  {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-top: thin solid black;border-left: thin solid black;}
td.awrncbbt  {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-left: thin solid black;border-right: thin solid black;border-top: thin solid black;}
td.awrncrbt {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-top: thin solid black;border-right: thin solid black;}
td.awrcrbt     {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-top: thin solid black;border-right: thin solid black;}
td.awrclbt     {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-top: thin solid black;border-left: thin solid black;}
td.awrcbbt   {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-top: thin solid black;border-left: thin solid black;border-right: thin solid black;}
table {  border_collapse: collapse; }
.fullbackups_table > tbody > tr> th {  cursor: pointer; }
.hidden   {position:absolute;left:-10000px;top:auto;width:1px;height:1px;overflow:hidden;}
.pad   {margin-left:17px;}
.doublepad {margin-left:34px;}
</style>
</head>
<body>'
      );
	  

/*+++Last full backup for each database*/

DBMS_OUTPUT.put_line ('<hr align="left" width="20%">');
DBMS_OUTPUT.put_line ('<h3>Full backups executed during last 8 days</h3>');

DBMS_OUTPUT.put_line ('<div style="padding: 5px; border-radius: 4px; background-color: #fbfbfb; box-shadow: 0px 0px 1px rgb(167, 169, 172); font: 10pt Arial,Helvetica,Geneva,sans-serif;">
<p><i>This view gives information about the databases registered in the recovery catalog and their latest full backup operations.</i></p>
          </div>');

DBMS_OUTPUT.put_line ('<table id="fullbackups_table" class="fullbackups_table">');
DBMS_OUTPUT.put_line ('<tr><th onclick="sortTable(''fullbackups_table'',0)">DB ID</th><th onclick="sortTable(''fullbackups_table'',1)">DB Name</th><th onclick="sortTable(''fullbackups_table'',2)">DB Key</th><th onclick="sortTable(''fullbackups_table'',3)">Last backup time</th><th onclick="sortTable(''fullbackups_table'',4)">Object type</th><th onclick="sortTable(''fullbackups_table'',5)">Row level</th><th onclick="sortTable(''fullbackups_table'',6)">Status</th><th onclick="sortTable(''fullbackups_table'',7)">GB Processed</th><th onclick="sortTable(''fullbackups_table'',8)">Device</th></tr>');

for r in (
select a.dbid,a.name, b.* from RC_database A left outer join
(
select db_key, max(start_time) last_backup_time , RANK() OVER (PARTITION BY db_key ORDER BY  max(start_time)	 DESC) start_time_last, object_type, row_level, status,
round ( max(output_bytes) / 1000000000 ) GBytes_Processed,
output_device_type "DEVICE"
 from rc_rman_status b where b.start_time > sysdate -8 and operation='BACKUP' and
(object_type = 'DB FULL' or object_type = 'DB INCR')
GROUP BY db_key, DB_NAME, object_type, row_level, status,
output_device_type
order by 2 ) b on a.db_key = b.db_key and start_time_last = 1 order by name
) loop

tdclass:=''; 
if r.status <> 'COMPLETED' then 
tdclass:='class="tdwarning"'; 
end if;
if r.last_backup_time is null then 
tdclass:='class="tdcritical"'; 
end if;
if r.status = 'FAILED' then 
tdclass:='class="tdcritical"'; 
end if;

DBMS_OUTPUT.put_line ('<tr>'||
'<td '||tdclass||'>'||r.dbid||'</td>'||
'<td '||tdclass||'>'||r.name||'</td>'||
'<td '||tdclass||'>'||r.db_key||'</td>'||
'<td '||tdclass||'>'||r.last_backup_time||'</td>'||
'<td '||tdclass||'>'||r.object_type||'</td>'||
'<td '||tdclass||'>'||r.row_level||'</td>'||
'<td '||tdclass||'>'||r.status||'</td>'||
'<td '||tdclass||'>'||r.GBytes_Processed||'</td>'||
'<td '||tdclass||'>'||r.DEVICE||'</td>'||
'</tr>');
end loop;
DBMS_OUTPUT.put_line ('</table>');

/*+++Last full backup for each database*/



/*+++Last backups for each database*/

DBMS_OUTPUT.put_line ('<hr align="left" width="20%">');
DBMS_OUTPUT.put_line ('<h3>Backups executed during last 8 days</h3>');

DBMS_OUTPUT.put_line ('<div style="padding: 5px; border-radius: 4px; background-color: #fbfbfb; box-shadow: 0px 0px 1px rgb(167, 169, 172); font: 10pt Arial,Helvetica,Geneva,sans-serif;">
<p><i>This view gives information about the databases registered in the recovery catalog and their latest full backup operations.</i></p>
          </div>');

DBMS_OUTPUT.put_line ('<table id="backups_table" class="fullbackups_table">');
DBMS_OUTPUT.put_line ('<tr><th onclick="sortTable(''backups_table'',0)">DB ID</th><th onclick="sortTable(''backups_table'',1)">DB Name</th><th onclick="sortTable(''backups_table'',2)">DB Key</th><th onclick="sortTable(''backups_table'',3)">Last backup time</th><th onclick="sortTable(''backups_table'',4)">Object type</th><th onclick="sortTable(''backups_table'',5)">Row level</th><th onclick="sortTable(''backups_table'',6)">Status</th><th onclick="sortTable(''backups_table'',7)">GB Processed</th><th onclick="sortTable(''backups_table'',8)">Device</th></tr>');

for r in (
select a.dbid,a.name, b.* from RC_database A left outer join
(
select db_key, max(start_time) last_backup_time , object_type, row_level, status,
round ( max(output_bytes) / 1000000000 ) GBytes_Processed,
output_device_type "DEVICE"
 from rc_rman_status b where b.start_time > sysdate -8 and operation='BACKUP'
GROUP BY db_key, DB_NAME, object_type, row_level, status,
output_device_type
order by max(start_time),db_key ) b on a.db_key = b.db_key
) loop

tdclass:=''; 
if r.status <> 'COMPLETED' then 
tdclass:='class="tdwarning"'; 
end if;
if r.last_backup_time is null then 
tdclass:='class="tdcritical"'; 
end if;
if r.status = 'FAILED' then 
tdclass:='class="tdcritical"'; 
end if;

DBMS_OUTPUT.put_line ('<tr>'||
'<td '||tdclass||'>'||r.dbid||'</td>'||
'<td '||tdclass||'>'||r.name||'</td>'||
'<td '||tdclass||'>'||r.db_key||'</td>'||
'<td '||tdclass||'>'||r.last_backup_time||'</td>'||
'<td '||tdclass||'>'||r.object_type||'</td>'||
'<td '||tdclass||'>'||r.row_level||'</td>'||
'<td '||tdclass||'>'||r.status||'</td>'||
'<td '||tdclass||'>'||r.GBytes_Processed||'</td>'||
'<td '||tdclass||'>'||r.DEVICE||'</td>'||
'</tr>');
end loop;
DBMS_OUTPUT.put_line ('</table>');

/*+++Last backups for each database*/

/*+++Unsucessfully Rman operations during last 8 days*/


DBMS_OUTPUT.put_line ('<hr align="left" width="20%">');
DBMS_OUTPUT.put_line ('<h3>Unsucessfully Rman operations during last 8 days</h3><br>');

DBMS_OUTPUT.put_line ('<table id="operations_table">');
DBMS_OUTPUT.put_line ('<tr><th>DB Name</th><th>Type</th><th>Operation</th><th>Status</th><th>Duration</th><th>Begin</th><th>End</th><th>GB Processed</th><th>Device</th></tr>');

for r in (
SELECT * FROM (
select --dbid ,
session_key, db_name dbname,object_type type, status, lpad(trunc( mod( (end_time-start_time)*24, 24 )),2,'0')|| ':'||lpad(trunc( mod( (end_time-start_time)*24*60, 60 )),2,'0') || ':'||
lpad(trunc( mod( (end_time-start_time)*24*60*60, 60 )),2,'0') duration,
to_char(start_time, 'dd-mm-yy hh24:mi:ss' ) start_time,
to_char(end_time, 'dd-mm-yy hh24:mi' ) end_time
, round ( rs.output_bytes / 1000000000 ) GBytes_Processed,
output_device_type "DEVICE",
OPERATION
from rc_rman_status rs--, rc_database d
where
trunc(start_time)>trunc(sysdate)-8
and status <> 'COMPLETED'
ORDER BY DB_NAME DESC, start_time DESC
)
) loop

tdclass:=''; 
ahref:= r.dbname;
if r.status <> 'COMPLETED' then 
tdclass:='class="tdwarning"'; 
	if r.operation = 'BACKUP' then
		ahref :='<a name="'||r.session_key||'#" href="#'||r.session_key||'">'||r.dbname||'</a>';
	end if;
end if;
if r.status = 'FAILED' then 
tdclass:='class="tdcritical"'; 
end if;

DBMS_OUTPUT.put_line ('<tr>'||
'<td '||tdclass||'>'||ahref||'</td>'||
'<td '||tdclass||'>'||r.type||'</td>'||
'<td '||tdclass||'>'||r.operation||'</td>'||
'<td '||tdclass||'>'||r.status||'</td>'||
'<td '||tdclass||'>'||r.duration||'</td>'||
'<td '||tdclass||'>'||r.start_time||'</td>'||
'<td '||tdclass||'>'||r.end_time||'</td>'||
'<td '||tdclass||'>'||r.GBytes_Processed||'</td>'||
'<td '||tdclass||'>'||r.device||'</td>'||
'</tr>');
end loop;
DBMS_OUTPUT.put_line ('</table>');

/*+++Rman operations during last 8 days*/


/*+++RC_BACKUP_SET_SUMMARY*/

DBMS_OUTPUT.put_line ('<hr align="left" width="20%">');
DBMS_OUTPUT.put_line ('<h3>Backups executed during last 8 days</h3>');

DBMS_OUTPUT.put_line ('<div style="padding: 5px; border-radius: 4px; background-color: #fbfbfb; box-shadow: 0px 0px 1px rgb(167, 169, 172); font: 10pt Arial,Helvetica,Geneva,sans-serif;">
<p><i>This view gives information about the databases registered in the recovery catalog and their latest full backup operations.</i></p>
          </div>');

DBMS_OUTPUT.put_line ('<table id="rc_backup_set_summary_table">');
DBMS_OUTPUT.put_line ('<tr><th>DB Name</th><th>DB Key</th><th>num backupsets</th><th>OLDEST_BACKUP_TIME</th><th>NEWEST_BACKUP_TIME</th><th>GB Output</th><th>ORIGINAL INPUT GB</th><th>ORIGINAL_INPRATE_GB</th><th>ORIGINAL_INPRATE_GB</th><th>COMPRESSION_RATIO</th><th>ORIGINAL_INPUT_BYTES_DISPLAY</th></tr>');

for r in (
select 
 DB_NAME                          ,
 DB_KEY                           ,
 NUM_BACKUPSETS                   ,
 OLDEST_BACKUP_TIME               ,
 NEWEST_BACKUP_TIME               ,
 round(OUTPUT_BYTES/1024/1024/1024) "OUTPUT_GB"                     ,
 round(ORIGINAL_INPUT_BYTES/1024/1024/1024) "ORIGINAL_INPUT_GB"             ,
 round(ORIGINAL_INPRATE_BYTES/1024/1024/1024) "ORIGINAL_INPRATE_GB"          ,
 round(OUTPUT_RATE_BYTES/1024/1024/1024)      "OUTPUT_RATE_GB"          ,
 round(COMPRESSION_RATIO) "COMPRESSION_RATIO"                ,
 ORIGINAL_INPUT_BYTES_DISPLAY     ,
 OUTPUT_BYTES_DISPLAY             ,
 ORIGINAL_INPRATE_BYTES_DISPLAY   ,
 OUTPUT_RATE_BYTES_DISPLAY
 from RC_BACKUP_SET_SUMMARY 
) loop

DBMS_OUTPUT.put_line ('<tr>'||
'<td>'||r.db_name||'</td>'||
'<td>'||r.db_key||'</td>'||
'<td>'||r.NUM_BACKUPSETS||'</td>'||
'<td>'||r.OLDEST_BACKUP_TIME||'</td>'||
'<td>'||r.NEWEST_BACKUP_TIME||'</td>'||
'<td>'||r.OUTPUT_GB||'</td>'||
'<td>'||r.ORIGINAL_INPUT_GB||'</td>'||
'<td>'||r.ORIGINAL_INPRATE_GB||'</td>'||
'<td>'||r.OUTPUT_RATE_GB||'</td>'||
'<td>'||r.COMPRESSION_RATIO||'</td>'||
'<td>'||r.ORIGINAL_INPUT_BYTES_DISPLAY||'</td>'||
'</tr>');
end loop;
DBMS_OUTPUT.put_line ('</table>');

/*+++RC_BACKUP_SET_SUMMARY*/





/*+++Rman Output with ORA-* and RMAN-* errors*/

DBMS_OUTPUT.put_line ('<hr align="left" width="20%">');
DBMS_OUTPUT.put_line ('<h3>Rman Output with ORA-* and RMAN-* errors</h3><br>');

DBMS_OUTPUT.put_line ('<table>');
DBMS_OUTPUT.put_line ('<tr><th>DB Key</th><th>Session key</th><th>STAMP</th><th>OUTPUT</th></tr>');




for r in (
SELECT * FROM (
select --dbid ,
* from rc_rman_output
where session_key in (
select distinct(session_key) from rc_rman_status
where
trunc(start_time)>trunc(sysdate)-8
and status <> 'COMPLETED'
and operation ='BACKUP'
) and (output like '%RMAN-%' or output like '%ORA-%')
order by db_key, stamp
)
)
loop

if sessionk <> r.session_key then
	sessionk := r.session_key;
	aname := '<a name='||r.session_key||' ></a>'; --First row with new session key
	asession := '<a href="#'||r.session_key||'#">'||r.session_key||'</a>'; --First row with new session key
	if tdclass='class="tdwarning"' then
		tdclass:=''; 
	else
	tdclass:='class="tdwarning"';
	end if;
else
aname := '';
asession := r.session_key;
end if;

DBMS_OUTPUT.put_line ('<tr>'||
'<td '||tdclass||'>'||aname||''||r.db_key||'</td>'||
'<td '||tdclass||'>'||asession||'</td>'||
'<td '||tdclass||'>'||r.stamp||'</td>'||
'<td '||tdclass||'>'||r.output||'</td>'||
'</tr>');
end loop;
DBMS_OUTPUT.put_line ('</table>');

/*+++Rman Output with ORA-* and RMAN-* errors*/

/*+++Rman configuration*/

DBMS_OUTPUT.put_line ('<hr align="left" width="20%">');
DBMS_OUTPUT.put_line ('<h3>Rman configuration</h3><br>');

DBMS_OUTPUT.put_line ('<table>');
DBMS_OUTPUT.put_line ('<tr><th>DB ID</th><th>DB Name</th><th>DB Unique Name</th><th>DB Key</th><th>Conf#</th><th>Name</th><th>Value</th></tr>');

for r in (
select a.dbid, a.name dbname, b.* from
rc_database a,
rc_rman_configuration b
where b.db_key = a.db_key
and DB_UNIQUE_NAME = a.name
order by a.name, conf#
) loop


if dbidk <> r.dbid then
	dbidk := r.dbid;
	if tdclass='class="tdwarning"' then
		tdclass:=''; 
	else
	tdclass:='class="tdwarning"';
	end if;
end if;

DBMS_OUTPUT.put_line ('<tr>'
||'<td '||tdclass||'>'||r.dbid||'</td>'
||'<td '||tdclass||'>'||r.dbname||'</td>'
||'<td '||tdclass||'>'||r.db_unique_name||'</td>'
||'<td '||tdclass||'>'||r.db_key||'</td>'
||'<td '||tdclass||'>'||r.conf#||'</td>'
||'<td '||tdclass||'>'||r.name||'</td>'
||'<td '||tdclass||'>'||r.value||'</td>'
||'</tr>');
end loop;
DBMS_OUTPUT.put_line ('</table>');
/*+++Rman configuration*/


DBMS_OUTPUT.put_line ('<hr align="left" width="20%">');






DBMS_OUTPUT.put_line ('<script>
function sortTable(tname, n) {
  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById(tname);
  switching = true;
  dir = "asc";
  /* Make a loop that will continue until
  no switching has been done: */
  while (switching) {
    switching = false;
    rows = table.rows;
    /* Loop through all table rows (except the
    first, which contains table headers): */
    for (i = 1; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      /* Get the two elements you want to compare,
      one from current row and one from the next: */
      x = rows[i].getElementsByTagName("TD")[n];
      y = rows[i + 1].getElementsByTagName("TD")[n];
      /* Check if the two rows should switch place,
      based on the direction, asc or desc: */
      if (dir == "asc") {
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
          shouldSwitch = true;
          break;
        }
      } else if (dir == "desc") {
        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
          // If so, mark as a switch and break the loop:
          shouldSwitch = true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      /* If a switch has been marked, make the switch
      and mark that a switch has been done: */
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      switchcount ++;
    } else {
      /* If no switching has been done AND the direction is "asc",
      set the direction to "desc" and run the while loop again. */
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}
</script>');

DBMS_OUTPUT.put_line ('</body> </html>');
end;
/

spool off
