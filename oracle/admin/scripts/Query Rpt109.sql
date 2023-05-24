----------------------------
-- RPT0109
---------------------------
WITH SHM AS (SELECT MAX(SH.SHSHNR) ID
           FROM SUHISTOR SH
            INNER JOIN COMMERCIAL_PRODUCT CP ON CP.ID = SH.SHPRODUCTNR AND ((CP.CATEGORY_ID = 1 AND CP.ID NOT IN (301,305))OR (CP.CATEGORY_ID = 6 AND CP.ID IN (207,97)))
            WHERE SH.CREATE_DATETIME BETWEEN :P_FECHA_DESDE AND trunc(:P_FECHA_HASTA+1,'DD')
            AND SH.SHEVENTNR IN (120,171,5252,108)  AND SH.ENTITY_KEY = 24
            GROUP BY SH.SHSUBSCRIBERNR, CASE
                                                                WHEN SH.SHPRODUCTNR IN (87,60,64,99,100,85,48,52,84,44,54)     THEN 'HBO'
                                                                WHEN SH.SHPRODUCTNR IN (73,61,98,45,53,55)                     THEN 'MOVIECITY'
                                                                WHEN SH.SHPRODUCTNR IN (211,63,62,46,47)                     THEN 'ADULT1'
                                                                WHEN SH.SHPRODUCTNR IN (212,76,74)                             THEN 'ADULT2'
                                                                ELSE TO_CHAR(CP.ID) END),
