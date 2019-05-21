SELECT 'PROMPT RECREANDO SNAPSHOT '||NAME||' ...
DROP MATERIALIZED VIEW '||OWNER||'.'||NAME||';
CREATE MATERIALIZED VIEW '||OWNER||'.'||NAME||' 
TABLESPACE GEMDATS
NOCACHE
NOLOGGING
NOPARALLEL
BUILD IMMEDIATE
USING INDEX
TABLESPACE GEMIDXS
REFRESH FAST
WITH PRIMARY KEY
AS 
SELECT * FROM '||OWNER||'.'||NAME||'@CENTRAL.WORLD;
GRANT DELETE, INSERT, SELECT, UPDATE ON  '||OWNER||'.'||NAME||' TO RGEM_ADM_ALL;

CREATE OR REPLACE PUBLIC SYNONYM ACO_ANEXO_ITEMS FOR '||OWNER||'.'||NAME||';' FROM DBA_SNAPSHOTS WHERE REFRESH_METHOD='PRIMARY KEY'
UNION
SELECT 'PROMPT RECREANDO SNAPSHOT '||NAME||' ...
DROP MATERIALIZED VIEW '||OWNER||'.'||NAME||';
CREATE MATERIALIZED VIEW '||OWNER||'.'||NAME||' 
TABLESPACE GEMDATS
NOCACHE
NOLOGGING
NOPARALLEL
BUILD IMMEDIATE
USING INDEX
TABLESPACE GEMIDXS
REFRESH FAST
WITH PRIMARY KEY
AS 
SELECT * FROM '||OWNER||'.'||NAME||'@CENTRAL.WORLD;
GRANT DELETE, INSERT, SELECT, UPDATE ON  '||OWNER||'.'||NAME||' TO RGEM_ADM_ALL;

CREATE OR REPLACE PUBLIC SYNONYM ACO_ANEXO_ITEMS FOR '||OWNER||'.'||NAME||';' FROM DBA_SNAPSHOTS WHERE REFRESH_METHOD='ROWID'
UNION
SELECT 'Prompt Creando Snapshot CM_STK_ITEM_STOCKS_POS...
DROP MATERIALIZED VIEW GEM_ADM.CM_STK_ITEM_STOCKS_POS;
CREATE MATERIALIZED VIEW GEM_ADM.CM_STK_ITEM_STOCKS_POS 
TABLESPACE GEMDATS
BUILD IMMEDIATE
REFRESH COMPLETE
WITH PRIMARY KEY
AS 
SELECT get_nivel_stk_codigo(NULL, emp_codigo, stk_codigo, tst_codigo) stk_codigo_pos, 
       emp_codigo, stk_tipo_item, stk_codigo, f_alta, stk_descripcion, stk_estado, usr_nombre_alta, 
       estk_codigo, rep_codigo, mca_codigo, clr_codigo, tst_codigo, ume_codigo, ume_codigo_contiene_st, 
       ume_codigo_contiene_fact, mon_codigo, cpd_codigo, afi_nro_parte, cta_codigo, ser_periodicidad, 
       art_costo_reposicion, afi_vida_util_estimada, art_costo_prom_pond, stk_descrip_larga, art_medidas, 
       stk_cant_compra, art_cantxenv, stk_factor_compra_stock, art_envxbulto, stk_factor_compra_fact, 
       art_bultoxpallet, stk_costo_ultima_compra, stk_origen, art_kgxpallet, art_talle_numero, stk_ult_compra, 
       art_k_minima_compra, f_modi, usr_nombre_modi, stk_ult_salida, stk_ult_req, art_plazo_entrega, desc_comercial, 
       tolerancia, art_kgxbulto, art_kgxunid, ume_codigo_dimensiones, art_alto, art_largo, art_ancho, art_volumen, 
       art_diametro, art_pto_pedido, art_pto_maximo, art_pto_pedido_auto, art_pto_seguridad, ent_codigo, art_superficie, 
       art_kgnetoxunid, cta_codigo2, stk_alias, stk_cod_barra, stk_exento_gravado, rbi_codigo, sbi_codigo, 
       stk_exento_gravado_gcia, stk_exento_gravado_ib, stk_auxcaracter_01, stk_auxcaracter_02, 
       stk_auxcaracter_03, stk_auxcaracter_04, stk_auxcaracter_05, stk_auxnumero_01, stk_auxnumero_02, stk_auxnumero_03, 
       stk_auxnumero_04, stk_auxnumero_05, stk_auxfecha_01, stk_auxfecha_02, stk_auxfecha_03, stk_auxfecha_04, 
       stk_auxfecha_05, stk_tipo_impuesto, stk_auxlong_01, stk_auxlong_02, stk_auxlong_03, stk_auxlong_04, 
       stk_auxlong_05, stk_auxflag_01, stk_auxflag_02, stk_auxflag_03, stk_auxflag_04, stk_auxflag_05, 
       art_espesor, ume_codigo_02, ume_codigo_03, art_pto_seguridad_auto, esp_numero, stk_prod_optima, 
       pro_codigo, stk_pcje_merma, stk_factor_ume_02, stk_factor_ume_03, ume_codigo_envase, stk_dias_vto
 FROM GEM_ADM.stk_item_stocks@central.world
