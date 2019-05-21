CREATE TABLE dbas.dbms_stats_table (tipo VARCHAR2(20), owner VARCHAR2(30), comienzo DATE, fin DATE, error VARCHAR2(6), error_desc VARCHAR2 (1000));

CREATE OR REPLACE PACKAGE stats_dbas
IS
   PROCEDURE stats_schemas_all;
END stats_dbas;
/


CREATE OR REPLACE PACKAGE BODY stats_dbas
IS
   PROCEDURE stats_schemas_all
   IS
      begin_date   DATE;
      errorl       VARCHAR2 (1000);
   BEGIN
      FOR r IN (SELECT DISTINCT owner
                           FROM dba_tables
                          WHERE owner NOT IN
                                   ('SYS',
                                    'SYSTEM',
                                    'OUTLN',
                                    'CTXSYS',
                                    'DBSNMP'
                                   ))
      LOOP
         BEGIN
            SELECT SYSDATE
              INTO begin_date
              FROM DUAL;

            DBMS_STATS.gather_schema_stats (r.owner,
                                            DBMS_STATS.auto_sample_size,
                                            CASCADE      => TRUE,
                                            DEGREE       => 3
                                           );

            INSERT INTO dbas.dbms_stats_table
                 VALUES ('SCHEMA', r.owner, begin_date, SYSDATE, 'FALSE', '');

            COMMIT;
         EXCEPTION
            WHEN OTHERS
            THEN
               errorl := SQLERRM;

               INSERT INTO dbas.dbms_stats_table
                    VALUES ('SCHEMA', r.owner, begin_date, SYSDATE, 'TRUE',
                            errorl);

               COMMIT;
         END;
      END LOOP;
   END;
END stats_dbas;
/

BEGIN
   SYS.DBMS_SCHEDULER.create_program
                       (program_name             => 'GATHER_STATS_PROG_GARBA',
                        program_type             => 'STORED_PROCEDURE',
                        program_action           => 'sys.stats_dbas.stats_schemas_all',
                        number_of_arguments      => 0,
                        enabled                  => FALSE,
                        comments                 => 'Calculo de estadisticas de esquemas'
                       );
   SYS.DBMS_SCHEDULER.ENABLE (NAME => 'GATHER_STATS_PROG_GARBA');
END;
/


--Schedule Job

BEGIN
   SYS.DBMS_SCHEDULER.create_job
                           (job_name           => 'GATHER_STATS_JOB_GARBA',
                            schedule_name      => 'SYS.MAINTENANCE_WINDOW_GROUP',
                            program_name       => 'SYS.GATHER_STATS_PROG_GARBA',
                            comments           => 'Calculo de estadisticas de esquemas'
                           );
   SYS.DBMS_SCHEDULER.set_attribute (NAME           => 'GATHER_STATS_JOB_GARBA',
                                     ATTRIBUTE      => 'RESTARTABLE',
                                     VALUE          => TRUE
                                    );
   SYS.DBMS_SCHEDULER.set_attribute (NAME           => 'GATHER_STATS_JOB_GARBA',
                                     ATTRIBUTE      => 'LOGGING_LEVEL',
                                     VALUE          => SYS.DBMS_SCHEDULER.logging_runs
                                    );
   SYS.DBMS_SCHEDULER.set_attribute_null (NAME           => 'GATHER_STATS_JOB_GARBA',
                                          ATTRIBUTE      => 'MAX_FAILURES'
                                         );
   SYS.DBMS_SCHEDULER.set_attribute_null (NAME           => 'GATHER_STATS_JOB_GARBA',
                                          ATTRIBUTE      => 'MAX_RUNS'
                                         );

   BEGIN
      SYS.DBMS_SCHEDULER.set_attribute (NAME           => 'GATHER_STATS_JOB_GARBA',
                                        ATTRIBUTE      => 'STOP_ON_WINDOW_CLOSE',
                                        VALUE          => TRUE
                                       );
   EXCEPTION
      -- could fail if program is of type EXECUTABLE...
      WHEN OTHERS
      THEN
         NULL;
   END;

   SYS.DBMS_SCHEDULER.set_attribute (NAME           => 'GATHER_STATS_JOB_GARBA',
                                     ATTRIBUTE      => 'JOB_PRIORITY',
                                     VALUE          => 2
                                    );
   SYS.DBMS_SCHEDULER.set_attribute_null (NAME           => 'GATHER_STATS_JOB_GARBA',
                                          ATTRIBUTE      => 'SCHEDULE_LIMIT'
                                         );
   SYS.DBMS_SCHEDULER.set_attribute (NAME           => 'GATHER_STATS_JOB_GARBA',
                                     ATTRIBUTE      => 'AUTO_DROP',
                                     VALUE          => FALSE
                                    );
   SYS.DBMS_SCHEDULER.ENABLE (NAME => 'GATHER_STATS_JOB_GARBA');
END;
/

--Schedule Window 


BEGIN
   SYS.DBMS_SCHEDULER.create_window
      (window_name          => 'WEEKDAY_WINDOW',
       start_date           => NULL,
       repeat_interval      => 'freq=daily;byday=MON,TUE,WED,THU,FRI;byhour=8;byminute=0; bysecond=0',
       end_date             => NULL,
       resource_plan        => NULL,
       DURATION             => TO_DSINTERVAL ('+000 12:00:00'),
       window_priority      => 'LOW',
       comments             => 'Ventana de mantenimiento para estadisticas en warehouse, GARDWOP.'
      );
   SYS.DBMS_SCHEDULER.ENABLE (NAME => 'SYS.WEEKDAY_WINDOW');
END;
/