REM  Control sobre base de datos Oracle
REM ==========================================================================================================================
REM control.sql        Version 1.3    01 Septiembre 2011
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM
REM Dependencias:
REM
REM
REM Notas:
REM     Ejecutar con usuario dba
REM
REM Precauciones:
REM
REM ==========================================================================================================================
REM
REM Cambios
REM 01/09/2011 - Diego Cabrera - Control de errores registrados en el alert log
REM

SET feedback off
SET verify off
SET termout off
SET heading off
SET serveroutput on
ALTER SESSION SET nls_date_format='DD/MM/YYYY HH24:MI:SS';

SPOOL /home/oracle/tmp/control.tmp append

SET linesize 500
SET pagesize 50000

/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Control de uso de espacio en tablespaces                                                                          |
|------------------------------------------------------------------------------------------------------------------------------|
*/

SELECT 'CONTROL', '&1', '&2', 'TBS', 'WARNING',
       'Tablespace ' || NAME || ' pct used: ' || pct_used
  FROM (SELECT NAME, ROUND (alloc) alloc, ROUND (free) free,
               ROUND (alloc - free) used,
               100 - ROUND ((MAX - (alloc - free)) / MAX * 100) pct_used,
                  '  '
               || LPAD (dfs, 2, ' ')
               || ' / '
               || LPAD (AUTO, 2, ' ')
               || ' ' " DFs / Aut",
               DECODE (AUTO, dfs, '   ', 0, '   ', ' X') ctl, MAX max_size,
               maxf max_size_file,
               ROUND (DECODE (MAX, 0, 0, (alloc / MAX) * 100)) pct_max_alloc
          FROM (SELECT   NVL (b.tablespace_name,
                              NVL (a.tablespace_name, 'UNKOWN')
                             ) NAME,
                         alloc, NVL (free, 0) free, AUTO, dfs,
                         NVL (MAX, 0) + NVL (maxn, 0) MAX, NVL (maxf, 0) maxf
                    FROM (SELECT   ROUND (SUM (BYTES) / 1024 / 1024) free,
                                   tablespace_name
                              FROM SYS.dba_free_space
                          GROUP BY tablespace_name) a,
                         (SELECT   SUM (BYTES) / 1024 / 1024 alloc,
                                   SUM (maxbytes) / 1024 / 1024 MAX,
                                   MAX (maxbytes) / 1024 / 1024 maxf,
                                   (SELECT SUM (BYTES) / 1024 / 1024
                                      FROM dba_data_files df3
                                     WHERE df3.tablespace_name =
                                                     df1.tablespace_name
                                       AND df3.autoextensible = 'NO') maxn,
                                   tablespace_name,
                                   (SELECT COUNT (*)
                                      FROM dba_data_files df2
                                     WHERE df2.tablespace_name =
                                                     df1.tablespace_name
                                       AND df2.autoextensible = 'YES') AUTO,
                                   COUNT (*) dfs
                              FROM SYS.dba_data_files df1
                          GROUP BY tablespace_name
                          UNION ALL
                          SELECT   SUM (BYTES) / 1024 / 1024 alloc,
                                   SUM (maxbytes) / 1024 / 1024 MAX,
                                   MAX (maxbytes) / 1024 / 1024 maxf,
                                   (SELECT SUM (BYTES) / 1024 / 1024
                                      FROM dba_temp_files df3
                                     WHERE df3.tablespace_name =
                                                         tablespace_name
                                       AND df3.autoextensible = 'NO') maxn,
                                   tablespace_name,
                                   (SELECT COUNT (*)
                                      FROM dba_temp_files df2
                                     WHERE df2.tablespace_name =
                                                         tablespace_name
                                       AND df2.autoextensible = 'YES') AUTO,
                                   COUNT (*) dfs
                              FROM SYS.dba_temp_files
                          GROUP BY tablespace_name) b
                   WHERE a.tablespace_name(+) = b.tablespace_name
                     AND b.tablespace_name NOT IN UPPER
                                                    ((SELECT VALUE
                                                        FROM v$parameter
                                                       WHERE NAME =
                                                                'undo_tablespace')
                                                    )
                ORDER BY 1))
 WHERE pct_used BETWEEN 86 AND 94
   AND NOT EXISTS (SELECT 1
                     FROM dba_tablespaces
                    WHERE tablespace_name = NAME AND CONTENTS IN
                                                                ('TEMPORARY'))
