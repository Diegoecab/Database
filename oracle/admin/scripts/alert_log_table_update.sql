--alert_log_table_update
REM    Actualizar los datos de la tabla alert_log
REM ======================================================================
REM alert_log_table_update.sql        Version 1.1    25 Agosto 2011
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
REM ======================================================================
REM
SET serveroutput on
SET feedback off

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
                 VALUES (finicial, r.text);

            COMMIT;

            IF r.text LIKE '%ORA-%'
            THEN
               DBMS_OUTPUT.put_line (   TO_DATE (finicial,
                                                 'dd/mm/yyyy hh24:mi:ss'
                                                )
                                     || ' Error: '
                                     || r.text
                                    );
            ELSE
               DBMS_OUTPUT.put_line (   TO_DATE (finicial,
                                                 'dd/mm/yyyy hh24:mi:ss'
                                                )
                                     || ' Mensaje: '
                                     || r.text
                                    );
            END IF;
         END IF;
      ELSE
         -- alert_Date no es nulo. Hay nueva fecha. No cargo nada pero guardo la fecha
         finicial := r.alert_date;
      END IF;
   END LOOP;
   EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.put_line ( 'Error al actualizar tabla alert_log '||SQLERRM);
END;
/
PROMPT
set feedback on