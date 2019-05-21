CREATE OR REPLACE PROCEDURE SUPERUSER.LOAD_ENT_IB_PROV_ALIC_RET_PREC (
   P_EMPRESA   IN   CCP_EMPRESAS.EMP_CODIGO%TYPE
)
IS
   V_PROV                CCP_PARAMETROS.PAR_ALFA%TYPE
                          := PARAMETRO_ALFA (P_EMPRESA, 'PROV_BSAS', SYSDATE);
   V_PAIS                CCP_PARAMETROS.PAR_ALFA%TYPE
                          := PARAMETRO_ALFA (P_EMPRESA, 'PAIS_ORIG', SYSDATE);
   V_VAR                 NUMBER;
   V_PRIMERA_VEZ         BOOLEAN                        := TRUE;
   V_BORRADOS            NUMBER;
   V_INSERTADOS          NUMBER;
   ---
   V_DUPLICATE_RECORDS   EXCEPTION;
BEGIN
   V_INSERTADOS := 0;

   FOR CUR_LOAD IN (SELECT A.IBRP_FCH_PUBLICACION, A.IBRP_FCH_VIGENCIA_DESDE,
                           A.IBRP_FCH_VIGENCIA_HASTA, A.IBRP_CUIT,
                           A.IBRP_TIPO_CONTRIBUYENTE, A.IBRP_MCA_ALTA_BAJA,
                           A.IBRP_MCA_CAMBIO_ALICUOTA,
                           A.IBRP_ALICUOTA_PERCEPCION,
                           A.IBRP_ALICUOTA_RETENCION,
                           A.IBRP_GRUPO_PERCEPCION, A.IBRP_GRUPO_RETENCION
                      FROM ENT_LOAD_IB_PROV_ALIC_RET_PERC A)
   LOOP
      BEGIN
         IF V_PRIMERA_VEZ
         THEN
            BEGIN
               SELECT 1
                 INTO V_VAR
                 FROM ENT_IB_PROV_ALIC_RET_PERC
                WHERE IBRP_FCH_VIGENCIA_DESDE =
                                              CUR_LOAD.IBRP_FCH_VIGENCIA_DESDE
                  AND IBRP_FCH_VIGENCIA_HASTA =
                                              CUR_LOAD.IBRP_FCH_VIGENCIA_HASTA
                  AND ROWNUM = 1;

               BEGIN
                  V_BORRADOS := 1;

                  WHILE V_BORRADOS > 0
                  LOOP
                     BEGIN
                        DELETE      ENT_IB_PROV_ALIC_RET_PERC
                              WHERE IBRP_FCH_VIGENCIA_DESDE =
                                             CUR_LOAD.IBRP_FCH_VIGENCIA_DESDE
                                AND IBRP_FCH_VIGENCIA_HASTA =
                                              CUR_LOAD.IBRP_FCH_VIGENCIA_HASTA
                                AND ROWNUM < 10000;

                        V_BORRADOS := SQL%ROWCOUNT;
                        COMMIT;
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           RAISE_APPLICATION_ERROR
                              (-20901,
                                  'Error al borrar ent_ib_prov_alic_ret_perc '
                               || SQLERRM
                              );
                     END;
                  END LOOP;
               END;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
               WHEN OTHERS
               THEN
                  RAISE_APPLICATION_ERROR
                               (-20902,
                                   'Error al leer ent_ib_prov_alic_ret_perc '
                                || SQLERRM
                               );
            END;

            V_PRIMERA_VEZ := FALSE;
         END IF;                                         -- v_primera_vez then

         INSERT INTO /*+ Append*/ ENT_IB_PROV_ALIC_RET_PERC
                     (IBRP_FCH_PUBLICACION,
                      IBRP_FCH_VIGENCIA_DESDE,
                      IBRP_FCH_VIGENCIA_HASTA, IBRP_CUIT,
                      IBRP_TIPO_CONTRIBUYENTE,
                      IBRP_MCA_ALTA_BAJA,
                      IBRP_MCA_CAMBIO_ALICUOTA,
                      IBRP_ALICUOTA_PERCEPCION,
                      IBRP_ALICUOTA_RETENCION,
                      IBRP_GRUPO_PERCEPCION,
                      IBRP_GRUPO_RETENCION, PAIS_CODIGO, PROV_CODIGO
                     )
              VALUES (CUR_LOAD.IBRP_FCH_PUBLICACION,
                      CUR_LOAD.IBRP_FCH_VIGENCIA_DESDE,
                      CUR_LOAD.IBRP_FCH_VIGENCIA_HASTA, CUR_LOAD.IBRP_CUIT,
                      CUR_LOAD.IBRP_TIPO_CONTRIBUYENTE,
                      CUR_LOAD.IBRP_MCA_ALTA_BAJA,
                      CUR_LOAD.IBRP_MCA_CAMBIO_ALICUOTA,
                      CUR_LOAD.IBRP_ALICUOTA_PERCEPCION,
                      CUR_LOAD.IBRP_ALICUOTA_RETENCION,
                      CUR_LOAD.IBRP_GRUPO_PERCEPCION,
                      CUR_LOAD.IBRP_GRUPO_RETENCION, V_PAIS, V_PROV
                     );

         V_INSERTADOS := V_INSERTADOS + 1;

         IF MOD (V_INSERTADOS, 10000) = 0
         THEN
            COMMIT;
         END IF;
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            RAISE V_DUPLICATE_RECORDS;
      END;
   END LOOP;

   --Trunca la Tabla Plana
--DELETE FROM ent_load_ib_prov_alic_ret_prec;
   COMMIT;
EXCEPTION
   WHEN V_DUPLICATE_RECORDS
   THEN
      RAISE_APPLICATION_ERROR (-20998,
                               'Error : Existen Registros Duplicados !!!!'
                              );
   WHEN OTHERS
   THEN
      RAISE_APPLICATION_ERROR (-20999,
                               SUBSTR (   'Error '
                                       || TO_CHAR (SQLCODE)
                                       || ': '
                                       || SQLERRM,
                                       1,
                                       255
                                      )
                              );
END LOAD_ENT_IB_PROV_ALIC_RET_PREC;
/