-------------------------------------------------------------------------------------                                                               
    BASE AS(SELECT SH.SHSHNR,
                    TS.NOMBRE_AGENTE || ' ' || TS.APELLIDO_AGENTE   OPERADOR,
                    TS.LEGAJO                                       LEGAJO,
                    SH.SHSUBSCRIBERNR                               NRO_CLIENTE,
                    CP.NAME                                         PREMIUM,
                    TS.GRUPO_SKILL                                  PERFIL,
                    SH.CREATE_DATETIME                              FECHA,
                    ADS.NAME                                        ESTADO,
                    SE.NAME                                         EVENTO,
                    SE.ID                                           EVENT_ID,
                    AD.ID                                           AGREEMENT_DETAIL_ID,
                    CP.ID                                           PRODUCTO_BASICO_ID,
                    AD.REPLACES_PRODUCT_ID                          REPLACES_PRODUCT_ID
            FROM  SUHISTOR SH
            -------------------------------------------------------------------------------------
            INNER JOIN COMMERCIAL_PRODUCT CP ON CP.ID = SH.SHPRODUCTNR AND ((CP.CATEGORY_ID = 1 AND CP.ID NOT IN (301,305)) OR (CP.CATEGORY_ID = 6 AND CP.ID IN (207,97)))
            INNER JOIN AGREEMENT_DETAIL AD ON AD.ID = SH.ENTITY_ID
            INNER JOIN AGREEMENT_DETAIL_STATUS ADS ON ADS.ID = AD.STATUS
            LEFT JOIN EXTERNAL_AGENT EA ON EA.ID = SH.EXTERNAL_AGENT_ID
            LEFT JOIN IBS_USER IBS ON UPPER(IBS.NAME) = UPPER(EA.NAME)
            -------------------------------------------------------------------------------------
            INNER JOIN TEAM_SKILL TS ON TS.USUARIO_IBS_ID = case when sh.shusernr in (10036,13) then ibs.id else SH.SHUSERNR end AND TS.GRUPO_SKILL IN ('WIMAX ARG'
,'TST (COL)'
,'BGI'
,'ACT CHI'
,'HB-TST(ARG)'
,'TST(COL)'
,'TST ECUPER'
,'CS PER'
,'BO_ARG_AGE'
,'RVO_ARG_ARG'
,'RVO ARG'
,'RET CHI'
,'RET PER'
,'RECARGAS ARGENTINA'
,'TLV_COL_NET_VED_IN_IS'
,'BGI(COL)'
,'BO_ARG_REC_ARG'
,'FID_ARG_ARG'
,'ABM'
,'NEXUS PLATINO ARG'
,'TLC_AR_COM_REN_AR_TLV_IN_UPG_CHAT'
,'INS_PER_VED_MED_IS'
,'TLV_IN_ARG_ARG'
,'DATA ENTRY'
,'RVO_MUD_ARG_ARG'
,'BO ARG'
,'LEAL ARG'
,'CS PR'
,'BO_ARG_SDG'
,'REN IN'
,'LEAL_PR_OUT_VED_MED_IS'
,'TLV ARG'
,'CS ARG'
,'TLV_CHI_VED_MED_IS'
,'RET_COL'
,'REC ARG'
,'TLV CHILE'
,'TLC_AR_COM_TLV_OUT_AR_AR'
,'TLV_OUT_UPG_WIN_ARG'
,'TLC_AR_COM_TLV_IN_AR_DTN_ARG'
,'RVP CHILE'
,'TLC_AR_COM_RVO_AR_MUDANZA'
,'COB PER'
,'TLC_AR_SER_PRE_AR_AR'
,'TLC_AR_COM_RVO_AR_CELEC'
,'ACTIVACIONES(COL)'
,'TLV_IN'
,'REC PER'
,'CSR EXC'
,'RVO_DTN_ARG_ARG'
,'ADVANCED'
,'IGCV'
,'TST_ECU_WO_VED_MED_IS'
,'PRE'
,'TLV'
,'INS_CHI_VED_MED_IS'
,'AZAFATA'
,'ACTI_COL_PER_VED_BOG_IS_AI'
,'REN ECU'
,'TLV ATG'
,'ACT URU'
,'BO_PQR_ARG_ALL'
,'GTR'
,'ACT COL INM'
,'TLC_ARG_CUSTOMER'
,'BO_ARG_AE'
,'TLC_AR_COM_RVO_AR_WIN'
,'SOPORTE AL TECNICO REG'
,'RET ARG'
,'PRE(ARG)'
,'COB ECU'
,'TST CHI_URU'
,'TVT ARG'
,'BO_ARG_ARG'
,'REC COL'
,'CS ECU'
,'BO_ARG_SUM_ARG'
,'TORRECTRL_ECU_VED_MED_IS'
,'SAC(COL)'
,'SOPORTE AL TÉCNICO ARG'
,'PREPAGO(COL)'
,'TLC_AR_COM_TLV_IN_AR_WEB_CHATFORM'
,'RVP_ARG_ARG'
,'SEGUIMIENTO'
,'INS_ECU_VED_MED_IS'
,'TST_ARG_ARG'
,'REN COL'
,'INS_URU_VED_MED_IS'
,'ACT PER'
,'TLV_OUT_ARG'
,'TLC_AR_COM_CBZ_AR_AR'
,'SAC(ECU)'
,'TLC_AR_COM_REN_AR_TLV_OUT_UPG_WIN'
,'TLC_AR_COM_REN_AR_TLV_IN_UPG_AR'
,'TLC_AR_COM_CBZ_AR_DAC'
,'SOPORTE'
,'TST PLATINO REG'
,'TLC_AR_COM_TLV_IN_AR_DERIVADOR'
,'DTN_ARG_ARG'
,'-'
,'REC URU'
,'*TLC_AR_SER_BGI_AR_ALLUS'
,'TLC_AR_ESP_BO_AR_SOPORTE15'
,'REC ECU'
,'ACTIVACIONES (COL)'
,'RVO_URU_ARG'
,'TLC_AR_SER_AR_DTN'
,'COB(ARG)'
,'TLC_AR'
,'SAC(PER)'
,'TVT (ARG)'
,'SI(ARG)'
,'TLV_IN(ARG)'
,'RET ECU'
,'RECAR ARG'
,'SOCIAL MEDIA'
,'BGI(ARG)'
,'TST(ARG)'
,'TLC_AR_SER_PAG_AR_AR'
,'TLC_AR_COM_TLV_IN_AR_WEB'
,'AI(ARG)'
,'CS PR_V'
,'BO_ARG_ESC_ARG'
,'PASSWORD'
,'INS_ARG_VED_MED_IS'
,'BO_ARG_MAIL_ARG'
,'LEAL (ECU)'
,'TST PRE'
,'TLC_AR_COM_TLV_IN_UR_AR'
,'TLC_AR_COM'
,'SOPORTE AL TECNICO NET ARG-COL'
,'SOPORTE AL TÉCNICO NET ARG-COL'
,'TLV_OUT_UPG_ARG'
,'WO PER'
,'UIT COL'
,'SOPORTE AL TÉCNICO CHI'
,'BGI_CHI_PLA_IS'
,'BO_ARG_CE'
,'TLC_AR_SER_BGI_AR_ALLUS'
,'TLC_AR_SER_TST_AR_ALLUS'
,'TLC_AR_COM_RVO_AR_DTN'
,'WEL(PER) '
,'TLC_AR_COM_RVO_AR_AR'
,'BGI (COL)'
,'COB CHI'
,'TLC_ARG'
,'TLC_AR_COM_REN_AR_TLV_ALLUS_OUT'
,'TLV_UPG_PROGRAMACION_IN_ARG'
,'ACT REG'
,'TLC_AR_SER_TST_AR_AR'
,'TLC_AR_COM_TLV_IN_AR_AR'
,'TST NET'
,'TST COL'
,'BGI_COL_VED_MDE_PRE_IS'
,'RENTABILIDAD_MOP'
,'TST (ARG)'
,'G. RECARGAS (ARG)'
,'TLV_UPG_PROGRAMACION_OUT_ARG'
,'NET BO COL'
,'TST ARG'
,'TLC_AR_COM_RVP_AR_AR'
,'TLC_AR_SER_PRE_AR_ALLUS'
,'SAC (COL)'
,'BO_ARG_LINK_ARG'
,'TLV_INTERNET(CHAT)_ARG'
,'PREPAGO (COL)'
,'SOPORTE AL TECNICO ARG'
,'BO_ARG_CHAT_ARG'
,'COB URU'
,'TLC_AR_COM_REN_AR_RVP_ALLUS'
,'CBZ_ARG_ARG'
,'INS_COL_VED_MED_IS'
,'RVO_WIN_ARG_ARG'
,'BO_ARG_AZA'
,'TLC_AR_COM_TLV_IN_AR_REDES_SOCIALES'
,'PRE (COL)'
,'TLC_AR_COM_RVO_UR_UR'
,'REN OUT'
,'BILING%C3%9CE PR'
,'PRE_ARG_ARG'
,'REC CHI'
,'TLV_UPG_PP_ARGE'
,'RECAUDACIONES-COBRANZAS-ARGENTINA'
,'COB_COL'
,'PAG_ARG_ARG'
,'TST URU'
,'URU CO'
,'TST_PER_WO_VED_MED_IS'
,'TST PR_V'
,'TLC_AR_COM_CBZ_AR_ESPECIALES'
,'TLV_IN_UPG_ARG'
,'TLV_IN_WEB_ARG'
,'INS-TST(ARG)'
,'TLV_INTERNET_ARG'
,'RVP_SKIP TRACE_ARG'
,'TLC_AR_SER_BGI_AR_BOXES'
,'TST PR'
,'ACT ARG'
,'ACT (COL)'
,'TLC_AR_SER'
,'RET URU'
,'TLV_'
,'WB ARG'
,'CS CHI'
,'CS URU'
,'COB ARG'
,'TST_ECU_VED_MED_IS'
,'BO_ARG_AGE_ARG'
,'RET COL'
,'TRASLADO'
,'WIN_ARG_ARG'
,'COB PR'
,'BO_ARG_EMP_ARG'
,'SAC - #332'
,'ACT(ARG)'
,'G. RECARGAS (PTO RICO)'
,'TLC_ARG_ESPECIALIZADOS'
,'LEA  ARG'
,'TLV_UPG_ARG'
,'CS UIT')
            -------------------------------------------------------------------------------------
            INNER JOIN SYSTEM_EVENT SE ON SE.ID = SH.SHEVENTNR  AND SE.ENTITY_KEY = 24        
            -------------------------------------------------------------------------------------
            WHERE SH.CREATE_DATETIME BETWEEN :P_FECHA_DESDE AND trunc(:P_FECHA_HASTA+1,'DD')
            AND SH.SHEVENTNR IN (120,171,5252,108)  AND SH.ENTITY_KEY = 24),
