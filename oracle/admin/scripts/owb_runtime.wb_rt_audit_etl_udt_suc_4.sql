--owb_runtime.wb_rt_audit_etl_udt_suc_4.sql
set feedback off

prompt
set pagesize 80
set linesize 180
col rta_lob_name for a30
break on rta_update on report 
compute avg min max of minutos on report
compute avg min max of update_por_seg on report
compute avg min max of rta_select on report


ttitle left 'Antes del 13/05'
prompt
set pagesize 100
set linesize 180
col rta_lob_name for a30
SELECT last_update_date fecha,rta_lob_name, rta_select, rta_update, rta_errors,  ROUND (rta_elapse / 60) minutos, ROUND(rta_update/rta_elapse) UPDATE_POR_SEG,
       DECODE (rta_status, 1, 'OK', 'ERR') estado
  FROM owb_runtime.wb_rt_audit
  where rta_lob_name = 'ETL_UPDATE_STOCK_POR_SUCURSAL4'
  and rta_update <> 0 and rta_update is not null
  and rta_select > 10000
  and trunc(last_update_date) < trunc(to_date('13/05/2011','DD/MM/YYYY'))
  order by last_update_date desc
/


ttitle left 'Despues del 13/05'

SELECT last_update_date fecha,rta_lob_name, rta_select, rta_update, rta_errors,  ROUND (rta_elapse / 60) minutos, ROUND(rta_update/rta_elapse) UPDATE_POR_SEG,
       DECODE (rta_status, 1, 'OK', 'ERR') estado
  FROM owb_runtime.wb_rt_audit
  where rta_lob_name = 'ETL_UPDATE_STOCK_POR_SUCURSAL4'
  and rta_update <> 0 and rta_update is not null
  and rta_select > 10000
  and trunc(last_update_date) > trunc(to_date('13/05/2011','DD/MM/YYYY'))
  order by last_update_date desc
/


/*
SELECT   last_update_date fecha, rtd_target objeto, rtd_select filas,
         rtd_insert insertadas,
         NVL (rtd_update, 0) + NVL (rtd_merge, 0) actualizadas,
         ROUND (rtd_elapse / 60, 2) minutos,
         DECODE (rtd_status, 1, 'OK', 'ERR') estado,
         NVL (rtd_errors, 99) errores
    FROM owb_runtime.wb_rt_audit_detail
   WHERE last_update_date > TRUNC (SYSDATE)
ORDER BY last_update_date DESC;
*/

/*
Para ver los ultimos 3 días de operaciones mas largas de stock_por_sucursal
col objeto for a25
col sub_objeto for a25

SELECT   last_update_date fecha,rtd_target objeto, rtd_name sub_objeto, rtd_select filas,
         rtd_insert insertadas,
         NVL (rtd_update, 0) + NVL (rtd_merge, 0) actualizadas,
         ROUND (rtd_elapse / 60, 2) minutos,
         DECODE (rtd_status, 1, 'OK', 'ERR') estado,
         NVL (rtd_errors, 99) errores
    FROM owb_runtime.wb_rt_audit_detail
   WHERE last_update_date > TRUNC (SYSDATE-3) AND rtd_target = '"STOCK_POR_SUCURSAL"' and rtd_name='"STK_VEN_Y_ART_p"'
ORDER BY last_update_date DESC;
*/

clear compute
set feedback on
