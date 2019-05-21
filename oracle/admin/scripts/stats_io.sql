col FS for a40
col filename for a60
set pagesize 5000
set feedback off
set trimspool on


--AVG Por datafile, por día
ttitle 'AVG Por datafile, por día'
SELECT
         --begin_interval_time,
         TRUNC (begin_interval_time) fecha, filename,
         ROUND (AVG (phyrds)) prom_lecfis, ROUND (AVG (phywrts)) prom_phywrts
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TRUNC (begin_interval_time), filename
ORDER BY 1;

--AVG Por FileSystem por día
ttitle 'AVG Por FileSystem por día'
SELECT
         --begin_interval_time,
         TRUNC (begin_interval_time) fecha,
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                ) fs,
         ROUND (AVG (phyrds)) prom_lecfis, ROUND (AVG (phywrts)) prom_escfis
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TRUNC (begin_interval_time),
         SUBSTR (filename,
                 1,
                 REGEXP_INSTR (filename, '/', INSTR (filename, '/', -1)) - 1
                )
ORDER BY 1;


--AVG Por Tablespace, por día
ttitle 'AVG Por Tablespace, por día'
SELECT
         --begin_interval_time,
         TRUNC (begin_interval_time) fecha, tsname,
         ROUND (AVG (phyrds)) prom_lecfis, ROUND (AVG (phywrts)) prom_escfis
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TRUNC (begin_interval_time), tsname
ORDER BY 1;


--AVG Por Tablespace, por mes
ttitle 'AVG Por Tablespace, por mes'
SELECT
         --begin_interval_time,
         TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY') fecha, tsname,
         ROUND (AVG (phyrds)) prom_lecfis, ROUND (AVG (phywrts)) prom_escfis
    FROM dba_hist_filestatxs NATURAL JOIN dba_hist_snapshot
GROUP BY TO_CHAR (TRUNC (begin_interval_time, 'MM'), 'MM/YYYY'), tsname
ORDER BY 1;



--AVG Por FileSystem por mes
ttitle 'AVG Por FileSystem por mes'
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