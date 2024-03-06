--v$rman_backup_set_details.sql
set pagesize 1000
set feedback off
set heading on
set lines 900
clear breaks
clear col
col set_count heading 'Set Count' for 99999
col backup_type heading 'Bkp Type' for a4
col controlfile_included heading 'Incl Cont File' for a4
col incremental_level heading 'Incr Level' for 9
col pieces heading 'Pieces' for 99
col min heading 'Min' for 9999
col device_type heading 'Dev type' for a10
col compressed heading 'Compressed' for a4
col num_copies heading 'Num Copies' for 9
col compression_ratio heading 'Comp Ratio' for 99,9
col status heading 'Stat' for a1
col day heading 'Day' for a3
col gb heading 'Gb' for 999999
col handle heading 'File Name' for a55 TRUNCATE

Break on set_count on report

compute sum label 'Total GB' of gb on report

Prompt Detalle de backups realizados con RMAN

SELECT a.set_count,
		DECODE (a.backup_type,
               'I', 'Incr',
               'L', 'Arch',
               'D', 'Full'
              ) backup_type,
       a.controlfile_included, a.incremental_level, a.pieces, a.start_time,handle,
       a.completion_time, TO_CHAR (a.start_time, 'Dy') "Day", ROUND (a.elapsed_seconds / 60) MIN, a.device_type,
       a.compressed, num_copies, ROUND (compression_ratio, 1) compression_ratio,
       a.status, ROUND (output_bytes / 1024 / 1024 / 1024) gb
  FROM v$backup_set_details a, v$backup_piece_details b 
  where b.set_count=a.set_count
  and upper(decode (a.backup_type,'I', 'Incr','L', 'Arch','D', 'Full')) like upper('%&bkp_type%')
  and upper(handle) like upper('%&filename%')
  order by a.completion_time;
  
set feedback on