-------------------------------------------------------------------------------------
    ACT  AS(SELECT B.SHSHNR         SHSHNR,
                   MIN(ACT.SHSHNR)  SHSHNR_ACT
            FROM BASE B
            LEFT JOIN (SELECT SHSHNR, ENTITY_ID, CREATE_DATETIME
                        FROM SUHISTOR SH
                        INNER JOIN CUSTOMER C ON C.ID = SH.SHSUBSCRIBERNR AND C.CLASS_ID = 1
                        WHERE SH.CREATE_DATETIME BETWEEN :P_FECHA_DESDE AND trunc(:P_FECHA_HASTA+1,'DD')
                        AND SH.SHEVENTNR =204  AND SH.ENTITY_KEY = 24  AND SH.SHPRODUCTNR NOT IN (301,305)
                        UNION ALL
                        SELECT SHSHNR, ENTITY_ID, CREATE_DATETIME
                        FROM SUHISTOR SH
                        INNER JOIN CUSTOMER C ON C.ID = SH.SHSUBSCRIBERNR AND C.CLASS_ID <> 1
                        WHERE SH.CREATE_DATETIME BETWEEN :P_FECHA_DESDE AND trunc(:P_FECHA_HASTA+1,'DD')
                        AND SH.SHEVENTNR = 5229  AND SH.ENTITY_KEY = 24 AND SH.SHPRODUCTNR NOT IN (301,305)) ACT ON ACT.ENTITY_ID = B.AGREEMENT_DETAIL_ID
                                                                            AND TRUNC(ACT.CREATE_DATETIME) >= TRUNC(B.FECHA)
                                                                            AND B.EVENT_ID = 120
            GROUP BY B.SHSHNR
            ),           

