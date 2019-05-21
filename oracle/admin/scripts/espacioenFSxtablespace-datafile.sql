create table DIEGO_FS nologging AS SELECT tablespace_name, SUBSTR (FILE_NAME, 1, 22) PATH,bytes
          FROM DBA_DATA_FILES
      GROUP BY tablespace_name, file_name, bytes;

TRUNCATE TABLE DIEGO_FS;

INSERT INTO DIEGO_FS
  SELECT tablespace_name, SUBSTR (FILE_NAME, 1, 22) PATH, bytes
          FROM DBA_DATA_FILES
      GROUP BY tablespace_name, file_name, bytes
      union
SELECT tablespace_name, SUBSTR (FILE_NAME, 1, 22) PATH, bytes  FROM DBA_TEMP_FILES group by tablespace_name ,file_name, bytes;

commit;


update diego_fs set bytes=0;

commit;








----


PROCEDURE


set serveroutput on

DECLARE
   CURSOR C1
   IS
        SELECT tablespace_name, SUBSTR (FILE_NAME, 1, 22) PATH, bytes
          FROM DBA_DATA_FILES
      GROUP BY tablespace_name, file_name, bytes;

   totalbytes    VARCHAR2 (100);
   tablespacev   VARCHAR2 (100);
   filesystemv   VARCHAR2 (100);
BEGIN
   FOR r IN c1
   LOOP
      SELECT SUM (BYTES)
        INTO totalbytes
        FROM DBA_DATA_FILES
       WHERE tablespace_name = r.tablespace_name
             AND SUBSTR (FILE_NAME, 1, 22) = r.PATH;

      --SELECT DISTINCT (bytes)
      -- INTO totalbytes
      --        FROM diego_fs
      --     WHERE tablespace_name = r.tablespace_name AND PATH = r.PATH;

      DBMS_OUTPUT.put_line(   'Valor actual para tablespace '
                           || r.tablespace_name
                           || ' y filesystem '
                           || r.PATH
                           || ' : '
                           || totalbytes);

      --totalbytes := totalbytes + r.bytes;

      UPDATE diego_fs
         SET bytes = totalbytes
       WHERE tablespace_name = r.tablespace_name AND PATH = r.PATH;

      --DBMS_OUTPUT.put_line(   'Nuevo valor para tablespace '
      --                   || r.tablespace_name
      --                 || ' y filesystem '
      --               || r.PATH
      --             || ' : '
      --           || totalbytes);

      totalbytes := 0;
      --IF r.tablespace_name != tablespacev AND r.PATH != filesystemv AND tablespacev is not null --Si cambia de tbs o dat y tablespacev esta lleno, imprimo primer registro
      --THEN
      --   totalbytes := totalbytes + r.bytes; --Se cambia pero no imprimo
      --DBMS_OUTPUT.put_line ('estas igual');
      --ELSE --Es el mismo tbs y dat
      --totalbytes := totalbytes + r.bytes; -- Sumo los bytes
      --IF totalbytes IS NOT NULL --Si previamente se sumaron mas bytes, imprimo el total de esos bytes
      --THEN
      --   DBMS_OUTPUT.put_line (
      --    r.tablespace_name || ',' || r.PATH || ',' || totalbytes);
      --totalbytes := NULL;             --Vuelvo a cero los bytes
      --ELSE                           --Previamente no se sumaron bytes
      -- DBMS_OUTPUT.put_line (
      --  r.tablespace_name || ',' || r.PATH || ',' || r.bytes);
      --END IF;
      --filesystemv := r.PATH;
      --tablespacev := r.tablespace_name;
      --END IF;

      --DBMS_OUTPUT.put_line (r.tablespace_name||','||r.path||','||r.bytes);
      COMMIT;
   END LOOP;
END;
/



select distinct pepe from (
select tablespace_name||','||path||','||bytes/1024  pepe from diego_fs ) order by 1
drop table diego_fs;

SELECT TABLESPACE_NAME,SUM(BYTES)/1024 KB FROM DBA_TEMP_FILES where TABLESPACE_NAME='TEMP' GROUP BY tablespace_name ORDER BY tablespace_name

SELECT SUM(BYTES)/1024 KB FROM DBA_TEMP_FILES where TABLESPACE_NAME='TEMP' GROUP BY tablespace_name ORDER BY tablespace_name