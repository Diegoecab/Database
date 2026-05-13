-- ------------------------------------------------------------------------------
-- File       : stats_dbas_package.sql
-- Purpose    : Oracle SQL performance and tuning helper: stats dbas package.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stats_dbas_package.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
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