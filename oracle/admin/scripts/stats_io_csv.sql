col FS for a40
col filename for a60
set pagesize 0   -- only one header row
set feedback off
set sqlprompt ''
set trimspool on -- remove trailing blanks
set pagesize 0
set echo off
set colsep ,     -- separate columns with a comma


spool c:\stats_io_df_dia.csv append
--AVG Por datafile, por día
ttitle 'AVG Por datafile, por día'
SELECT
         --begin_interval_time,
         TRUNC (begin_interval_time)||','||filename||','||
         ROUND (AVG (phyrds)) ||','|| ROUND (AVG (phywrts)) avg_phywrts
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TRUNC (begin_interval_time), filename
ORDER BY 1;
spool off

spool c:\stats_io_fs_dia.csv append
--AVG Por FileSystem por día
ttitle 'AVG Por FileSystem por día'
SELECT
         --begin_interval_time,
         TRUNC (begin_interval_time)||','||
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                )||','||
         ROUND (AVG (phyrds)) ||','|| ROUND (AVG (phywrts)) avg_phywrts
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TRUNC (begin_interval_time),
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                )
ORDER BY 1;
spool off

spool c:\stats_io_ts_dia.csv append
--AVG Por Tablespace, por día
ttitle 'AVG Por Tablespace, por día'
SELECT
         --begin_interval_time,
         TRUNC (begin_interval_time)||','|| tsname||','||
         ROUND (AVG (phyrds)) ||','||ROUND (AVG (phywrts)) avg_phywrts
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TRUNC (begin_interval_time), tsname
ORDER BY 1;
spool off

spool c:\stats_io_ts_mes.csv append
--AVG Por Tablespace, por mes
ttitle 'AVG Por Tablespace, por mes'
SELECT
         --begin_interval_time,
         TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY')||','|| tsname||','||
         ROUND (AVG (phyrds)) ||','||ROUND (AVG (phywrts)) avg_phywrts
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY'), tsname
ORDER BY 1;
spool off

spool c:\stats_io_fs_mes.csv append
--AVG Por FileSystem por mes
ttitle 'AVG Por FileSystem por mes'
SELECT
         TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY')||','||
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                )||','||
         ROUND (AVG (phyrds)) ||','||ROUND (AVG (phywrts)) avg_phywrts
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY'),
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                )
ORDER BY 1;
spool off
set feedback on
SET sqlprompt '&_date | &_user@&_connect_identifier > '