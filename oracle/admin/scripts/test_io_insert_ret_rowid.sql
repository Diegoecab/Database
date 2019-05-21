--1 Creo tabla e unique index para prueba, tal como la original 

DROP TABLE GAR_DW.STOCK_POR_SUCURSAL_P PURGE;

CREATE TABLE GAR_DW.STOCK_POR_SUCURSAL_P AS SELECT * FROM GAR_DW.STOCK_POR_SUCURSAL WHERE 1=2;

  CREATE UNIQUE INDEX "GAR_DW"."STOCK_POR_SUCURSALP_ART_IDX2" ON "GAR_DW"."STOCK_POR_SUCURSAL_P" 
("EMP_ID", "ART_COD_EMP", "ART_ID", "SUC_COD_EMPRESA", "SUC_ID", "DIA_ID", "TMS_ID") NOLOGGING COMPUTE STATISTICS
  TABLESPACE "GAR_DW_INDX" ;


--2 PL SQL Returning ROWID

alter session set tracefile_identifier=insert_stk_x_suc_p_rowid;
alter session set timed_statistics = true;
alter session set statistics_level=all;
alter session set max_dump_file_size = unlimited;
alter session set events '10046 trace name context forever,level 12';

SET SERVEROUTPUT ON
SET TIMING ON
DECLARE
one_rowid             ROWID;
BEGIN
FOR I in (
SELECT "ART_COD_EMP", "ART_ID", "DTO_ESP", "DIA_ID",
  "EMP_ID", "MARGEN", "RENTAB", "SERVICE", "STK_FRU", "STK_INMOV_30",
  "STK_MOD", "CANT_STOCK", "CANT_VENTAS", "OBSERVACION", "STOCK_IDEAL",
  "SUC_COD_EMPRESA", "SUC_ID", "TOT_BRUTO", "TOT_BRUTO_R", "AVG_STK_DISP_MES",
   "CANT_M2_SAL_Y_EXP", "CANT_PEDIR_30", "CANT_VENDEDORES", "COMPRAS",
  "COSTOR_ULT30", "COSTO_R", "DIAS_C_STK_30", "DIAS_D_STK_30", "DTO_ESP_30",
  "ENV_A_SERV", "ENV_A_SERV_30", "INGRESOS", "INGRESOS_30", "NETO_R",
  "NETO_R_ULT30", "TMS_ID", "TOTAL_S_FLETE", "TOTAL_S_FLETE_30", "VTA_ULT_30",
   "ACTCOMPRA_COD", "ACTCOMPRA_DESC", "CAN_FRU_MOVIL", "COSTO_REP_SIVA",
  "DIAS_C_STK_14", "DIAS_C_STK_21", "DIAS_C_STK_28", "DIAS_C_STK_60",
  "DIAS_C_STK_7", "DIAS_C_STK_DISP_M_ALT_30", "ES_MAILING", "EXPO_IDEAL",
  "FEC_ULT_INGRESO", "FRU_MOVIL", "IMP_FRU_MOVIL", "PRUEBA1",
  "RNK_EXPO_IDEAL", "STK_DISPO_ACCES", "STK_DISP_ALTERNAT",
  "STK_DISP_CENTRAL", "STK_RESER_ACCES", "STOCK_DISPONIBLE",
  "STOCK_EXPOSICION", "STOCK_EXPOVENTA", "STOCK_TOTAL", "STOCK_TRANSPREP",
  "ULT_PREC_VTA_CIVA", "VTA_FRU_MOV_14", "VTA_FRU_MOV_21", "VTA_FRU_MOV_28",
  "VTA_FRU_MOV_30", "VTA_FRU_MOV_7", "VTA_ULT_07", "VTA_ULT_14",
  "VTA_ULT_180", "VTA_ULT_21", "VTA_ULT_28", "VTA_ULT_360", "VTA_ULT_60" 
FROM STOCK_POR_SUCURSAL WHERE dia_id in (select dia_id from l_dia where trunc(dia_fecha) = trunc (to_date ('11/03/2010','dd/mm/yyyy'))))
LOOP
            INSERT
            /*+ APPEND  PARALLEL (STOCK_POR_SUCURSAL_P, DEFAULT, DEFAULT) */
            INTO 
              "STOCK_POR_SUCURSAL_P"
              ("ART_COD_EMP",
              "ART_ID",
              "DTO_ESP",
              "DIA_ID",
              "EMP_ID",
              "MARGEN",
              "RENTAB",
              "SERVICE",
              "STK_FRU",
              "STK_INMOV_30",
              "STK_MOD",
              "CANT_STOCK",
              "CANT_VENTAS",
              "OBSERVACION",
              "STOCK_IDEAL",
              "SUC_COD_EMPRESA",
              "SUC_ID",
              "TOT_BRUTO",
              "TOT_BRUTO_R",
              "AVG_STK_DISP_MES",
              "CANT_M2_SAL_Y_EXP",
              "CANT_PEDIR_30",
              "CANT_VENDEDORES",
              "COMPRAS",
              "COSTOR_ULT30",
              "COSTO_R",
              "DIAS_C_STK_30",
              "DIAS_D_STK_30",
              "DTO_ESP_30",
              "ENV_A_SERV",
              "ENV_A_SERV_30",
              "INGRESOS",
              "INGRESOS_30",
              "NETO_R",
              "NETO_R_ULT30",
              "TMS_ID",
              "TOTAL_S_FLETE",
              "TOTAL_S_FLETE_30",
              "VTA_ULT_30",
              "ACTCOMPRA_COD",
              "ACTCOMPRA_DESC",
              "CAN_FRU_MOVIL",
              "COSTO_REP_SIVA",
              "DIAS_C_STK_14",
              "DIAS_C_STK_21",
              "DIAS_C_STK_28",
              "DIAS_C_STK_60",
              "DIAS_C_STK_7",
              "DIAS_C_STK_DISP_M_ALT_30",
              "ES_MAILING",
              "EXPO_IDEAL",
              "FEC_ULT_INGRESO",
              "FRU_MOVIL",
              "IMP_FRU_MOVIL",
              "PRUEBA1",
              "RNK_EXPO_IDEAL",
              "STK_DISPO_ACCES",
              "STK_DISP_ALTERNAT",
              "STK_DISP_CENTRAL",
              "STK_RESER_ACCES",
              "STOCK_DISPONIBLE",
              "STOCK_EXPOSICION",
              "STOCK_EXPOVENTA",
              "STOCK_TOTAL",
              "STOCK_TRANSPREP",
              "ULT_PREC_VTA_CIVA",
              "VTA_FRU_MOV_14",
              "VTA_FRU_MOV_21",
              "VTA_FRU_MOV_28",
              "VTA_FRU_MOV_30",
              "VTA_FRU_MOV_7",
              "VTA_ULT_07",
              "VTA_ULT_14",
              "VTA_ULT_180",
              "VTA_ULT_21",
              "VTA_ULT_28",
              "VTA_ULT_360",
              "VTA_ULT_60")
            VALUES