UNION ALL
SELECT 'CONTROL', '&1', '&2', 'TBS', 'CRITICAL',
       'Tablespace ' || NAME || ' pct used: ' || pct_used
  FROM (SELECT NAME, ROUND (alloc) alloc, ROUND (free) free,
               ROUND (alloc - free) used,
               100 - ROUND ((MAX - (alloc - free)) / MAX * 100) pct_used,
                  '  '
               || LPAD (dfs, 2, ' ')
               || ' / '
               || LPAD (AUTO, 2, ' ')
               || ' ' " DFs / Aut",
               DECODE (AUTO, dfs, '   ', 0, '   ', ' X') ctl, MAX max_size,
               maxf max_size_file,
               ROUND (DECODE (MAX, 0, 0, (alloc / MAX) * 100)) pct_max_alloc
          FROM (SELECT   NVL (b.tablespace_name,
                              NVL (a.tablespace_name, 'UNKOWN')
                             ) NAME,
                         alloc, NVL (free, 0) free, AUTO, dfs,
                         NVL (MAX, 0) + NVL (maxn, 0) MAX, NVL (maxf, 0) maxf
                    FROM (SELECT   ROUND (SUM (BYTES) / 1024 / 1024) free,
                                   tablespace_name
                              FROM SYS.dba_free_space
                          GROUP BY tablespace_name) a,
                         (SELECT   SUM (BYTES) / 1024 / 1024 alloc,
                                   SUM (maxbytes) / 1024 / 1024 MAX,
                                   MAX (maxbytes) / 1024 / 1024 maxf,
                                   (SELECT SUM (BYTES) / 1024 / 1024
                                      FROM dba_data_files df3
                                     WHERE df3.tablespace_name =
                                                     df1.tablespace_name
                                       AND df3.autoextensible = 'NO') maxn,
                                   tablespace_name,
                                   (SELECT COUNT (*)
                                      FROM dba_data_files df2
                                     WHERE df2.tablespace_name =
                                                     df1.tablespace_name
                                       AND df2.autoextensible = 'YES') AUTO,
                                   COUNT (*) dfs
                              FROM SYS.dba_data_files df1
                          GROUP BY tablespace_name
                          UNION ALL
                          SELECT   SUM (BYTES) / 1024 / 1024 alloc,
                                   SUM (maxbytes) / 1024 / 1024 MAX,
                                   MAX (maxbytes) / 1024 / 1024 maxf,
                                   (SELECT SUM (BYTES) / 1024 / 1024
                                      FROM dba_temp_files df3
                                     WHERE df3.tablespace_name =
                                                         tablespace_name
                                       AND df3.autoextensible = 'NO') maxn,
                                   tablespace_name,
                                   (SELECT COUNT (*)
                                      FROM dba_temp_files df2
                                     WHERE df2.tablespace_name =
                                                         tablespace_name
                                       AND df2.autoextensible = 'YES') AUTO,
                                   COUNT (*) dfs
                              FROM SYS.dba_temp_files
                          GROUP BY tablespace_name) b
                   WHERE a.tablespace_name(+) = b.tablespace_name
                     AND b.tablespace_name NOT IN UPPER
                                                    ((SELECT VALUE
                                                        FROM v$parameter
                                                       WHERE NAME =
                                                                'undo_tablespace')
                                                    )
                ORDER BY 1))
 WHERE pct_used >= 95
   AND NOT EXISTS (
            SELECT 1
              FROM dba_tablespaces
             WHERE tablespace_name = NAME
                   AND CONTENTS IN ('UNDO', 'TEMPORARY'))
/
/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Tamaño tabla Auditoria                                                                                            |
|------------------------------------------------------------------------------------------------------------------------------|
*/

SELECT   'CONTROL', '&1', '&2', 'AUD', 'WARNING',
            'Tamaño tabla auditoría (AUD$): '
         || ROUND (SUM (BYTES) / 1024 / 1024, 2)
         || ' M'
    FROM dba_segments
   WHERE segment_name = 'AUD$'
GROUP BY segment_name
  HAVING ROUND (SUM (BYTES) / 1024 / 1024, 2) >= 250
/
/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Record keep time en 15 días, si la base esta en archivelog                                                        |
|------------------------------------------------------------------------------------------------------------------------------|
*/

