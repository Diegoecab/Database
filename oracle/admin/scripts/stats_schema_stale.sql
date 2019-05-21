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