(i."ART_COD_EMP", i."ART_ID", i."DTO_ESP", i."DIA_ID",
  i."EMP_ID", i."MARGEN", i."RENTAB", i."SERVICE", i."STK_FRU", i."STK_INMOV_30",
  i."STK_MOD", i."CANT_STOCK", i."CANT_VENTAS", i."OBSERVACION", i."STOCK_IDEAL",
  i."SUC_COD_EMPRESA", i."SUC_ID", i."TOT_BRUTO", i."TOT_BRUTO_R", i."AVG_STK_DISP_MES",
   i."CANT_M2_SAL_Y_EXP", i."CANT_PEDIR_30", i."CANT_VENDEDORES", i."COMPRAS",
  i."COSTOR_ULT30", i."COSTO_R", i."DIAS_C_STK_30", i."DIAS_D_STK_30", i."DTO_ESP_30",
  i."ENV_A_SERV", i."ENV_A_SERV_30", i."INGRESOS", i."INGRESOS_30", i."NETO_R",
  i."NETO_R_ULT30", i."TMS_ID", i."TOTAL_S_FLETE", i."TOTAL_S_FLETE_30", i."VTA_ULT_30",
   i."ACTCOMPRA_COD", i."ACTCOMPRA_DESC", i."CAN_FRU_MOVIL", i."COSTO_REP_SIVA",
  i."DIAS_C_STK_14", i."DIAS_C_STK_21", i."DIAS_C_STK_28", i."DIAS_C_STK_60",
  i."DIAS_C_STK_7", i."DIAS_C_STK_DISP_M_ALT_30", i."ES_MAILING", i."EXPO_IDEAL",
  i."FEC_ULT_INGRESO", i."FRU_MOVIL", i."IMP_FRU_MOVIL", i."PRUEBA1",
  i."RNK_EXPO_IDEAL", i."STK_DISPO_ACCES", i."STK_DISP_ALTERNAT",
  i."STK_DISP_CENTRAL", i."STK_RESER_ACCES", i."STOCK_DISPONIBLE",
  i."STOCK_EXPOSICION", i."STOCK_EXPOVENTA", i."STOCK_TOTAL", i."STOCK_TRANSPREP",
  i."ULT_PREC_VTA_CIVA", i."VTA_FRU_MOV_14", i."VTA_FRU_MOV_21", i."VTA_FRU_MOV_28",
  i."VTA_FRU_MOV_30", i."VTA_FRU_MOV_7", i."VTA_ULT_07", i."VTA_ULT_14",
  i."VTA_ULT_180", i."VTA_ULT_21", i."VTA_ULT_28", i."VTA_ULT_360", i."VTA_ULT_60") RETURNING ROWID
       INTO one_rowid;
