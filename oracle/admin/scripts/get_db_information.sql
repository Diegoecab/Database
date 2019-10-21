Rem
Rem db.cfg.hc.rpt.sql
Rem
Rem
Rem    NAME
Rem      db_cfg_hc_rpt.sql
Rem
Rem    DESCRIPTION
Rem
Rem    NOTES
Rem      Run as select_catalog privileges.
Rem
Rem
Rem    MODIFIED          (DD/MM/YY)
Rem    Diego Cabrera      07/10/15 - Initial version
Rem    Diego Cabrera      15/08/19 - 

/*
•	Relevamiento de la DB.
•	Revisión de Alertas
•	Disponibilidad de la DB.
•	Configuración de los Redologs
•	Frecuencia de switcheo de la DB.
•	Tablespaces
•	Uso de la memoria
•	Control de Espacios del SO.
•	Revisión de las tareas programadas
•	Backups: Exports
•	Análisis de objetos inválidos.
•	Jobs de la Base
dba registry

*/


set echo        off
set feedback    off
set verify      off
set heading     off
set termout     off
set define      on
set pause       off
set timing      off
set trimspool   on
set pagesize    0
set linesize    500
ttitle          off
btitle          off


set feedback off
--set define off


column timecol new_value timestamp
column spool_extension new_value suffix
SELECT TO_CHAR(sysdate,'yyyymmdd_hh24mi') timecol, '.html' spool_extension FROM dual;
column output new_value dbname
SELECT value || '_' output FROM v$parameter WHERE name = 'db_unique_name';
spool c:\temp\db_cfg_hc_rpt_&&dbname&&timestamp&&suffix
set linesize 2000
set pagesize 50000
set numformat 999999999999999
set trim on
set trims on
alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';


prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt <style type="text/css">
prompt body {font:bold 10pt Arial,Helvetica,Geneva,sans-serif;color:black; background:White;}
prompt pre  {font:8pt Courier;color:black; background:White;}
prompt h1   {font:bold 20pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;border-bottom:1px solid #cccc99;margin-top:0pt; margin-bottom:0pt;padding:0px 0px 0px 0px;}
prompt h2   {font:bold 18pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}
prompt h3 {font:bold 16pt Arial,Helvetica,Geneva,sans-serif;color:#336699;background-color:White;margin-top:4pt; margin-bottom:0pt;}
prompt li {font: 8pt Arial,Helvetica,Geneva,sans-serif; color:black; background:White;}
prompt th.awrnobg {font:bold 8pt Arial,Helvetica,Geneva,sans-serif; color:black; background:White;padding-left:4px; padding-right:4px;padding-bottom:2px}
prompt th {font:bold 8pt Arial,Helvetica,Geneva,sans-serif; color:White; background:#0066CC;padding-left:4px; padding-right:4px;padding-bottom:2px}
prompt tr:nth-child(even) {background: #FFFFCC}
prompt tr:nth-child(odd) {background: #FFF}
prompt td.awrnc {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;vertical-align:top;}
prompt td.awrc    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;}
prompt td.awrnclb {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-left: thin solid black;}
prompt td.awrncbb {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-left: thin solid black;border-right: thin solid black;}
prompt td.awrncrb {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-right: thin solid black;}
prompt td.awrcrb    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-right: thin solid black;}
prompt td.awrclb    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-left: thin solid black;}
prompt td.awrcbb    {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-left: thin solid black;border-right: thin solid black;}
prompt a {font:bold 8pt Arial,Helvetica,sans-serif;color:#663300; vertical-align:top;margin-top:0pt; margin-bottom:0pt;}
prompt td.awrnct {font:8pt Arial,Helvetica,Geneva,sans-serif;border-top: thin solid black;color:black;background:White;vertical-align:top;}
prompt td.awrct   {font:8pt Arial,Helvetica,Geneva,sans-serif;border-top: thin solid black;color:black;background:#FFFFCC; vertical-align:top;}
prompt td.awrnclbt  {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-top: thin solid black;border-left: thin solid black;}
prompt td.awrncbbt  {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-left: thin solid black;border-right: thin solid black;border-top: thin solid black;}
prompt td.awrncrbt {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:White;vertical-align:top;border-top: thin solid black;border-right: thin solid black;}
prompt td.awrcrbt     {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-top: thin solid black;border-right: thin solid black;}
prompt td.awrclbt     {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-top: thin solid black;border-left: thin solid black;}
prompt td.awrcbbt   {font:8pt Arial,Helvetica,Geneva,sans-serif;color:black;background:#FFFFCC; vertical-align:top;border-top: thin solid black;border-left: thin solid black;border-right: thin solid black;}
prompt table {  border_collapse: collapse; }
prompt .hidden   {position:absolute;left:-10000px;top:auto;width:1px;height:1px;overflow:hidden;}
prompt .pad   {margin-left:17px;}
prompt .doublepad {margin-left:34px;}
prompt </style>
prompt </HEAD>

prompt <BODY class="awr">
select '<p><i>'||SYSDATE||'</i></p>' from dual;
prompt <h3 class="awr">Oracle Database configuration report and healthcheck for</h3>
prompt <h1>
select name from sys.v_$database;
select ' (RAC)' from dual where exists (select 1 from v$parameter where name = 'cluster_database' and value='TRUE');
prompt </h1>


prompt <TABLE >
prompt <TR>


prompt </TR>
prompt </TABLE><BR>

-----------------------
-- Database Information
-----------------------
prompt <p>Database Summary</p>
prompt <TABLE>
prompt <TR>
prompt <th>Instance Name</th>
prompt <th>Instance#</th>
prompt 	<th >Host Name</th>
prompt 	<th >Status</th>
prompt 	<th >Created</th>
prompt 	<th >Started at</th>
prompt 	<th >Uptime</th>
prompt 	<th >Modo</th>
prompt </TR>
SELECT  '<TR>
	<td class="awrnc" >'||upper(instance_name)||'</TD>
	<td class="awrnc" >'||upper(instance_number)||'</TD>
	<td class="awrnc" >'||upper(host_name)||'</TD>
	<td class="awrnc" >'||status||'</TD>
	<td class="awrnc" >'||created||'</TD>
	<td class="awrnc" >'||to_char(startup_time, 'DD-MON-YYYY HH24:MI:SS')||'</TD>
	<td class="awrnc" >'||trunc(sysdate - (startup_time)) || ' day(s), ' ||
        trunc(24*((sysdate-startup_time) -
                trunc(sysdate-startup_time)))||' hour(s), ' ||
        mod(trunc(1440*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' minute(s), ' ||
        mod(trunc(86400*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' seconds' ||'</TD>
	<td class="awrnc" >'||log_mode||'</TD>
	</TR>'
FROM    sys.v_$instance, sys.v_$database;

prompt <TR>
prompt  <th   >
prompt  Database Products and Versions
prompt  </th>
prompt </TR>
select '<TR>
	<td class="awrnc" >'||banner||'</TD>
	</TR>'
from   sys.v_$version;

prompt </TABLE><P><HR ><P>

-------------------------
-- Tablespace Information
-------------------------
prompt  <p>Tablespace Information</p>

prompt <TABLE >
prompt <TR>
prompt 	<th >Tablespace<BR>Name</th>
prompt 	<th ALIGN="RIGHT">Size(Mb)</th>
prompt 	<th ALIGN="RIGHT">Free(Mb)</th>
prompt 	<th ALIGN="RIGHT">Used(Mb)</th>
prompt 	<th ALIGN="RIGHT">Pct Used</th>
prompt 	<th ALIGN="RIGHT">Maxsize</th>
prompt 	<th ALIGN="RIGHT" >pct_max_alloc</th>
prompt 	<th >Status</th>
prompt 	<th >LOGGING</th>
prompt 	<th >extend management</th>
prompt 	<th >Segment<BR>Mgmt</th>
prompt 	<th >Block Size</th>
prompt 	<th >Compression</th>
prompt </TR>



SELECT   '<TR>
	<td class="awrnc">'||a.name||'</TD>'
         ||'<TD class="awrnc">'||ROUND (alloc)||'</TD>'
         ||'<TD class="awrnc">'||ROUND (free)||'</TD>'
         ||'<TD class="awrnc">'||ROUND (alloc - free)||'</TD>'
         ||'<TD class="awrnc">'||MAX||'</TD>'
         ||'<TD class="awrnc">'||maxf||'</TD>'
         ||'<TD class="awrnc">'||ROUND (DECODE (MAX, 0, 0, (alloc / MAX) * 100))||'</TD>'
		 ||'<TD class="awrnc">'||status||'</TD>'
		 ||'<TD class="awrnc">'||logging||'</TD>'
		 ||'<TD class="awrnc">'||extent_management||'</TD>'
		 ||'<TD class="awrnc">'||segment_space_management||'</TD>'
		 ||'<TD class="awrnc">'||b.block_size / 1024 || 'K'||'</TD>'
		 ||'<TD class="awrnc">'||b.def_tab_compression||'</TD></TR>'
  FROM      (  SELECT   NVL (b.tablespace_name,
                             NVL (a.tablespace_name, 'UNKNOW'))
                           name,
                        alloc,
                        NVL (free, 0) free,
                        --       maxn,
                        NVL (MAX, 0) + NVL (maxn, 0) MAX,
                        NVL (maxf, 0) maxf
                 FROM   (  SELECT   ROUND (SUM (bytes) / 1024 / 1024) free,
                                    tablespace_name
                             FROM   sys.dba_free_space
                         GROUP BY   tablespace_name) a,
                        (  SELECT   SUM (bytes) / 1024 / 1024 alloc,
                                    SUM (maxbytes) / 1024 / 1024 MAX,
                                    MAX (maxbytes) / 1024 / 1024 maxf,
                                    (SELECT   SUM (bytes) / 1024 / 1024
                                       FROM   dba_data_Files df3
                                      WHERE   df3.tablespace_name =
                                                 df1.tablespace_name
                                              AND df3.AUTOEXTENSIBLE = 'NO')
                                       maxn,
                                    tablespace_name,
                                    (SELECT   COUNT ( * )
                                       FROM   dba_data_files df2
                                      WHERE   df2.tablespace_name =
                                                 df1.tablespace_name
                                              AND df2.AUTOEXTENSIBLE = 'YES')
                                       auto,
                                    COUNT ( * ) dfs
                             FROM   sys.dba_data_files df1
                         GROUP BY   tablespace_name
                         UNION ALL
                           SELECT   SUM (bytes) / 1024 / 1024 alloc,
                                    SUM (maxbytes) / 1024 / 1024 MAX,
                                    MAX (maxbytes) / 1024 / 1024 maxf,
                                    (SELECT   SUM (bytes) / 1024 / 1024
                                       FROM   dba_temp_Files df3
                                      WHERE   df3.tablespace_name =
                                                 tablespace_name
                                              AND df3.AUTOEXTENSIBLE = 'NO')
                                       maxn,
                                    tablespace_name,
                                    (SELECT   COUNT ( * )
                                       FROM   dba_temp_files df2
                                      WHERE   df2.tablespace_name =
                                                 tablespace_name
                                              AND df2.AUTOEXTENSIBLE = 'YES')
                                       auto,
                                    COUNT ( * ) dfs
                             FROM   sys.dba_temp_files
                         GROUP BY   tablespace_name) b
                WHERE   a.tablespace_name(+) = b.tablespace_name
             ORDER BY   1) a
         INNER JOIN
            dba_tablespaces b
         ON b.tablespace_name = a.name
/


prompt </TABLE><P><HR ><P>

-------------------
--Datafiles
-------------------
prompt <p>DataFiles</p>
prompt <TABLE >
prompt <TR>
prompt  <th>File id</th>
prompt  <th>Tablespace</th>
prompt  <th>File name</th>
prompt  <th>Total Size(MB)</th>
prompt  <th>Free space(MB)</th>
prompt  <th>Pct Used</th>
prompt  <th>Pct Used with max autoextend</th>
prompt  <th>Autoextend</th>
prompt  <th>Increment by</th>
prompt  <th>Maxsize</th>
prompt  <th>Creation time</th>
prompt </TR>
select '<tr><td class="awrnc">'||df.file_id
||'<td class="awrnc">'||df.tablespace_name
||'<td class="awrnc">'||df.file_name
||'<td class="awrnc">'||df.bytes/1024/1024
||'<td class="awrnc">'||round(nvl((select sum(bytes)/1024/1024 from dba_free_space a where a.file_id = df.file_id group by a.file_id),0))
||'<td class="awrnc">'||round(((df.bytes-nvl((select sum(bytes) from dba_free_space a where a.file_id = df.file_id group by a.file_id),0))/replace(df.bytes,0,1))*100)
||'<td class="awrnc">'||round(((df.bytes-nvl((select sum(bytes) from dba_free_space a where a.file_id = df.file_id group by a.file_id),0))/replace(df.maxbytes,0,1))*100)
||'<td class="awrnc">'||df.autoextensible
||'<td class="awrnc">'||increment_by
||'<td class="awrnc">'||round(df.maxbytes/1024/1024)
||'<td class="awrnc">'||vdf.creation_time||'</tr>'
from   dba_data_files        df
,      v$datafile                    vdf
where vdf.file# = df.file_id
order by tablespace_name,df.file_id;
prompt </TABLE>
prompt <P>

select '<I>Note: You will receive an "ORA-00942: table or view does not exist" error if you are running this against a v8.0.x database.  The SYS.V$_TEMPFILE view is introduced in v8.1.x (script name: dbfiles.sql)</I>'
from 	dual
where  	0 in (
	select count(*) from dba_views 
	where view_name='V_$TEMPFILE');
prompt <P>

prompt </TABLE><P><HR ><P>


------------
-- Redo Logs
------------

prompt  <p>Redo Log Information</p>
prompt <TABLE >
prompt <TR>
prompt 	<th >Member</th>
prompt 	<th>Group#</th>
prompt 	<th>Thread#</th>
prompt 	<th>Sequence#</th>
prompt 	<th>Bytes</th>
prompt 	<th>Members</th>
prompt 	<th>Archived</th>
prompt 	<th>Status</th>
prompt 	<th >First Change#</th>
prompt 	<th >First Time</th>
prompt </TR>
select  '<TR>
	<td class="awrnc" >'||a.member||'</TD>
	<td class="awrnc">'||b.group#||'</TD>
	<td class="awrnc">'||b.thread#||'</TD>
	<td class="awrnc">'||b.sequence#||'</TD>
	<td class="awrnc">'||round(b.bytes/1024/1024)||'</TD>
	<td class="awrnc">'||b.members||'</TD>
	<td class="awrnc">'||b.archived||'</TD>
	<td class="awrnc">'||b.status||'</TD>
	<td class="awrnc" >'||b.first_change#||'</TD>
	<td class="awrnc" >'||b.first_time||'</TD>
	</TR>'
from 	sys.v_$logfile a, sys.v_$log b
where  	a.group# = b.group#
order	by a.member;

prompt </TABLE><P><HR><P>



-----------------------------
-- Mapa de Archives diario --
-----------------------------

prompt  <p>Redo Log Switch history map</p>
prompt <TABLE >
prompt <TR>
prompt  <th class="awrnc"  ><B>DAY (1)</B></th>
prompt  <th class="awrnc" ><B>00</B></th>
prompt  <th class="awrnc" ><B>01</B></th>
prompt  <th class="awrnc" ><B>02</B></th>
prompt  <th class="awrnc" ><B>03</B></th>
prompt  <th class="awrnc" ><B>04</B></th>
prompt  <th class="awrnc" ><B>05</B></th>
prompt  <th class="awrnc" ><B>06</B></th>
prompt  <th class="awrnc" ><B>07</B></th>
prompt  <th class="awrnc" ><B>08</B></th>
prompt  <th class="awrnc" ><B>09</B></th>
prompt  <th class="awrnc" ><B>10</B></th>
prompt  <th class="awrnc" ><B>11</B></th>
prompt  <th class="awrnc" ><B>12</B></th>
prompt  <th class="awrnc" ><B>13</B></th>
prompt  <th class="awrnc" ><B>14</B></th>
prompt  <th class="awrnc" ><B>15</B></th>
prompt  <th class="awrnc" ><B>16</B></th>
prompt  <th class="awrnc" ><B>17</B></th>
prompt  <th class="awrnc" ><B>18</B></th>
prompt  <th class="awrnc" ><B>19</B></th>
prompt  <th class="awrnc" ><B>20</B></th>
prompt  <th class="awrnc" ><B>21</B></th>
prompt  <th class="awrnc" ><B>22</B></th>
prompt  <th class="awrnc" ><B>23</B></th>
prompt </TR>
select '<TR>
	<td class="awrnc" >'||substr(to_char(first_time,'YYYY/MM/DD'),1,10)||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)))||'</TD>
       	<td class="awrnc" >'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)))||'</TD>
       </TR>'
from 	sys.v_$log_history
where first_time > sysdate - 15
group 	by substr(to_char(first_time,'YYYY/MM/DD'),1,10)
order   by substr(to_char(first_time,'YYYY/MM/DD'),1,10) desc;

prompt </TABLE><P><HR ><P>


-------------------
-- Buffer Hit Ratio
-------------------
prompt  <p>Buffer Hit Ratio</p>

prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc" ><B>Consistent Gets</B></TD>
prompt  <td class="awrnc" ><B>DB Blk Gets</B></TD>
prompt  <td class="awrnc" ><B>Physical Reads</B></TD>
prompt  <td class="awrnc" ><B>Hit Ratio</B></TD>
prompt </TR>
select '<TR>
	 <td class="awrnc" >'||to_char(sum(decode(name, 'consistent gets',value, 0)),'999,999,999,999,999')||'</TD>
         <td class="awrnc" >'||to_char(sum(decode(name, 'db block gets',value, 0)),'999,999,999,999,999')||'</TD>
         <td class="awrnc" >'||to_char(sum(decode(name, 'physical reads',value, 0)),'999,999,999,999,999')||'</TD>
         <td class="awrnc" >'||round((sum(decode(name, 'consistent gets',value, 0)) + 
         sum(decode(name, 'db block gets',value, 0)) - sum(decode(name, 'physical reads',value, 0))) /
         (sum(decode(name, 'consistent gets',value, 0))  + sum(decode(name, 'db block gets',value, 0)))  * 100,3)||'</TD>
	</TR>' 
from sys.v_$sysstat;
prompt </TABLE><P><HR ><P>

----------------------------
-- Data Dictionary Hit Ratio
----------------------------
prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc"   COLSPAN=3>
prompt  <B>Hit Ratio del diccionario de datos</B>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <td class="awrnc" ><B>Gets</B></TD>
prompt  <td class="awrnc" ><B>Cache Misses</B></TD>
prompt  <td class="awrnc" ><B>Hit Ratio</B></TD>
prompt </TR>
select '<TR>
	 <td class="awrnc" >'||to_char(sum(gets),'999,999,999,999,999')||'</TD>
	 <td class="awrnc" >'||to_char(sum(getmisses),'999,999,999,999,999')||'</TD>
   <td class="awrnc" >'||round((1 - (sum(getmisses) / sum(gets))) * 100,3)||'</TD>
	</TR>' 
from 	sys.v_$rowcache;
prompt </TABLE><P><HR ><P>

----------------------------
-- Library Cache Hit Ratio
----------------------------
prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc"   COLSPAN=5>
prompt  <B>Library Cache Hit Ratio</B>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <td class="awrnc" ><B>Executions</B></TD>
prompt  <td class="awrnc" ><B>Execution<BR>Hits</B></TD>
prompt  <td class="awrnc" ><B>Hit<BR>Ratio</B></TD>
prompt  <td class="awrnc" ><B>Misses</B></TD>
prompt  <td class="awrnc" ><B>Hit<BR>Ratio</B></TD>
prompt </TR>
select '<TR>
	<td class="awrnc" >'||to_char(sum(pins),'999,999,999,999,999')||'</TD>
	<td class="awrnc" >'||to_char(sum(pinhits),'999,999,999,999,999')||'</TD>
   	<td class="awrnc" >'||round((sum(pinhits) / sum(pins)) * 100,3)||'</TD>
	<td class="awrnc" >'||to_char(sum(reloads),'999,999,999,999,999')||'</TD>
   	<td class="awrnc" >'||round((sum(pins) / (sum(pins) + sum(reloads))) * 100,3)||'</TD>
	</TR>' 
from 	sys.v_$librarycache;
prompt </TABLE><P><HR ><P>

------------------
-- SGA Information
------------------
prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc"   COLSPAN=5>
prompt  <B>Informacion de la SGA</B>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<td class="awrnc" ><B>Name</B></TD>
prompt 	<td class="awrnc"  ALIGN="RIGHT"><B>Value</B></TD>
prompt </TR>
select '<TR>
	<td class="awrnc"><B>'||name||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(value,'999,999,999,999,999')||'</TD>
	</TR>'
from 	sys.v_$sga;
select '<TR>
	<td class="awrnc"><B>TOTAL SGA</B></TD>
	<td class="awrnc" ALIGN="RIGHT"><B>'||to_char(sum(value),'999,999,999,999,999')||'</B></TD>
	</TR>'
from 	sys.v_$sga;
prompt </TABLE><P><HR ><P>


----------------------
-- Segment Information
----------------------
prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc"   0>
prompt  <B>Segmentos con mas de un 50% de Max Extents</B>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<td class="awrnc"><B>Owner</B></TD>
prompt 	<td class="awrnc"><B>Tablespace<BR>Name</B></TD>
prompt 	<td class="awrnc"><B>Segment<BR>Name</B></TD>
prompt 	<td class="awrnc"><B>Segment<BR>Type</B></TD>
prompt 	<td class="awrnc" ALIGN="RIGHT"><B>Segment<BR>Size</B></TD>
prompt 	<td class="awrnc" ALIGN="RIGHT"><B>Next<BR>Extent</B></TD>
prompt 	<td class="awrnc" ><B>Pct<BR>Incr</B></TD>
prompt 	<td class="awrnc" ><B>Current<BR>Extents</B></TD>
prompt 	<td class="awrnc" ><B>Max<BR>Extents</B></TD>
prompt 	<td class="awrnc"  ><B>Percent</B></TD>
prompt </TR>
select '<TR>
	<td class="awrnc">'||owner||'</TD> 
	<td class="awrnc">'||tablespace_name||'</TD>
	<td class="awrnc">'||segment_name||'</TD>
	<td class="awrnc">'||segment_type||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(bytes,'999,999,999,999,999')||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(next_extent,'999,999,999,999,999')||'</TD>
	<td class="awrnc" >'||pct_increase||'</TD>
	<td class="awrnc" >'||extents||'</TD>
	<td class="awrnc" >'||max_extents||'</TD>
	<td class="awrnc" >'||to_char((extents/max_extents)*100,'999.90')||'</TD>
	</TR>'
from 	dba_segments
where 	segment_type in ('TABLE','INDEX')
and 	extents > max_extents/2
order 	by (extents/max_extents) desc;
prompt </TABLE><P><HR ><P>

---------------------
-- No Extend (Tables)
---------------------
prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc"   COLSPAN=8>
prompt  <B>Tablas que no pueden alocar mas de 1 ( un ) Extent</B>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <td class="awrnc" ><B>Owner</B></TD>
prompt  <td class="awrnc" ><B>Tablespace<BR>Name</B></TD>
prompt  <td class="awrnc"><B>Table Name</B></TD>
prompt  <td class="awrnc" ALIGN="RIGHT"><B>Next Bytes</B></TD>
prompt  <td class="awrnc" ALIGN="RIGHT"><B>Max Bytes</B></TD>
prompt  <td class="awrnc" ALIGN="RIGHT"><B>Sum Bytes</B></TD>
prompt  <td class="awrnc" ><B>Current<BR>Extents</B></TD>
prompt  <td class="awrnc" ><B>Avail<BR>Extents</B></TD>
prompt </TR>
select '<TR>
	<td class="awrnc">'||ds.owner||'</TD>
	<td class="awrnc">'||ds.tablespace_name||'</TD>
	<td class="awrnc">'||ds.segment_name||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(ds.next_extent,'999,999,999,999,999')||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(dfs.max,'999,999,999,999,999')||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(dfs.sum,'999,999,999,999,999')||'</TD>
	<td class="awrnc" >'||ds.extents||'</TD>
	<td class="awrnc" >'||decode(floor(dfs.max/ds.next_extent),0,'0',floor(dfs.max/ds.next_extent))||'</TD>
	</TR>'
from   	dba_segments ds,
       (select max(bytes) max, 
	sum(bytes) sum, 
	tablespace_name 
	from dba_free_space 
	group by tablespace_name) dfs
where  	ds.segment_type = 'TABLE'
and    	ds.next_extent > dfs.max
and    	ds.tablespace_name = dfs.tablespace_name
and    	ds.owner not in ('SYS','SYSTEM')
order 	by ds.owner, ds.tablespace_name, ds.segment_name;
prompt </TABLE><P><HR ><P>

----------------------
-- No Extend (Indexes)
----------------------
prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc"   COLSPAN=8>
prompt  <B>Indices que no pueden alocar mas de 1 ( un ) Extent</B>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <td class="awrnc" ><B>Owner</B></TD>
prompt  <td class="awrnc" ><B>Tablespace<BR>Name</B></TD>
prompt  <td class="awrnc"><B>Table Name</B></TD>
prompt  <td class="awrnc" ALIGN="RIGHT"><B>Next Bytes</B></TD>
prompt  <td class="awrnc" ALIGN="RIGHT"><B>Max Bytes</B></TD>
prompt  <td class="awrnc" ALIGN="RIGHT"><B>Sum Bytes</B></TD>
prompt  <td class="awrnc" ><B>Current<BR>Extents</B></TD>
prompt  <td class="awrnc" ><B>Avail<BR>Extents</B></TD>
prompt </TR>
select '<TR>
	<td class="awrnc">'||ds.owner||'</TD>
	<td class="awrnc">'||ds.tablespace_name||'</TD>
	<td class="awrnc">'||ds.segment_name||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(ds.next_extent,'999,999,999,999,999')||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(dfs.max,'999,999,999,999,999')||'</TD>
	<td class="awrnc" ALIGN="RIGHT">'||to_char(dfs.sum,'999,999,999,999,999')||'</TD>
	<td class="awrnc" >'||ds.extents||'</TD>
	<td class="awrnc" >'||decode(floor(dfs.max/ds.next_extent),0,'0',floor(dfs.max/ds.next_extent))||'</TD>
	</TR>'
from   	dba_segments ds,
       (select max(bytes) max, 
	sum(bytes) sum, 
	tablespace_name 
	from dba_free_space 
	group by tablespace_name) dfs
where  	ds.segment_type  = 'INDEX'
and    	ds.next_extent > dfs.max
and    	ds.tablespace_name = dfs.tablespace_name
and    	ds.owner not in ('SYS','SYSTEM')
order 	by ds.owner, ds.tablespace_name, ds.segment_name;
prompt </TABLE><P><HR ><P>

---------------------
-- Control de Jobs --
---------------------
prompt  <p>Control de Jobs</p>
prompt <TABLE>
prompt <TR>
prompt  <th class="awrnc" >Job</Th>
prompt  <th class="awrnc" >log_user</Th>
prompt  <th class="awrnc" >last_date</Th>
prompt  <th class="awrnc" >next_date</Th>
prompt  <th class="awrnc" >broken</Th>
prompt  <th class="awrnc">failures</Th>
prompt </TR>
select '<TR>
	<td class="awrnc">'||job||'</TD>
	<td class="awrnc">'||log_user||'</TD>
	<td class="awrnc">'||last_date||'</TD>
	<td class="awrnc">'||next_date||'</TD>
	<td class="awrnc">'||broken||'</TD>
	<td class="awrnc">'||failures||'</TD>
	</TR>'
from   	dba_jobs;
prompt </TABLE><P><HR ><P>

prompt <TABLE>
select '<tr>
<td class="awrnc">'||owner||'</td>
<td class="awrnc">'||job_name||'</td>
<td class="awrnc">'||job_creator||'</td>
<td class="awrnc">'||state||'</td>
<td class="awrnc">'||program_owner||'</td>
<td class="awrnc">'||program_name||'</td>
<td class="awrnc">'||job_type||'</td>
<td class="awrnc">'||substr(job_action,1,100)||'</td>
<td class="awrnc">'||schedule_owner||'</td>
<td class="awrnc">'||schedule_name||'</td>
<td class="awrnc">'||schedule_type||'</td>
<td class="awrnc">'||job_class||'</td>
<td class="awrnc">'||to_char(start_date,'dd/mm/yyyy hh24:mi:ss')||'</td>
<td class="awrnc">'||repeat_interval||'</td>
<td class="awrnc">'||enabled||'</td>
<td class="awrnc">'||run_count||'</td>
<td class="awrnc">'||max_runs||'</td>
<td class="awrnc">'||failure_count||'</td>
<td class="awrnc">'||max_failures||'</td>
<td class="awrnc">'||to_char(last_start_date,'dd/mm/yyyy hh24:mi:ss')||'</td>
<td class="awrnc">'||last_run_duration||'</td>
<td class="awrnc">'||to_char(next_run_date,'dd/mm/yyyy hh24:mi:ss')||'</td>
<td class="awrnc">'||max_run_duration||'</td>
<td class="awrnc">'||stop_on_window_close||'</td>
<td class="awrnc">'||source||'</td>
<td class="awrnc">'||comments ||'</td></tr>'
from
dba_scheduler_jobs;

prompt </TABLE><P><HR ><P>

-----------------------
-- Objetos invalidos --
-----------------------
prompt <TABLE >
prompt <TR>
prompt  <td class="awrnc">
prompt  Objetos Invalidos
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <td class="awrnc" >owner</TD>
prompt  <td class="awrnc" >object_name</TD>
prompt  <td class="awrnc">object_type</TD>
prompt </TR>
select '<TR>
	<td class="awrnc">'||owner||'</TD>
	<td class="awrnc">'||object_name||'</TD>
	<td class="awrnc">'||object_type||'</TD>
	</TR>'
from   	all_objects 
	where status = 'INVALID';
prompt </TABLE><P><HR ><P>

--------------------------
-- Key init.ora Parameters
--------------------------

prompt  <p>Database parameters</p>
prompt <table>
prompt <TR>
prompt  <th class="awrnc" >Parameter</th>
prompt  <th class="awrnc">Value</th>
prompt  <th class="awrnc" >Is Default</th>
prompt  <th class="awrnc">Session Modifiable</th>
prompt  <th class="awrnc">System Modifiable</th>
prompt  <th class="awrnc" >Is Modified</th>
prompt </TR>
select '<TR>
	<td class="awrnc">'||name||'</TD>
	<td class="awrnc" >'||nvl(value,'&nbsp;')||'</TD>
	<td class="awrnc">'||isdefault||'</TD>
	<td class="awrnc">'||isses_modifiable||'</TD>
	<td class="awrnc">'||issys_modifiable||'</TD>
	<td class="awrnc">'||ismodified||'</TD>
	</TR>' 
from 	sys.v_$parameter
order  	by name;
prompt </TABLE><BR>
spool off
prompt Report written to &report_name.

