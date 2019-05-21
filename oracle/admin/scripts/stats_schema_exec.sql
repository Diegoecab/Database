--stats_schema_exec.sql

prompt Estadisticas de esquema
set serveroutput on

accept OWNER prompt 'Ingrese OWNER: '

   BEGIN
 DBMS_STATS.gather_schema_stats ( '&OWNER',
                                            DBMS_STATS.auto_sample_size,
                                            CASCADE      => TRUE,
                                            DEGREE       => 8
                                           );							
   END;
/