REC  AS(SELECT B.SHSHNR         SHSHNR,
                   MIN(ACT2.SHSHNR)  SHSHNR_ACT
            FROM BASE B
            LEFT JOIN (SELECT SHSHNR, ENTITY_ID, CREATE_DATETIME
                        FROM SUHISTOR SH
                        INNER JOIN CUSTOMER C ON C.ID = SH.SHSUBSCRIBERNR AND C.CLASS_ID = 1
                        WHERE SH.CREATE_DATETIME BETWEEN :P_FECHA_DESDE AND trunc(:P_FECHA_HASTA+1,'DD')
                        AND SH.SHEVENTNR =204  AND SH.ENTITY_KEY = 24
                      ) ACT2 ON ACT2.ENTITY_ID = B.AGREEMENT_DETAIL_ID
                                                                            AND TRUNC(ACT2.CREATE_DATETIME) >= TRUNC(B.FECHA)
                                                                            AND  B.EVENT_ID = 171
            GROUP BY B.SHSHNR
            )     
-------------------------------------------------------------------------------------
SELECT
B.SHSHNR,
B.OPERADOR,
B.LEGAJO,
B.NRO_CLIENTE,
B.PREMIUM,
ADB.DESCRIPTION                                 PRODUCTO_BASICO,
B.PERFIL,
UD.TIPO                                         UPDOWN,
CASE
WHEN B.EVENT_ID = 108 THEN CPA.DESCRIPTION
ELSE NULL
END                                             PRODUCTO_ANTERIOR,
ADS1.DESCRIPTION                                ESTADO_PRODUCTO_ANTERIOR,
B.FECHA,
B.ESTADO,
TSC.FECHA                                       BAJA_PROGRAMADA,
B.EVENTO,
CASE
    WHEN SHM.ID IS NULL THEN 'NO'
    ELSE 'SI'END                                ULTIMO_MOVIMIENTO,
