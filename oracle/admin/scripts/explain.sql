/* Ejemplo */

EXPLAIN PLAN SET STATEMENT_ID = 'Execution Plan' INTO "SAI".quest_sl_temp_explain2 FOR
SELECT /*+ NO_USE_NL(PI,AI,AC) */
 pi.numero AS "numero", pi.descripcion_completa AS "descripcion", COUNT(*) AS "cantidad" FROM acta_estados ae, acta_cabecera ac, acta_infraccion ai, p_infraccion pi WHERE ae.codigo_estado IN (:v_sys_b_0, :v_sys_b_1, :v_sys_b_2, :v_sys_b_3, :v_sys_b_4) AND (pi.numero < :v_sys_b_5 OR pi.numero > :v_sys_b_6) AND ae.fecha_hasta IS NULL AND ac.codigo_tipo_acta = :v_sys_b_7 AND pi.codigo = ai.codigo_infraccion_reemplazo + 0 AND ae.codigo_acta = ac.codigo + 0 AND ai.codigo_acta = ac.codigo + 0 AND ae.codigo_acta
 = ai.codigo_acta + 0 GROUP BY pi.numero, pi.descripcion_completa


/*Ejemplo 2*/

1)
alter session set sql_trace=true;

2)
explain plan for select …….

3)
select operation ||’ ‘||options||’ ‘||object_name from plan_table
connect by prior id=parent_id
start with id=1;


4) set autotrace traceonly explain



select * from TABLE(dbms_xplan.display_cursor(’&SQL_ID’, &CHILD));


set feed off
set linesize 150
set pagesize 2000
select * from table(dbms_xplan.display_cursor(null,null, ‘ALL’));