COL sql format a100
SELECT 'CONTROL', '&1', '&2', 'KEEP', 'WARNING',
       'Valor parámetro ' || NAME || ' <> 15: ' || VALUE SQL
  FROM v$parameter
 WHERE NAME = 'control_file_record_keep_time'
   AND VALUE <> '15'
   AND EXISTS (SELECT 1
                 FROM v$database
                WHERE log_mode = 'ARCHIVELOG')
/
/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Block Change Tracking, si esta habilidado archivo de logs                                                         |
|------------------------------------------------------------------------------------------------------------------------------|
*/


COL sql format a100
SELECT 'CONTROL', '&1', '&2', 'BCT', 'WARNING',
       'Block Change Tracking DISABLED' SQL
  FROM v$block_change_tracking
 WHERE status <> 'ENABLED' AND EXISTS (SELECT 1
                                         FROM v$database
                                        WHERE log_mode = 'ARCHIVELOG')
/
/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Job deshabilitado                                                                                                 |
|------------------------------------------------------------------------------------------------------------------------------|
*/

SELECT 'CONTROL', '&1', '&2', 'JOB', 'WARNING',
       'Broken Jobs: ' || aux.cantidad SQL
  FROM (SELECT COUNT (*) cantidad
          FROM dba_jobs
         WHERE broken = 'Y') aux
 WHERE aux.cantidad > 0
/
/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Error en ejecución de JOB                                                                                         |
|------------------------------------------------------------------------------------------------------------------------------|
*/

SELECT 'CONTROL', '&1', '&2', 'JOB2', 'WARNING',
       'Execution Error Jobs: ' || cantidad SQL
  FROM (SELECT COUNT (*) cantidad
          FROM dba_jobs
         WHERE failures > 0 AND broken = 'N') aux
 WHERE aux.cantidad > 0
/
/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Objetos invalidos                                                                                                 |
|------------------------------------------------------------------------------------------------------------------------------|
*/

DECLARE
   inv    NUMBER;
   inv2   NUMBER;
BEGIN
   SELECT cantidad
     INTO inv
     FROM (SELECT COUNT (*) cantidad
             FROM dba_objects
            WHERE status <> 'VALID') aux
    WHERE aux.cantidad > 0
      AND EXISTS (
             SELECT 1
               FROM v$instance
              WHERE instance_name LIKE '%OP');

   IF inv > 0
   THEN
      FOR cur_rec IN
         (SELECT   owner, object_type, object_name
              FROM dba_objects
             WHERE status <> 'VALID'
          ORDER BY 1, 2, 3)
      LOOP
         BEGIN
            IF cur_rec.object_type = 'PACKAGE BODY'
            THEN
               EXECUTE IMMEDIATE    'ALTER PACKAGE "'
                                 || cur_rec.owner
                                 || '"."'
                                 || cur_rec.object_name
                                 || '" COMPILE BODY';
            ELSE
               EXECUTE IMMEDIATE    'ALTER '
                                 || cur_rec.object_type
                                 || ' "'
                                 || cur_rec.owner
                                 || '"."'
                                 || cur_rec.object_name
                                 || '" COMPILE';
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               NULL;
         END;
      END LOOP;
   END IF;

   BEGIN
      SELECT cantidad
        INTO inv2
        FROM (SELECT COUNT (*) cantidad
                FROM dba_objects
               WHERE status <> 'VALID') aux
       WHERE aux.cantidad > 0 AND EXISTS (SELECT 1
                                            FROM v$instance
                                           WHERE instance_name LIKE '%OP');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;

   IF inv2 > 0
   THEN
      DBMS_OUTPUT.put_line
                         (   'CONTROL &1 &2 OBJ WARNING Objetos invalidos : '
                          || inv2
                          || '.  No se pudo recompilar el/los objetos'
                         );
   ELSE
      DBMS_OUTPUT.put_line
                    (   'CONTROL &1 &2 OBJ NOTIFICATION Objetos invalidos : '
                     || inv
                     || '.  Objetos compilados correctamente'
                    );
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
END;
/

/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Sesiones activas durante mas de cierto tiempo                                                                     |
|------------------------------------------------------------------------------------------------------------------------------|
*/