CASE WHEN SH_ACT.SHUSERNR IS NULL OR SH_ACT.SHUSERNR IN (10036,13) THEN
    IU_ACT.FULL_NAME
ELSE
TO_CHAR(IU.FULL_NAME)  END                                  USER_ACTIVACION,
SH_ACT.CREATE_DATETIME                          FECHA_ACTIVACION,
CASE
    WHEN SH_ACT.SHUSERNR IS NULL OR SH_ACT.SHUSERNR IN (10036,13) THEN B.OPERADOR
    ELSE TO_NCHAR(IU.FULL_NAME) END                       RANKING,
    SBS.SUBSTYPENAME TIPO_CLIENTE,
CASE WHEN REVISTA_PLATINO.CUSTOMER_ID IS NOT NULL THEN 'SI' ELSE '' END REVISTA_PLATINO,
DEVICE_DATOS.NET_TEC TECNOLOGIA,
ADR.ADDRPOSTCODE CP,
PROV.PROVINCENAME PROVINCIA
-------------------------------------------------------------------------------------
FROM BASE B
-------------------------------------------------------------------------------------
INNER JOIN ACT ON ACT.SHSHNR = B.SHSHNR
INNER JOIN REC ON REC.SHSHNR = B.SHSHNR
INNER JOIN CUSTOMER CUS ON CUS.ID = B.NRO_CLIENTE
INNER JOIN ADDRESS ADR ON ADR.ADDRCUSTNR = CUS.ID AND ADR.ADDREVENTNR = 100
INNER JOIN PROVINCE PROV ON PROV.PROVINCENUMBER = ADR.ADDRPROVINCENUMBER
INNER JOIN SUBSTYPE SBS ON SBS.ID = CUS.TYPE_ID   --MR2
LEFT JOIN SUHISTOR SH_ACT ON SH_ACT.SHSHNR = ACT.SHSHNR_ACT or SH_ACT.SHSHNR = REC.SHSHNR_ACT
left join external_agent ea on ea.id = SH_ACT.EXTERNAL_AGENT_ID
LEFT JOIN IBS_USER IU_ACT ON UPPER(IU_ACT.NAME) = UPPER(EA.NAME)
LEFT JOIN IBS_USER IU ON IU.ID = SH_ACT.SHUSERNR
-------------------------------------------------------------------------------------
LEFT JOIN (SELECT ADB.CUSTOMER_ID , CPB.DESCRIPTION
            FROM AGREEMENT_DETAIL ADB
            INNER JOIN COMMERCIAL_PRODUCT CPB ON CPB.ID = ADB.COMM_PRODUCT_ID AND CPB.CATEGORY_ID = 3 
            WHERE ADB.STATUS IN (1,7)) ADB ON ADB.CUSTOMER_ID = B.NRO_CLIENTE
