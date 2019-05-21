CREATE OR REPLACE PACKAGE SYS.stats_dbas
IS
   PROCEDURE stats_schemas_all;
   PROCEDURE stats_gar_dw_full;
END stats_dbas;
/

CREATE OR REPLACE PACKAGE BODY SYS.stats_dbas
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

   PROCEDURE stats_gar_dw_full
   IS
      begin_date   DATE;
      errorl       VARCHAR2 (1000);
   BEGIN
      SELECT SYSDATE
        INTO begin_date
        FROM DUAL;

      DBMS_STATS.gather_schema_stats
                                   ('GAR_DW',
                                    estimate_percent      => 100,
                                    CASCADE               => TRUE,
                                    method_opt            => 'FOR ALL COLUMNS SIZE AUTO',
                                    DEGREE                => 3
                                   );

      INSERT INTO dbas.dbms_stats_table
           VALUES ('SCHEMA', 'GAR_DW', begin_date, SYSDATE, 'FALSE', '');

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         errorl := SQLERRM;

         INSERT INTO dbas.dbms_stats_table
              VALUES ('SCHEMA', 'GAR_DW', begin_date, SYSDATE, 'TRUE',
                      errorl);

         COMMIT;
   END;
END stats_dbas;
/