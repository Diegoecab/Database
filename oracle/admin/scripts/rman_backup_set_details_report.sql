-- +----------------------------------------------------------------------------+
-- |                          Diego Cabrera	                                    |
-- |                      diego.ecab@gmail.com	                                |
-- |                         www.oracle-admin.com                               |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2007 Diego Cabrera	   . All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : v$rman_backup_set_details_report.sql                            |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : This SQL script provides a detailed report (in HTML format) on  |
-- | VERSION  : This script was designed for Oracle10g.                         |
-- | USAGE    :                                                                 |
-- |                                                                            |
-- |sqlplus -s <dba>/<password> @rman_backup_set_details_report.sql 			|
-- |                                                                            |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

--

--

-- +----------------------------------------------------------------------------+
-- |                   VAR								                        |
-- +----------------------------------------------------------------------------+

define repHeader="<font size=+2 color=darkgreen><b>Detalle de backups realizados con RMAN</b></font><hr>Copyright (c) 2011-2012 Diego Cabrera. All rights reserved. (<a target=""_blank"" href=""http://oracle-admin.com"">www.oracle-admin.com</a>)<p>"
define dbinf = '<table width="50%" border="1"><tr><th scope="col">Instance</th><th scope="col">Version</th><th scope="col">Host Name</th></tr>'
define filen=rman_backup_set_details

alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
prompt
accept DIR_SPOOL prompt 'Ingrese directorio donde se generará el reporte: '

set pagesize 1000
set feedback off
set heading off
set verify       off
set echo         off
set termout      off

-- +----------------------------------------------------------------------------+
-- |                   GATHER DATABASE REPORT INFORMATION                       |
-- +----------------------------------------------------------------------------+

COLUMN dbname NEW_VALUE _dbname NOPRINT
COLUMN version NEW_VALUE _version NOPRINT
COLUMN hostname NEW_VALUE _hostname NOPRINT
SELECT instance_name dbname, version, host_name hostname  FROM v$instance;

clear buffer computes columns breaks screen

col set_count heading 'Set Count' for 99999
col backup_type heading 'Bkp Type' for a4
col controlfile_included heading 'Incl Cont File' for a4
col incremental_level heading 'Incr Level' for 9
col pieces heading 'Pieces' for 99
col min heading 'Min' for 9999
col device_type heading 'Dev type' for a7
col compressed heading 'Compressed' for a4
col num_copies heading 'Num Copies' for 9
col compression_ratio heading 'Comp Ratio' for 99,9
col status heading 'Stat' for a1
col day heading 'Day' for a3
col mb heading 'Mb' for 999999
col comments heading 'Comments' for a15
col tag heading 'Tag' for a8
col handle heading 'Archivo'
col start_time heading 'Start Time'
col completion_time heading 'Completion Time'
col instance_name heading 'Instance Name' for a8
col version heading 'Version' for a8
col host_name heading 'Host Name' for a10

Break on set_count on report
compute sum label 'Total MB' of mb on report


set heading on

--Def html

set markup html on spool on preformat off entmap on -
head ' -
  <title>Backups realizados con RMAN</title> -
  <style type="text/css"> -
    body              {font:9pt Arial,Helvetica,sans-serif; color:black; background:White;} -
    p                 {font:11pt Arial,Helvetica,sans-serif; color:darkgreen; background:White;} -
    table,tr,td       {font:10pt Arial,Helvetica,sans-serif; color:Black; background:#FFFFFF; border-width: 1px; border-spacing: 0px; border-style: inset; border-collapse: collapse;  } -
    th                {font:bold 9pt Arial,Helvetica,sans-serif; color:#336699; background:#FFFFCC; border-width: 1px; border-spacing: 0px; border-style: inset; border-collapse: collapse; } -
    h1                {font:bold 12pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; border-bottom:0px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;} -
    h2                {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:0pt; margin-bottom:0pt;} -
    a                 {font:9pt Arial,Helvetica,sans-serif; color:#663300; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.link            {font:9pt Arial,Helvetica,sans-serif; color:#663300; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.noLink          {font:9pt Arial,Helvetica,sans-serif; color:#663300; text-decoration: none; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.noLinkBlue      {font:9pt Arial,Helvetica,sans-serif; color:#0000ff; text-decoration: none; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.noLinkDarkBlue  {font:9pt Arial,Helvetica,sans-serif; color:#000099; text-decoration: none; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.noLinkRed       {font:9pt Arial,Helvetica,sans-serif; color:#ff0000; text-decoration: none; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.noLinkDarkRed   {font:9pt Arial,Helvetica,sans-serif; color:#990000; text-decoration: none; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.noLinkGreen     {font:9pt Arial,Helvetica,sans-serif; color:#00ff00; text-decoration: none; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
    a.noLinkDarkGreen {font:9pt Arial,Helvetica,sans-serif; color:#009900; text-decoration: none; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
  </style>' -
body   'BGCOLOR="#C0C0C0"' -
table  'WIDTH="120%" BORDER="1"' 

------

spool &DIR_SPOOL\rman_backup_set_details_report.html

set markup html on entmap off
prompt &repHeader

set markup html off

prompt &dbinf
set heading off
set feedback off
SELECT '<tr><td>'||instance_name||'</td><td>'||version||'</td><td>'||host_name||'</td></tr>' FROM v$instance;

prompt </table>
prompt <p>
prompt Configuracion de RMAN

set heading on
set markup html on entmap off

SELECT name "Name",value "Value" FROM V$RMAN_CONFIGURATION;

prompt Listado total de backups

SELECT a.set_count,
		DECODE (a.backup_type,
               'I', 'Incr',
               'L', 'Arch',
               'D', 'Full'
              ) backup_type,
       a.controlfile_included, a.incremental_level, a.pieces, a.start_time,
       a.completion_time, TO_CHAR (a.start_time, 'Dy') "Day", ROUND (a.elapsed_seconds / 60) MIN, a.device_type,
       a.compressed, a.num_copies, ROUND (a.compression_ratio, 1) compression_ratio,
       a.status, b.handle, b.tag, b.comments, ROUND (a.output_bytes / 1024 / 1024) mb
  FROM v$backup_set_details a join  v$backup_piece_details b on b.set_count=a.set_count
  order by a.set_count;

prompt Listado de backupset
  
SELECT a.set_count,
		DECODE (a.backup_type,
               'I', 'Incr',
               'L', 'Arch',
               'D', 'Full'
              ) backup_type,
       a.controlfile_included, a.incremental_level, a.pieces, a.start_time,
       a.completion_time, TO_CHAR (a.start_time, 'Dy') "Day", ROUND (a.elapsed_seconds / 60) MIN, a.device_type,
       a.compressed, a.num_copies, ROUND (a.compression_ratio, 1) compression_ratio,
       a.status, b.handle, b.tag, b.comments, ROUND (a.output_bytes / 1024 / 1024) mb
  FROM v$backup_set_details a join  v$backup_piece_details b on b.set_count=a.set_count where a.backup_type <> 'L' and a.incremental_level is not null
  order by a.set_count;
  
set feedback on

spool off
set markup html off
set termout on
clear buffer computes columns breaks screen