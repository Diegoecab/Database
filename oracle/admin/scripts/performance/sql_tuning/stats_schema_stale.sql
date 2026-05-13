-- ------------------------------------------------------------------------------
-- File       : stats_schema_stale.sql
-- Purpose    : Oracle SQL performance and tuning helper: stats schema stale.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stats_schema_stale.sql
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
--stats_schema_stale.sql


set serveroutput on

accept owner prompt 'ingrese owner: '

declare
 objlist   dbms_stats.objecttab;
   begin
      dbms_output.enable (500000000);
      dbms_stats.gather_schema_stats (ownname      => '&owner',
                                      options      => 'LIST STALE',
                                      objlist      => objlist
                                     );

      if (objlist.count = 0)
      then
         dbms_output.put_line ('no hay objetos para analizar.');
      else
         for i in 1 .. objlist.count
         loop
            /*
dbms_output.put_line (   objlist (i).objtype
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
--dbms_stats.gather_Table_stats ('&owner', objlist (i).objname, cascade => true, degree => 4);
dbms_output.put_line (   objlist (i).objname||':'||objlist (i).partname||':'||objlist (i).subpartname );

         end loop;
      end if;
   end;
/