WHERE stk_auxflag_01 = ''S'';

GRANT DELETE, INSERT, SELECT, UPDATE ON  GEM_ADM.CM_STK_ITEM_STOCKS_POS TO RGEM_ADM_ALL;

GRANT SELECT ON  GEM_ADM.CM_STK_ITEM_STOCKS_POS TO RGEM_ADM_QRY;

CREATE OR REPLACE PUBLIC SYNONYM CM_STK_ITEM_STOCKS_POS FOR GEM_ADM.CM_STK_ITEM_STOCKS_POS;' FROM DUAL

UNION

SELECT 'PROMPT Creando Snapshot STK_ITEM_STOCKS_POS... 
DROP MATERIALIZED VIEW GEM_ADM.STK_ITEM_STOCKS_POS;
CREATE MATERIALIZED VIEW GEM_ADM.STK_ITEM_STOCKS_POS 
TABLESPACE GEMDATS
NOCACHE
NOLOGGING
BUILD IMMEDIATE
REFRESH COMPLETE
WITH PRIMARY KEY
AS 
SELECT get_nivel_stk_codigo(NULL, emp_codigo, stk_codigo, tst_codigo) stk_codigo_pos, 
       emp_codigo, stk_tipo_item, stk_codigo, f_alta, stk_descripcion, stk_estado, usr_nombre_alta, 
       estk_codigo, rep_codigo, mca_codigo, clr_codigo, tst_codigo, ume_codigo, ume_codigo_contiene_st, 
       ume_codigo_contiene_fact, mon_codigo, cpd_codigo, afi_nro_parte, cta_codigo, ser_periodicidad, 
       art_costo_reposicion, afi_vida_util_estimada, art_costo_prom_pond, stk_descrip_larga, art_medidas, 
       stk_cant_compra, art_cantxenv, stk_factor_compra_stock, art_envxbulto, stk_factor_compra_fact, 
       art_bultoxpallet, stk_costo_ultima_compra, stk_origen, art_kgxpallet, art_talle_numero, stk_ult_compra, 
       art_k_minima_compra, f_modi, usr_nombre_modi, stk_ult_salida, stk_ult_req, art_plazo_entrega, desc_comercial, 
       tolerancia, art_kgxbulto, art_kgxunid, ume_codigo_dimensiones, art_alto, art_largo, art_ancho, art_volumen, 
       art_diametro, art_pto_pedido, art_pto_maximo, art_pto_pedido_auto, art_pto_seguridad, ent_codigo, art_superficie, 
       art_kgnetoxunid, cta_codigo2, stk_alias, stk_cod_barra, stk_exento_gravado, rbi_codigo, sbi_codigo, 
       stk_exento_gravado_gcia, stk_exento_gravado_ib, stk_auxcaracter_01, stk_auxcaracter_02, 
       stk_auxcaracter_03, stk_auxcaracter_04, stk_auxcaracter_05, stk_auxnumero_01, stk_auxnumero_02, stk_auxnumero_03, 
       stk_auxnumero_04, stk_auxnumero_05, stk_auxfecha_01, stk_auxfecha_02, stk_auxfecha_03, stk_auxfecha_04, 
       stk_auxfecha_05, stk_tipo_impuesto, stk_auxlong_01, stk_auxlong_02, stk_auxlong_03, stk_auxlong_04, 
       stk_auxlong_05, stk_auxflag_01, stk_auxflag_02, stk_auxflag_03, stk_auxflag_04, stk_auxflag_05, 
       art_espesor, ume_codigo_02, ume_codigo_03, art_pto_seguridad_auto, esp_numero, stk_prod_optima, 
       pro_codigo, stk_pcje_merma, stk_factor_ume_02, stk_factor_ume_03, ume_codigo_envase, stk_dias_vto
 FROM GEM_ADM.stk_item_stocks@CENTRAL.WORLD
WHERE stk_auxflag_01 = ''S'';

GRANT DELETE, INSERT, SELECT, UPDATE ON  GEM_ADM.STK_ITEM_STOCKS_POS TO RGEM_ADM_ALL;

GRANT SELECT ON  GEM_ADM.STK_ITEM_STOCKS_POS TO RGEM_ADM_QRY;

CREATE OR REPLACE PUBLIC SYNONYM STK_ITEM_STOCKS_POS FOR GEM_ADM.STK_ITEM_STOCKS_POS;' FROM DUAL