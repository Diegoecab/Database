CREATE TABLESPACE DBA DATAFILE '/u21/oradata/gardw/dba_01.dbf' size 50M;

CREATE USER DBAs Identified by dbas_garba_1485
default tablespace DBA;

GRANT DBA TO DBAs;

grant select on dba_data_files to DBAs;

grant select on dba_temp_files to DBAs;

grant select on dba_segments to DBAs;

/*
CREATE USER DCABRERA identified by diegoecabrera default tablespace USERS;

GRANT DBA TO dcabrera;
*/

---------------------------------


CREATE TABLE DBAS.ctrl_espacio (fecha DATE, tot_segments NUMBER,
tot_datafiles NUMBER,
tot_tempfiles NUMBER)
tablespace DBA
PCTFREE 1 COMPRESS
/

CREATE TABLE dbas.ctrl_espacio_esq (fecha DATE,
owner VARCHAR2 (30),
tot_segments_dats NUMBER,
tot_segments_indx NUMBER)
TABLESPACE DBA
PCTFREE 1 COMPRESS
/


CREATE OR REPLACE PROCEDURE dbas.check_space
AS
   CURSOR dfiles
   IS
      SELECT ROUND (SUM (df.BYTES / 1024 / 1024 / 1024), 1) gb
        FROM dba_data_files df;

   CURSOR tfiles
   IS
      SELECT ROUND (SUM (tf.BYTES / 1024 / 1024 / 1024), 1) gb
        FROM dba_temp_files tf;

   CURSOR segments
   IS
      SELECT ROUND (SUM (BYTES) / 1024 / 1024 / 1024, 1) gb
        FROM dba_segments
       WHERE segment_name NOT LIKE 'BIN$%';

   dfilesn       NUMBER;
   tfilesn       NUMBER;
   segmentsn     NUMBER;
   sch_mb_dat    NUMBER;
   sch_mb_indx   NUMBER;
BEGIN
   OPEN dfiles;

   OPEN tfiles;

   OPEN segments;

   FETCH dfiles
    INTO dfilesn;

   FETCH tfiles
    INTO tfilesn;

   FETCH segments
    INTO segmentsn;

   INSERT INTO dbas.ctrl_espacio
        VALUES (SYSDATE, segmentsn, dfilesn, tfilesn);

   COMMIT;

   FOR r IN (SELECT DISTINCT owner
                        FROM dba_segments
                    ORDER BY 1)
   LOOP
      SELECT ROUND (SUM (BYTES) / 1024 / 1024, 1) mb
        INTO sch_mb_dat
        FROM dba_segments
       WHERE segment_name NOT LIKE 'BIN$%'
	     AND owner = r.owner
         AND segment_type <> 'INDEX';

      SELECT ROUND (SUM (BYTES) / 1024 / 1024, 1) mb
        INTO sch_mb_indx
        FROM dba_segments
       WHERE segment_name NOT LIKE 'BIN$%'
         AND owner = r.owner
         AND segment_type = 'INDEX';

      IF sch_mb_indx IS NULL
      THEN
         sch_mb_indx := 0;
      END IF;

      IF sch_mb_dat IS NULL
      THEN
         sch_mb_dat := 0;
      END IF;

      INSERT INTO dbas.ctrl_espacio_esq
           VALUES (SYSDATE, r.owner, sch_mb_dat, sch_mb_indx);

      COMMIT;
   END LOOP;

   CLOSE dfiles;

   CLOSE tfiles;

   CLOSE segments;
END;
/

conn dbas/dbas_garba_1485

SET SERVEROUTPUT ON
DECLARE
  X NUMBER;
  JobNumber VARCHAR2(100);
BEGIN
  SYS.DBMS_JOB.SUBMIT
    (
      job        => X
     ,what       => 'DBAS.CHECK_SPACE;'
     ,next_date  => to_date(sysdate,'dd/mm/yyyy hh24:mi:ss')
     ,interval   => 'SYSDATE+1'
     ,no_parse   => FALSE
    );
JobNumber := to_char(X);
sys.dbms_output.put_line('Job creado nro.: ' ||JobNumber);
END;
/
commit;

select * from dbas.ctrl_espacio;
select * from dbas.ctrl_espacio_esq;