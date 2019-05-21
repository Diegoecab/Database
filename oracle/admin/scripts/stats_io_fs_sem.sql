REM stats_io_fs_sem.sql
col FS for a40
col filename for a60
set pagesize 5000
set trimspool on
Break on csum skip 1 on report
comp sum of prom_lecfis prom_escfis on csum
set heading off
set feedback off
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
--AVG Por FileSystem por mes
prompt
set serveroutput on
declare
fmin date;
fmax date;
begin
select min (begin_interval_time) into fmin from dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot where begin_interval_time > sysdate - 7;
select max (begin_interval_time) into fmax from dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot;
dbms_output.put_line('Fecha desde: '||fmin);
dbms_output.put_line('Fecha hasta: '||fmax);
end;
/
set heading on
set feedback off

SELECT
         '' csum,
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                ) fs,
         ROUND (AVG (phyrds)) prom_lecfis, ROUND (AVG (phywrts)) prom_escfis
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
	where begin_interval_time > sysdate - 7
GROUP BY TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY'),
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                )
ORDER BY 1;

set feedback on
ttitle off
clear breaks
clear comp