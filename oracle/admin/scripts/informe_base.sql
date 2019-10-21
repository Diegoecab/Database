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

alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';

spool C:\dc\Informe_base.htm
set define off

prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY>
prompt <CENTER><FONT FACE="Arial" SIZE="1">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2">'||SYSDATE||'</FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>

-----------------------
-- Database Information
-----------------------
prompt <TABLE BORDER=1 CELLPADDING=7>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=7>
prompt  <FONT SIZE="4"><B>Base de Datos</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Instance Name</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Host Name</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Status</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Creada</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Iniciada</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Uptime</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Modo</B></FONT></TD>
prompt </TR>
SELECT  '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||upper(instance_name)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||upper(host_name)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||status||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||created||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(startup_time, 'DD-MON-YYYY HH24:MI:SS')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||trunc(sysdate - (startup_time)) || ' day(s), ' ||
        trunc(24*((sysdate-startup_time) -
                trunc(sysdate-startup_time)))||' hour(s), ' ||
        mod(trunc(1440*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' minute(s), ' ||
        mod(trunc(86400*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' seconds' ||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||log_mode||'</FONT></TD>
	</TR>'
FROM    sys.v_$instance, sys.v_$database;

prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=1>
prompt  <FONT SIZE="4"><B>Database Products and Versions</B></FONT>
prompt  </TD>
prompt </TR>
select '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||banner||'</FONT></TD>
	</TR>'
from   sys.v_$version;

prompt </TABLE><P><HR WIDTH="100%"><P>

-------------------
-- Mapa de Archivos
-------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=2>
prompt  <FONT SIZE="4"><B>Database Files (archive/control/data/logfile)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Filename</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Location</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">Archived Log Directory</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||nvl(value,'&nbsp;')||'</FONT></TD>
	</TR>'
from 	sys.v_$parameter
where 	name = 'log_archive_dest%'
UNION ALL
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">Control Files</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||value||'</FONT></TD>
	</TR>'
from 	sys.v_$parameter
where 	name = 'control_files'
UNION ALL
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">Datafile</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	</TR>'
from 	sys.v_$datafile 
UNION ALL
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">Datafile (Temp File)</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	</TR>'
from 	sys.v_$tempfile 
UNION ALL
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">LogFile Member</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||member||'</FONT></TD>
	</TR>'
from 	sys.v_$logfile;
prompt </TABLE>
prompt <P>

select '<FONT COLOR="#FF0000"><I>Note: You will receive an "ORA-00942: table or view does not exist" error if you are running this against a v8.0.x database.  The SYS.V$_TEMPFILE view is introduced in v8.1.x (script name: dbfiles.sql)</I></FONT>'
from 	dual
where  	0 in (
	select count(*) from dba_views 
	where view_name='V_$TEMPFILE');
prompt <P>

prompt </TABLE><P><HR WIDTH="100%"><P>

-------------------------
-- Tablespace Information
-------------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=13>
prompt  <FONT SIZE="4"><B>Tablespace Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Tablespace<BR>Name (1)</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Initial Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Next Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Min<BR>Extents</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Max<BR>Extents</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Percent<BR>Increase</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Min Ext<BR>Size</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Status</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Contents</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Logging</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Extent<BR>Mgmt</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Allocation<BR>Type</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Plugged<BR>In</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(initial_extent,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||decode(next_extent,NULL,'&nbsp;',to_char(next_extent,'999,999,999,999,999'))||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(min_extents,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||decode(max_extents,NULL,'&nbsp;',to_char(max_extents,'999,999,999,999,999'))||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||decode(pct_increase,NULL,'&nbsp;',decode(pct_increase,0,'0','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||pct_increase||'</FONT>'))||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(min_extlen,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||status||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(contents,'PERMANENT','PERMANENT','<FONT COLOR="#FF0000">'||contents||'</FONT>')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||logging||'<FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||extent_management||'<FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||allocation_type||'<FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||plugged_in||'<FONT></TD>
	</TR>'
from 	dba_tablespaces
order 	by tablespace_name; 

prompt </TABLE><P><HR WIDTH="100%"><P>

---------------------
-- Tablespace Extents
---------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="3"><B>Informacion de extent en Tablespace</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Largest Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Smallest Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Total Free</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Pieces</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(max(bytes),'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(min(bytes),'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(sum(bytes),'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(count(*),'999,999')||'</FONT></TD>
	</TR>'
from 	dba_free_space
group 	by tablespace_name
order   by tablespace_name;

prompt </TABLE><P><HR WIDTH="100%"><P>

-------------------
-- Tablespace Usage
-------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="3"><B>Tablespace(s) con menos del  20% de espacio libre</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Bytes<BR>Allocated</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Bytes Used</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Percent<BR>Used</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Bytes Free</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Percent<BR>Free</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||ddf.tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(ddf.bytes,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char((ddf.bytes-dfs.bytes),'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(round(((ddf.bytes-dfs.bytes)/ddf.bytes)*100,2),'990.90')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.bytes,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(round((1-((ddf.bytes-dfs.bytes)/ddf.bytes))*100,2),'990.90')||'</FONT></TD>
	</TR>'
from 	(select tablespace_name,
	sum(bytes) bytes 
	from dba_data_files 
	group by tablespace_name) ddf,
	(select tablespace_name,
	sum(bytes) bytes 
	from dba_free_space 
	group by tablespace_name) dfs
where 	ddf.tablespace_name=dfs.tablespace_name
and     ((ddf.bytes-dfs.bytes)/ddf.bytes)*100 > 80
order 	by ((ddf.bytes-dfs.bytes)/ddf.bytes) desc;
prompt </TABLE><P><HR WIDTH="100%"><P>


------------
-- Redo Logs
------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=10>
prompt  <FONT SIZE="4"><B>Redo Log Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Member (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Group#</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Thread#</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Sequence#</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Bytes</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Members</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Archived</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Status</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>First Change#</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>First Time</B></FONT></TD>
prompt </TR>
select  '<TR>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||a.member||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||b.group#||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||b.thread#||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||b.sequence#||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(b.bytes,'999,999,999,999,999')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||b.members||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||b.archived||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||b.status||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||b.first_change#||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||decode(b.first_time,NULL,'&nbsp;',b.first_time)||'</FONT></TD>
	</TR>'
from 	sys.v_$logfile a, sys.v_$log b
where  	a.group# = b.group#
order	by a.member;

prompt </TABLE><P><HR WIDTH="100%"><P>


-------------------
-- Buffer Hit Ratio
-------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=4>
prompt  <FONT SIZE="3"><B>Buffer Hit Ratio</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Consistent Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>DB Blk Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Physical Reads</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Hit Ratio</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(decode(name, 'consistent gets',value, 0)),'999,999,999,999,999')||'</FONT></TD>
         <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(decode(name, 'db block gets',value, 0)),'999,999,999,999,999')||'</FONT></TD>
         <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(decode(name, 'physical reads',value, 0)),'999,999,999,999,999')||'</FONT></TD>
         <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||round((sum(decode(name, 'consistent gets',value, 0)) + 
         sum(decode(name, 'db block gets',value, 0)) - sum(decode(name, 'physical reads',value, 0))) /
         (sum(decode(name, 'consistent gets',value, 0))  + sum(decode(name, 'db block gets',value, 0)))  * 100,3)||'</FONT></TD>
	</TR>' 
from sys.v_$sysstat;
prompt </TABLE><P><HR WIDTH="100%"><P>

----------------------------
-- Data Dictionary Hit Ratio
----------------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="3"><B>Hit Ratio del diccionario de datos</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Cache Misses</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Hit Ratio</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(gets),'999,999,999,999,999')||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(getmisses),'999,999,999,999,999')||'</FONT></TD>
   <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||round((1 - (sum(getmisses) / sum(gets))) * 100,3)||'</FONT></TD>
	</TR>' 
from 	sys.v_$rowcache;
prompt </TABLE><P><HR WIDTH="100%"><P>

----------------------------
-- Library Cache Hit Ratio
----------------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="3"><B>Library Cache Hit Ratio</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Executions</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Execution<BR>Hits</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Hit<BR>Ratio</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Misses</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Hit<BR>Ratio</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(pins),'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(pinhits),'999,999,999,999,999')||'</FONT></TD>
   	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||round((sum(pinhits) / sum(pins)) * 100,3)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(sum(reloads),'999,999,999,999,999')||'</FONT></TD>
   	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||round((sum(pins) / (sum(pins) + sum(reloads))) * 100,3)||'</FONT></TD>
	</TR>' 
from 	sys.v_$librarycache;
prompt </TABLE><P><HR WIDTH="100%"><P>

------------------
-- SGA Information
------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="3"><B>Informacion de la SGA</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Value</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1"><B>'||name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(value,'999,999,999,999,999')||'</FONT></TD>
	</TR>'
from 	sys.v_$sga;
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1"><B>TOTAL SGA</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>'||to_char(sum(value),'999,999,999,999,999')||'</B></FONT></TD>
	</TR>'
from 	sys.v_$sga;
prompt </TABLE><P><HR WIDTH="100%"><P>


----------------------
-- Segment Information
----------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=10>
prompt  <FONT SIZE="3"><B>Segmentos con mas de un 50% de Max Extents</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Owner</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Segment<BR>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Segment<BR>Type</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Segment<BR>Size</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Next<BR>Extent</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Pct<BR>Incr</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Current<BR>Extents</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Max<BR>Extents</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Percent</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||owner||'</FONT></TD> 
	<TD><FONT FACE="Arial" SIZE="1">'||tablespace_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||segment_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||segment_type||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(bytes,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(next_extent,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||pct_increase||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||max_extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char((extents/max_extents)*100,'999.90')||'</FONT></TD>
	</TR>'
from 	dba_segments
where 	segment_type in ('TABLE','INDEX')
and 	extents > max_extents/2
order 	by (extents/max_extents) desc;
prompt </TABLE><P><HR WIDTH="100%"><P>

---------------------
-- No Extend (Tables)
---------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=8>
prompt  <FONT SIZE="3"><B>Tablas que no pueden alocar mas de 1 ( un ) Extent</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Owner</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Table Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Next Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Max Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Sum Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Current<BR>Extents</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Avail<BR>Extents</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.tablespace_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.segment_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(ds.next_extent,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.max,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.sum,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||ds.extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||decode(floor(dfs.max/ds.next_extent),0,'<FONT COLOR="#FF0000">0</FONT>',floor(dfs.max/ds.next_extent))||'</FONT></TD>
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
prompt </TABLE><P><HR WIDTH="100%"><P>

----------------------
-- No Extend (Indexes)
----------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=8>
prompt  <FONT SIZE="3"><B>Indices que no pueden alocar mas de 1 ( un ) Extent</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Owner</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Table Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Next Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Max Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Sum Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Current<BR>Extents</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Avail<BR>Extents</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.tablespace_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.segment_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(ds.next_extent,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.max,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.sum,'999,999,999,999,999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||ds.extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||decode(floor(dfs.max/ds.next_extent),0,'<FONT COLOR="#FF0000">0</FONT>',floor(dfs.max/ds.next_extent))||'</FONT></TD>
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
prompt </TABLE><P><HR WIDTH="100%"><P>

---------------------
-- Control de Jobs --
---------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="3"><B>Control de Jobs</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Job</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>log_user</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>last_date</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>next_date</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>broken</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Fallas</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||job||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||log_user||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||last_date||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||next_date||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||broken||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||failures||'</FONT></TD>
	</TR>'
from   	dba_jobs;
prompt </TABLE><P><HR WIDTH="100%"><P>

-----------------------
-- Objetos invalidos --
-----------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="3"><B>Objetos Invalidos</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>owner</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>object_name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>object_type</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||object_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||object_type||'</FONT></TD>
	</TR>'
from   	all_objects 
	where status = 'INVALID';
prompt </TABLE><P><HR WIDTH="100%"><P>

-----------------------------
-- Mapa de Archives diario --
-----------------------------

prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=25>
prompt  <FONT SIZE="4"><B>Redo Log Switch Historia x Hora</B></FONT>
prompt  </TD>
prompt </TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>DAY (1)</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>00</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>01</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>02</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>03</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>04</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>05</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>06</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>07</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>08</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>09</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>10</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>11</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>12</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>13</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>14</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>15</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>16</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>17</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>18</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>19</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>20</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>21</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>22</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>23</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||substr(to_char(first_time,'YYYY/MM/DD'),1,10)||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),0,'-',sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)))||'</FONT></TD>
       </TR>'
from 	sys.v_$log_history
group 	by substr(to_char(first_time,'YYYY/MM/DD'),1,10)
order   by substr(to_char(first_time,'YYYY/MM/DD'),1,10) desc;

prompt </TABLE><P><HR WIDTH="100%"><P>

--------------------------
-- Key init.ora Parameters
--------------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="3"><B>Parametros de Inicio</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Parameter</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Value</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Is Default<B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Session Modifiable</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>System Modifiable</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Is Modified</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||name||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="1">'||nvl(value,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||isdefault||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||isses_modifiable||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||issys_modifiable||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ismodified||'</FONT></TD>
	</TR>' 
from 	sys.v_$parameter
order  	by name;
prompt </TABLE><BR>
spool off


