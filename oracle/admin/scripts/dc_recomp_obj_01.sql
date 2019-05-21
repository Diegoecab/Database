rem -----------------------------------------------------------------------
rem Script:     Recompila todos los objetos invalidos de la base de datos y
rem             muestra el error de recompilacion si la hubiera.
rem Notas:      Se podria ejecutar varias veces el script para compilar 
rem		dependencias de objetos invalidos.
rem		Se puede realizar un spool a archivo para guardar los
rem		errores si lo hubiera.
rem Fecha:      11-Feb-2009
rem Autor:     	Diego Cabrera
rem -----------------------------------------------------------------------


SET SERVEROUTPUT ON SIZE 1000000
BEGIN
  FOR cur_rec IN (SELECT owner, object_name, object_type,
                   DECODE(object_type, 'PACKAGE', 1,'PACKAGE BODY', 2, 2) AS recompile_order
                  FROM   dba_objects
                  WHERE  object_type IN ('PACKAGE', 'PACKAGE BODY') AND status != 'VALID'
                  ORDER BY 4)             
  LOOP
    BEGIN
      IF cur_rec.object_type = 'PACKAGE' THEN
        EXECUTE IMMEDIATE 'ALTER ' || cur_rec.object_type || 
            ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
      ElSE
        EXECUTE IMMEDIATE 'ALTER PACKAGE "' || cur_rec.owner || 
            '"."' || cur_rec.object_name || '" COMPILE BODY';
      END IF; 
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(cur_rec.object_type || ':' || cur_rec.owner || 
                             '.' || cur_rec.object_name||'.
          Error:');
                FOR cur_rec_3 IN (SELECT line,text from dba_errors where owner=cur_rec.owner and type=cur_rec.object_type and name=cur_rec.object_name order by sequence)
            LOOP
            BEGIN
                    DBMS_OUTPUT.put_line(cur_rec_3.line||'          '||cur_rec_3.text);
            END;
            END LOOP;
    END;
  END LOOP;
  FOR cur_rec_2 IN (SELECT owner, object_name, object_type,
                   object_type AS recompile_order
                  FROM   dba_objects
                   WHERE  object_type IN ('PROCEDURE','TRIGGER') AND status !='VALID'                 
                  ORDER BY 4 )
                  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'ALTER ' || cur_rec_2.object_type || 
            ' "' || cur_rec_2.owner || '"."' || cur_rec_2.object_name || '" COMPILE';
             
    EXCEPTION
      WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(cur_rec_2.object_type || ':' || cur_rec_2.owner || 
                             '.' || cur_rec_2.object_name||'.
          Error:');
                                FOR cur_rec_4 IN (SELECT line,text from dba_errors where owner=cur_rec_2.owner and type=cur_rec_2.object_type and name=cur_rec_2.object_name order by sequence)
            LOOP
            BEGIN
                    DBMS_OUTPUT.put_line(cur_rec_4.line||'          '||cur_rec_4.text);
            END;
            END LOOP;
    END;
  END LOOP;   
                  
END;
/