END LOOP;
COMMIT;
EXCEPTION WHEN OTHERS THEN
ROLLBACK;
DBMS_OUTPUT.PUT_LINE ('ERROR '||SQLERRM);
END;
/
alter session set events '10046 trace name context off';


Prompt Sin return ID

Prompt Ejecutar nuevamente drop y create de tabla e indice

alter session set tracefile_identifier=insert_stk_x_suc_p;
alter session set timed_statistics = true;
alter session set statistics_level=all;
alter session set max_dump_file_size = unlimited;
alter session set events '10046 trace name context forever,level 12';

SET SERVEROUTPUT ON
SET TIMING ON
BEGIN
FOR I in (
SELECT "ART_COD_EMP", "ART_ID", "DTO_ESP", "DIA_ID",
  "EMP_ID", "MARGEN", "RENTAB", "SERVICE", "STK_FRU", "STK_INMOV_30",
  "STK_MOD", "CANT_STOCK", "CANT_VENTAS", "OBSERVACION", "STOCK_IDEAL",
  "SUC_COD_EMPRESA", "SUC_ID", "TOT_BRUTO", "TOT_BRUTO_R", "AVG_STK_DISP_MES",
   "CANT_M2_SAL_Y_EXP", "CANT_PEDIR_30", "CANT_VENDEDORES", "COMPRAS",
  "COSTOR_ULT30", "COSTO_R", "DIAS_C_STK_30", "DIAS_D_STK_30", "DTO_ESP_30",
  "ENV_A_SERV", "ENV_A_SERV_30", "INGRESOS", "INGRESOS_30", "NETO_R",
  "NETO_R_ULT30", "TMS_ID", "TOTAL_S_FLETE", "TOTAL_S_FLETE_30", "VTA_ULT_30",
   "ACTCOMPRA_COD", "ACTCOMPRA_DESC", "CAN_FRU_MOVIL", "COSTO_REP_SIVA",
  "DIAS_C_STK_14", "DIAS_C_STK_21", "DIAS_C_STK_28", "DIAS_C_STK_60",
  "DIAS_C_STK_7", "DIAS_C_STK_DISP_M_ALT_30", "ES_MAILING", "EXPO_IDEAL",
  "FEC_ULT_INGRESO", "FRU_MOVIL", "IMP_FRU_MOVIL", "PRUEBA1",
  "RNK_EXPO_IDEAL", "STK_DISPO_ACCES", "STK_DISP_ALTERNAT",
  "STK_DISP_CENTRAL", "STK_RESER_ACCES", "STOCK_DISPONIBLE",
  "STOCK_EXPOSICION", "STOCK_EXPOVENTA", "STOCK_TOTAL", "STOCK_TRANSPREP",
  "ULT_PREC_VTA_CIVA", "VTA_FRU_MOV_14", "VTA_FRU_MOV_21", "VTA_FRU_MOV_28",
  "VTA_FRU_MOV_30", "VTA_FRU_MOV_7", "VTA_ULT_07", "VTA_ULT_14",
  "VTA_ULT_180", "VTA_ULT_21", "VTA_ULT_28", "VTA_ULT_360", "VTA_ULT_60" 
FROM STOCK_POR_SUCURSAL WHERE dia_id in (select dia_id from l_dia where trunc(dia_fecha) = trunc (to_date ('11/03/2010','dd/mm/yyyy'))))
LOOP
            INSERT
            /*+ APPEND  PARALLEL (STOCK_POR_SUCURSAL_P, DEFAULT, DEFAULT) */
            INTO 
              "STOCK_POR_SUCURSAL_P"
              ("ART_COD_EMP",
              "ART_ID",
              "DTO_ESP",
              "DIA_ID",
              "EMP_ID",
              "MARGEN",
              "RENTAB",
              "SERVICE",
              "STK_FRU",
              "STK_INMOV_30",
              "STK_MOD",
              "CANT_STOCK",
              "CANT_VENTAS",
              "OBSERVACION",
              "STOCK_IDEAL",
              "SUC_COD_EMPRESA",
              "SUC_ID",
              "TOT_BRUTO",
              "TOT_BRUTO_R",
              "AVG_STK_DISP_MES",
              "CANT_M2_SAL_Y_EXP",
              "CANT_PEDIR_30",
              "CANT_VENDEDORES",
              "COMPRAS",
              "COSTOR_ULT30",
              "COSTO_R",
              "DIAS_C_STK_30",
              "DIAS_D_STK_30",
              "DTO_ESP_30",
              "ENV_A_SERV",
              "ENV_A_SERV_30",
              "INGRESOS",
              "INGRESOS_30",
              "NETO_R",
              "NETO_R_ULT30",
              "TMS_ID",
              "TOTAL_S_FLETE",
              "TOTAL_S_FLETE_30",
              "VTA_ULT_30",
              "ACTCOMPRA_COD",
              "ACTCOMPRA_DESC",
              "CAN_FRU_MOVIL",
              "COSTO_REP_SIVA",
              "DIAS_C_STK_14",
              "DIAS_C_STK_21",
              "DIAS_C_STK_28",
              "DIAS_C_STK_60",
              "DIAS_C_STK_7",
              "DIAS_C_STK_DISP_M_ALT_30",
              "ES_MAILING",
              "EXPO_IDEAL",
              "FEC_ULT_INGRESO",
              "FRU_MOVIL",
              "IMP_FRU_MOVIL",
              "PRUEBA1",
              "RNK_EXPO_IDEAL",
              "STK_DISPO_ACCES",
              "STK_DISP_ALTERNAT",
              "STK_DISP_CENTRAL",
              "STK_RESER_ACCES",
              "STOCK_DISPONIBLE",
              "STOCK_EXPOSICION",
              "STOCK_EXPOVENTA",
              "STOCK_TOTAL",
              "STOCK_TRANSPREP",
              "ULT_PREC_VTA_CIVA",
              "VTA_FRU_MOV_14",
              "VTA_FRU_MOV_21",
              "VTA_FRU_MOV_28",
              "VTA_FRU_MOV_30",
              "VTA_FRU_MOV_7",
              "VTA_ULT_07",
              "VTA_ULT_14",
              "VTA_ULT_180",
              "VTA_ULT_21",
              "VTA_ULT_28",
              "VTA_ULT_360",
              "VTA_ULT_60")
            VALUES
