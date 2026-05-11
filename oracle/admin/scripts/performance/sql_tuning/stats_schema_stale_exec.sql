-- ------------------------------------------------------------------------------
-- File       : stats_schema_stale_exec.sql
-- Purpose    : Oracle SQL performance and tuning helper: stats schema stale exec.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stats_schema_stale_exec.sql
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
--stats_schema_stale_exec.sql


set serveroutput on

accept OWNER prompt 'Ingrese OWNER: '

DECLARE
 objlist   DBMS_STATS.objecttab;
   BEGIN
      DBMS_OUTPUT.ENABLE (500000000);
      DBMS_STATS.gather_schema_stats (ownname      => '&OWNER',
                                      options      => 'LIST STALE',
                                      objlist      => objlist
                                     );

      IF (objlist.COUNT = 0)
      THEN
         DBMS_OUTPUT.put_line ('No hay objetos para analizar.');
      ELSE
         FOR i IN 1 .. objlist.COUNT
         LOOP
            /*
DBMS_OUTPUT.put_line (   objlist (i).objtype
                                  || ' '
                                  || objlist (i).ownname
                                  || '.'
                                  || objlist (i).objname
                                  || ', partition:'
                                  || objlist (i).partname
                                  || ', sub part.:'
                                  || objlist (i).subpartname
                                 );
*/
DBMS_OUTPUT.put_line (   objlist (i).objname||':'||objlist (i).partname );
/*DBMS_STATS.gather_table_stats
                            (ownname               => '&OWNER',
                             tabname               => objlist (i).objname,
                             estimate_percent      => DBMS_STATS.auto_sample_size,
                             method_opt            => 'FOR ALL COLUMNS SIZE AUTO'
                            );
*/
         END LOOP;
      END IF;
   END;
/