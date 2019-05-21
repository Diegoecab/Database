set serveroutput on
CREATE OR REPLACE PROCEDURE get_bytes_part_range (
   max_date      VARCHAR,
   min_date      VARCHAR DEFAULT '2000-01' ,
   owner         VARCHAR DEFAULT '%' ,
   table_name    VARCHAR DEFAULT '%' ,
   index_name    VARCHAR DEFAULT '%'
)
AS
   v_lob           CLOB;
   v_bytes         NUMBER := 0;
   v_bytes_table   NUMBER := 0;
   v_bytes_sum     NUMBER;
   v_bytes_total   NUMBER := 0;
   v_owner         VARCHAR (100);
   v_table         VARCHAR (100);
   tab CONSTANT    VARCHAR2 (1) := CHR (9);
BEGIN
   FOR r
   IN (  SELECT   a.table_owner,
                  a.table_name,
                  a.partition_name,
                  a.partition_position,
                  a.high_value
           FROM   dba_tab_partitions a
          WHERE   a.table_owner LIKE UPPER (owner)
                  AND a.table_name LIKE UPPER (table_name)
                  AND EXISTS
                        (SELECT   1
                           FROM   dba_part_key_columns b
                          WHERE   b.owner = a.table_owner
                                  AND b.name = a.table_name
                                  AND EXISTS
                                        (SELECT   1
                                           FROM   dba_tab_columns c
                                          WHERE   c.owner = b.owner
                                                  AND c.table_name = b.name
                                                  AND c.column_name =
                                                        b.column_name
                                                  AND c.data_type = 'DATE'))
       ORDER BY   1, 2, 4)
   LOOP
      v_lob := r.high_value;
--dbms_output.put_line('Entro');

      IF v_owner IS NULL
      THEN
         v_owner := r.table_owner;
      END IF;
	  
	  IF v_table IS NULL
      THEN
         v_table := r.table_name;
      END IF;


      IF v_owner <> r.table_owner
      THEN                                                     --Owner changed
         DBMS_OUTPUT.put_line(   tab
                              || ROUND (v_bytes / 1024 / 1024)
                              || tab
                              || tab
                              || '('
                              || v_owner
                              || ')');
         v_bytes_total := v_bytes_total + v_bytes;
         v_bytes := 0;
         v_owner := r.table_owner;
      END IF;
	  
	  
	  IF v_table <> r.table_name
      THEN                                                     --Table changed
         DBMS_OUTPUT.put_line(   tab
                              || ROUND (v_bytes_table / 1024 / 1024)
                              || tab
                              || tab
                              || '('
                              || v_table
                              || ')');
         v_bytes_table := 0;
         v_table := r.table_name;
      END IF;


      BEGIN
         IF TO_DATE ( (DBMS_LOB.SUBSTR (v_lob, 7, 11)), 'yyyy-mm') BETWEEN TO_DATE (
                                                                              min_date,
                                                                              'yyyy-mm'
                                                                           )
                                                                       AND  TO_DATE (
                                                                               max_date,
                                                                               'yyyy-mm'
                                                                            )
         THEN
            SELECT   bytes
              INTO   v_bytes_sum
              FROM   dba_Segments
             WHERE       owner = r.table_owner
                     AND segment_name = r.table_name
                     AND partition_name = r.partition_name;

					 
					 dbms_output.put_line(r.table_owner||'.'||r.table_name||' partition '||r.partition_name||': '||ROUND (v_bytes_sum / 1024 / 1024)|| 'MB');
					 
            v_bytes := v_bytes + v_bytes_sum;
			v_bytes_table := v_bytes_table + v_bytes_sum;
         --dbms_output.put_line(dbms_lob.substr(v_lob,7,11));

         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('Error on substr ' || SQLERRM);
            DBMS_OUTPUT.put_line(   r.table_owner
                                 || '.'
                                 || r.table_name
                                 || ':'
                                 || r.partition_name
                                 || ' High_value: '
                                 || (DBMS_LOB.SUBSTR (v_lob, 7, 11)));
      END;
   END LOOP;

   IF v_bytes_total = 0
   THEN
      DBMS_OUTPUT.put_line(   tab
                           || ROUND (v_bytes / 1024 / 1024)
                           || tab
                           || tab
                           || '('
                           || v_owner
                           || ')');
   ELSE
      DBMS_OUTPUT.put_line (tab);
      DBMS_OUTPUT.put_line(   'Total MBytes Tables: '
                           || tab
                           || ROUND (v_bytes_total / 1024 / 1024));
      DBMS_OUTPUT.put_line (tab);
   END IF;
END;
/

set serveroutput on
exec get_bytes_part_range ('2009-01','2000-01','COL_DW');
set serveroutput on
exec get_bytes_part_range ('2008-01','2000-01');
