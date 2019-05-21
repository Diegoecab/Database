REM stats_io_fs_mes.sql
col FS for a40
col filename for a60
set pagesize 5000
set trimspool on
Break on mes skip 1 on report
comp sum of prom_lecfis prom_escfis on mes
set heading off
set feedback off
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
--AVG Por FileSystem por mes
prompt
prompt Fecha desde:
select min (begin_interval_time) from dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot;
prompt
prompt Fecha hasta:
select max (begin_interval_time) from dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot;
ttitle 'Promedio lecto-escritura x FileSystem x Snapshots x fecha desde a fecha hasta'
set heading on
set feedback off

SELECT
         TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY') mes,
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                ) fs,
         ROUND (AVG (phyrds)) prom_lecfis, ROUND (AVG (phywrts)) prom_escfis
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
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