------------------------------------------------------------------------------------
LEFT JOIN AGREEMENT_DETAIL ADA ON ADA.ID = B.REPLACES_PRODUCT_ID
LEFT JOIN COMMERCIAL_PRODUCT CPA ON CPA.ID = ADA.COMM_PRODUCT_ID
-------------------------------------------------------------------------------------
LEFT JOIN TELEVENTAS_UPDOWN UD ON UD.PRODUCTO_ANTERIOR_ID = CPA.ID AND UD.PRODUCTO_POSTERIOR_ID = B.PRODUCTO_BASICO_ID AND B.EVENT_ID = 108
-------------------------------------------------------------------------------------
LEFT JOIN (SELECT ADH.CUSTOMER_ID , ADH.AGREEMENT_DETAIL_ID, MAX(ADH.ID) ID 
            FROM AGREEMENT_DET_HISTORY ADH WHERE ADH.STATUS <> 13 AND ADH.COMM_PRODUCT_ID NOT IN (301,305)
            GROUP BY ADH.CUSTOMER_ID , ADH.AGREEMENT_DETAIL_ID) ADHM ON ADHM.AGREEMENT_DETAIL_ID = B.REPLACES_PRODUCT_ID
                                                                            AND ADHM.CUSTOMER_ID = B.NRO_CLIENTE
                                                                            AND B.EVENT_ID = 108
LEFT JOIN AGREEMENT_DET_HISTORY ADH ON ADH.ID = ADHM.ID
LEFT JOIN AGREEMENT_DETAIL_STATUS ADS1 ON ADS1.ID = ADH.STATUS
-------------------------------------------------------------------------------------
LEFT JOIN ( SELECT SR.CUSTOMER_ID, SR.ENTITY_ID, MAX(SR.EXECUTE_DATE) FECHA
                FROM SCHEDULE_RECORD SR
                WHERE SR.EVENT_ID = 142 AND SR.ENTITY_TYPE = 24
                GROUP BY SR.CUSTOMER_ID, SR.ENTITY_ID) TSC ON TSC.CUSTOMER_ID = B.NRO_CLIENTE
                                                                     AND TSC.ENTITY_ID = B.AGREEMENT_DETAIL_ID
                                                                     AND TSC.FECHA > B.FECHA
-------------------------------------------------------------------------------------
LEFT JOIN SHM ON SHM.ID = B.SHSHNR                                         
 ------------------------------------------------------------------------------------
--LEFT AGREGADO POR PROYECTO NEXUS-PLATINO
-------------------------------------------------------------------------------------
LEFT JOIN( SELECT AGD.CUSTOMER_ID,
                    SH.CREATE_DATETIME FECHA
            FROM AGREEMENT_DETAIL AGD
            INNER JOIN SUHISTOR SH ON SH.ENTITY_ID = AGD.ID AND SH.ENTITY_KEY = 24 AND SH.SHEVENTNR  IN (5229,108)
            WHERE SH.CREATE_DATETIME BETWEEN :P_FECHA_DESDE AND trunc(:P_FECHA_HASTA+1,'DD') 
            AND AGD.COMM_PRODUCT_ID = 252
            )REVISTA_PLATINO ON REVISTA_PLATINO.CUSTOMER_ID = B.NRO_CLIENTE AND TRUNC(B.FECHA) = TRUNC(REVISTA_PLATINO.FECHA)
------------------------------------------------------------------------------------
--LEFT AGREGADO POR PROYECTO broadband
-------------------------------------------------------------------------------------
LEFT JOIN(
                SELECT AGD.CUSTOMER_ID CUSTOMER_ID,
                            AGD.ID,
                    CP.DESCRIPTION NET_TEC
                FROM AGREEMENT_DETAIL AGD
                INNER JOIN COMMERCIAL_PRODUCT   CP ON CP.ID = AGD.COMM_PRODUCT_ID 
                                AND CP.ID IN (SELECT ID FROM COMMERCIAL_PRODUCT WHERE DESCRIPTION LIKE '%MODEM%') 
                                AND AGD.STATUS = 10
           ) DEVICE_DATOS ON DEVICE_DATOS.CUSTOMER_ID = B.NRO_CLIENTE AND B.PRODUCTO_BASICO_ID IN (SELECT ID FROM COMMERCIAL_PRODUCT WHERE (DESCRIPTION LIKE '%NET%' AND CATEGORY_ID = 1) OR CATEGORY_ID = 7 )