(i."ART_COD_EMP", i."ART_ID", i."DTO_ESP", i."DIA_ID",
  i."EMP_ID", i."MARGEN", i."RENTAB", i."SERVICE", i."STK_FRU", i."STK_INMOV_30",
  i."STK_MOD", i."CANT_STOCK", i."CANT_VENTAS", i."OBSERVACION", i."STOCK_IDEAL",
  i."SUC_COD_EMPRESA", i."SUC_ID", i."TOT_BRUTO", i."TOT_BRUTO_R", i."AVG_STK_DISP_MES",
   i."CANT_M2_SAL_Y_EXP", i."CANT_PEDIR_30", i."CANT_VENDEDORES", i."COMPRAS",
  i."COSTOR_ULT30", i."COSTO_R", i."DIAS_C_STK_30", i."DIAS_D_STK_30", i."DTO_ESP_30",
  i."ENV_A_SERV", i."ENV_A_SERV_30", i."INGRESOS", i."INGRESOS_30", i."NETO_R",
  i."NETO_R_ULT30", i."TMS_ID", i."TOTAL_S_FLETE", i."TOTAL_S_FLETE_30", i."VTA_ULT_30",
   i."ACTCOMPRA_COD", i."ACTCOMPRA_DESC", i."CAN_FRU_MOVIL", i."COSTO_REP_SIVA",
  i."DIAS_C_STK_14", i."DIAS_C_STK_21", i."DIAS_C_STK_28", i."DIAS_C_STK_60",
  i."DIAS_C_STK_7", i."DIAS_C_STK_DISP_M_ALT_30", i."ES_MAILING", i."EXPO_IDEAL",
  i."FEC_ULT_INGRESO", i."FRU_MOVIL", i."IMP_FRU_MOVIL", i."PRUEBA1",
  i."RNK_EXPO_IDEAL", i."STK_DISPO_ACCES", i."STK_DISP_ALTERNAT",
  i."STK_DISP_CENTRAL", i."STK_RESER_ACCES", i."STOCK_DISPONIBLE",
  i."STOCK_EXPOSICION", i."STOCK_EXPOVENTA", i."STOCK_TOTAL", i."STOCK_TRANSPREP",
  i."ULT_PREC_VTA_CIVA", i."VTA_FRU_MOV_14", i."VTA_FRU_MOV_21", i."VTA_FRU_MOV_28",
  i."VTA_FRU_MOV_30", i."VTA_FRU_MOV_7", i."VTA_ULT_07", i."VTA_ULT_14",
  i."VTA_ULT_180", i."VTA_ULT_21", i."VTA_ULT_28", i."VTA_ULT_360", i."VTA_ULT_60");
END LOOP;
COMMIT;
EXCEPTION WHEN OTHERS THEN
ROLLBACK;
DBMS_OUTPUT.PUT_LINE ('ERROR '||SQLERRM);
END;
/