BEGIN
   FOR i IN
      (SELECT s.username, machine, s.SID, s.serial#, status,
              ROUND (last_call_et / 60) min_inac,
              TO_CHAR (logon_time, 'DD/MM HH24:MI:SS') logon_time,
              FLOOR (last_call_et / 60) last_act, p.spid
         FROM v$process p, v$session s
        WHERE s.paddr = p.addr
          AND s.username IS NOT NULL
          AND s.status = 'ACTIVE'
          AND ROUND (last_call_et / 60) > 60
          AND NOT EXISTS (
                 SELECT 1
                   FROM v$session_longops h
                  WHERE h.SID = s.SID
                    AND h.serial# = s.serial#
                    AND UPPER (h.MESSAGE) LIKE 'GATHER%STATIS%'
                    AND sofar <> totalwork
                    AND time_remaining <> '0'))
   LOOP
      IF i.min_inac < 120
      THEN
         DBMS_OUTPUT.put_line (   'CONTROL &1 &2 OBJ WARNING El usuario '
                               || i.username
                               || ' con sid|serial '
                               || i.SID
                               || '|'
                               || i.serial#
                               || ' esta activa hace '
                               || i.min_inac
                               || ' minutos. '
                              );
      ELSE
         DBMS_OUTPUT.put_line (   'CONTROL &1 &2 OBJ CRITICAL El usuario '
                               || i.username
                               || ' con sid|serial '
                               || i.SID
                               || '|'
                               || i.serial#
                               || ' esta activa hace '
                               || i.min_inac
                               || ' minutos.'
                              );
      END IF;
   END LOOP;
END;
/

/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Uso de spfile                                                                                                     |
|------------------------------------------------------------------------------------------------------------------------------|
*/

SELECT 'CONTROL', '&1', '&2', 'SPF', 'WARNING',
       'No está definido el spfile' SQL
  FROM v$parameter
 WHERE NAME = 'spfile' AND VALUE IS NULL
/

/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Control de cantida de procesos                                                                                    |
|------------------------------------------------------------------------------------------------------------------------------|
*/

SELECT 'CONTROL', '&1', '&2', 'SPF', 'WARNING',
          'proc: '
       || proc
       || ' sess: '
       || sess
       || ' - max_proc: '
       || max_proc
       || ' max_sess: '
       || max_sess
  FROM (SELECT (SELECT COUNT (*)
                  FROM v$process) proc, (SELECT COUNT (*)
                                           FROM v$session) sess,
               (SELECT TO_NUMBER (VALUE)
                  FROM v$parameter
                 WHERE NAME = 'processes') max_proc,
               (SELECT TO_NUMBER (VALUE)
                  FROM v$parameter
                 WHERE NAME = 'sessions') max_sess
          FROM DUAL) aux
 WHERE (proc / max_proc > 0.8) OR (sess / max_sess > 0.8)
UNION ALL
SELECT 'CONTROL', '&1', '&2', 'SPF', 'CRITICAL',
          'proc: '
       || proc
       || ' sess: '
       || sess
       || ' - max_proc: '
       || max_proc
       || ' max_sess: '
       || max_sess SQL
  FROM (SELECT (SELECT COUNT (*)
                  FROM v$process) proc, (SELECT COUNT (*)
                                           FROM v$session) sess,
               (SELECT TO_NUMBER (VALUE)
                  FROM v$parameter
                 WHERE NAME = 'processes') max_proc,
               (SELECT TO_NUMBER (VALUE)
                  FROM v$parameter
                 WHERE NAME = 'sessions') max_sess
          FROM DUAL) aux
 WHERE (proc / max_proc > 0.95) OR (sess / max_sess > 0.95)
/

/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Control de uso de tablespace de UNDO                                                                              |
|------------------------------------------------------------------------------------------------------------------------------|
*/

BEGIN
   FOR i IN
      (SELECT *
         FROM (SELECT ROUND
                         (  (  (SELECT (NVL (SUM (BYTES), 0))
                                  FROM dba_undo_extents
                                 WHERE UPPER (tablespace_name) =
                                          UPPER ((SELECT VALUE
                                                    FROM v$parameter
                                                   WHERE NAME =
                                                             'undo_tablespace')
                                                )
                                   AND status IN ('ACTIVE', 'UNEXPIRED'))
                             * 100
                            )
                          / (SELECT SUM (BYTES)
                               FROM dba_data_files
                              WHERE UPPER (tablespace_name) =
                                       UPPER ((SELECT VALUE
                                                 FROM v$parameter
                                                WHERE NAME = 'undo_tablespace')))
                         ) "PCT_INUSE",
                      (SELECT VALUE
                         FROM v$parameter
                        WHERE NAME = 'undo_tablespace') tbs
                 FROM DUAL))
   LOOP
      IF i.pct_inuse > 85 AND i.pct_inuse < 95
      THEN
         DBMS_OUTPUT.put_line
                          (   'CONTROL &1 &2 TBS WARNING Tablespace de UNDO '
                           || i.tbs
                           || ' pct used: '
                           || i.pct_inuse
                          );
      ELSIF i.pct_inuse > 95
      THEN
         DBMS_OUTPUT.put_line (   'CONTROL &1 &2 TBS CRITICAL Tablespace '
                               || i.tbs
                               || ' pct used: '
                               || i.pct_inuse
                              );
      END IF;
   END LOOP;
