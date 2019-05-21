--stats_table_exec.sql

prompt Estadisticas de esquema
set serveroutput on
set timing on

accept OWNER prompt 'Ingrese OWNER: '
accept TABLE prompt 'Ingrese TABLA: '
accept POR prompt 'Ingrese PORCENTAJE (Ej. DBMS_STATS.AUTO_SAMPLE_SIZE o 100): '

BEGIN
   DBMS_STATS.gather_table_stats (ownname               => '&OWNER',
                                  tabname               => '&TABLE',
                                  estimate_percent      => &POR,
                                  method_opt            => 'FOR ALL COLUMNS SIZE AUTO',
								  cascade 				=> true		
                                 );
END;
/

prompt Estadistica ejecutada sobre la tabla &TABLE de &OWNER
prompt method_opt FOR ALL COLUMNS SIZE AUTO
prompt estimate_percent &POR