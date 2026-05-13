REM	Uso de tablespace temporal
REM ======================================================================
REM tbs_temp_state.sql		Version 1.1	25 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Monitorear uso del tablespace TEMP
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM
REM Precauciones:
REM	
REM ======================================================================
REM
select t2."TempTotal" "TempTotal (Mb)",
       t1."TempUsed" "TempUsed (Mb)",
       t2."TempTotal" - t1."TempUsed" "TempFree (Mb)"
  from (select nvl(round(sum(tu.blocks * tf.block_size) / 1024 / 1024, 2), 0) "TempUsed"
          from v$tempseg_usage tu, dba_tablespaces tf
         where tu.TABLESPACE = tf.tablespace_name) t1,
       (select round(sum(bytes) / 1024 / 1024, 2) "TempTotal"
          from dba_temp_files) t2;