END;
/

/*
|------------------------------------------------------------------------------------------------------------------------------|
|            Verificar errores en alert log                                                                                    |
|------------------------------------------------------------------------------------------------------------------------------|
*/

DECLARE
   finicial   DATE;
   maxdate    DATE;
   sqlt       VARCHAR2 (5000);
BEGIN
   finicial := TO_DATE ('01/01/2001 01:01:01', 'dd/mm/yyyy hh24:mi:ss');

   SELECT MAX (alert_date)
     INTO maxdate
     FROM alert_log;

   IF maxdate IS NULL
   THEN
      maxdate := TO_DATE ('01/01/2001 01:01:01', 'dd/mm/yyyy hh24:mi:ss');
   END IF;

   FOR r IN
      (SELECT *
         FROM (SELECT ROWNUM rnum, dbas.alert_log_date (text) alert_date,
                      text
                 FROM alert_log_disk)
        WHERE rnum > (SELECT MAX (ROWNUM) - 1000
                        FROM alert_log_disk)
          AND text NOT LIKE '%offlining%'
          AND text NOT LIKE 'ARC_:%'
          AND text NOT LIKE '%LOG_ARCHIVE_DEST_1%'
          AND text NOT LIKE '%Thread 1 advanced to log sequence%'
          AND text NOT LIKE '%Thread 1 cannot allocate new log%'
          AND text NOT LIKE '%Current log#%seq#%mem#%'
          AND text NOT LIKE '%Undo Segment%lined%'
          AND text NOT LIKE '%alter tablespace%back%'
          AND text NOT LIKE '%Log actively being archived by another process%'
          AND text NOT LIKE '%alter database backup controlfile to trace%'
          AND text NOT LIKE '%Created Undo Segment%'
          AND text NOT LIKE '%started with pid%'
          AND text NOT LIKE '%ALTER SYSTEM ARCHIVE LOG%'
          AND text NOT LIKE '%coalesce%'
          AND text NOT LIKE '%Beginning log switch checkpoint up to RBA%'
          AND text NOT LIKE '%Completed checkpoint up to RBA%'
          AND text NOT LIKE '%specifies an obsolete parameter%'
          AND text NOT LIKE '%BEGIN BACKUP%'
          AND text NOT LIKE '%Checkpoint not complete%'
          AND text NOT LIKE '%Private strand flush not complete%'
          AND text NOT LIKE '%END BACKUP%'
          AND text NOT LIKE '%to execute - SYS.%'
          AND text NOT LIKE '%kupprdp: worker process DW%')
   --Ultimas 1000 lineas. Tarda aprox 13 segundos
   LOOP
      IF r.alert_date IS NULL
      THEN
         --Alert date es nulo. Tal vez se cargo algun registro anteriormente. Me fijo si es mayor a la mayor fecha de la tabla alert_log
         IF finicial > maxdate
         THEN                     --Ya se cargo en algun momento la variable.
            INSERT INTO alert_log
                 VALUES (finicial, TO_CHAR (SUBSTR (r.text, 1, 2000)));

            COMMIT;

            IF r.text LIKE '%ORA-%'
            THEN
               DBMS_OUTPUT.put_line
                      (   'CONTROL &1 &2 ALERT WARNING Error en alert log : '
                       || finicial
                       || ', '
                       || TO_CHAR (SUBSTR (r.text, 1, 100))
                      );
            END IF;
         END IF;
      ELSE
         -- alert_Date no es nulo. Hay nueva fecha. No cargo nada pero guardo la fecha
         finicial := r.alert_date;
      END IF;
   END LOOP;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line
                          (   'Error al actualizar tabla alert_log en &1 &2 '
                           || SQLERRM
                          );
END;
/

EXIT