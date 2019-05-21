SELECT s.empnro,
          s.suc_id,
          s.suc,
          e.desc_empresa empresa,
          UPPER (s.nombre) sucursal,
          DECODE (re.estado, 'N', 'NO CONFIRMADO', 'C', 'CONFIRMADO') estado,
          NVL (rd.presente,
               DECODE (rd.rango1 + rd.rango2 + rd.rango3 + rd.rango4 + rd.rango5 + rd.rango6 + rd.rango7 + rd.rango8 + rd.rango9 + rd.rango10 + rd.rango11 + rd.rango12 + rd.rango13 + rd.rango14
                       + rd.rango15 + rd.rango16 + rd.rango17 + rd.rango18 + rd.rango19 + rd.rango20 + rd.rango21 + rd.rango22 + rd.rango23 + rd.rango24,
                       0, 'N',
                       'S')) presente,
          r.fecha,
          f.descripcion funcion,
          p.legajo,
          p.apellido,
          p.nombre,
          to_char(rd.rango1,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango1,
          to_char(rd.rango2,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango2,
          to_char(rd.rango3,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango3,
          to_char(rd.rango4,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango4,
          to_char(rd.rango5,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango5,
          to_char(rd.rango6,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango6,
          to_char(rd.rango7,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango7,
          to_char(rd.rango8,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango8,
          to_char(rd.rango9,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango9,
          to_char(rd.rango10,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango10,
          to_char(rd.rango11,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango11,
          to_char(rd.rango12,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango12,
          to_char(rd.rango13,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango13,
          to_char(rd.rango14,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango14,
          to_char(rd.rango15,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango15,
          to_char(rd.rango16,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango16,
          to_char(rd.rango17,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango17,
          to_char(rd.rango18,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango18,
          to_char(rd.rango19,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango19,
          to_char(rd.rango20,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango20,
          to_char(rd.rango21,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango21,
          to_char(rd.rango22,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango22,
          to_char(rd.rango23,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango23,
          to_char(rd.rango24,'99G990D99',  'NLS_NUMERIC_CHARACTERS = '',.''') rango24,
          f.ID cod_funcion,
          RE.fecha_estado
     FROM garbarrhh.ina_reportes r,
          (SELECT   rep_id,
                    persona_id,
                    fecha,
                    MAX (funcion_id) funcion_id,
                    MAX (presente) presente,
                    SUM (rango1) rango1,
                    SUM (rango2) rango2,
                    SUM (rango3) rango3,
                    SUM (rango4) rango4,
                    SUM (rango5) rango5,
                    SUM (rango6) rango6,
                    SUM (rango7) rango7,
                    SUM (rango8) rango8,
                    SUM (rango9) rango9,
                    SUM (rango10) rango10,
                    SUM (rango11) rango11,
                    SUM (rango12) rango12,
                    SUM (rango13) rango13,
                    SUM (rango14) rango14,
                    SUM (rango15) rango15,
                    SUM (rango16) rango16,
                    SUM (rango17) rango17,
                    SUM (rango18) rango18,
                    SUM (rango19) rango19,
                    SUM (rango20) rango20,
                    SUM (rango21) rango21,
                    SUM (rango22) rango22,
                    SUM (rango23) rango23,
                    SUM (rango24) rango24
               FROM (SELECT rep_id,
                            persona_id,
                            fecha,
                            presente,
                            funcion_id,
                            ROUND (CASE
                                      WHEN ingreso_hora = 0 THEN CASE
                                                                   WHEN egreso_hora = 0 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE 0
                                   END, 2) rango1,
                            ROUND (CASE
                                      WHEN ingreso_hora = 1 THEN CASE
                                                                   WHEN egreso_hora = 1 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 1 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 1 AND egreso_hora > 1) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango2,
                            ROUND (CASE
                                      WHEN ingreso_hora = 2 THEN CASE
                                                                   WHEN egreso_hora = 2 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 2 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 2 AND egreso_hora > 2) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango3,
                            ROUND (CASE
                                      WHEN ingreso_hora = 3 THEN CASE
                                                                   WHEN egreso_hora = 3 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 3 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 3 AND egreso_hora > 3) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango4,
                            ROUND (CASE
                                      WHEN ingreso_hora = 4 THEN CASE
                                                                   WHEN egreso_hora = 4 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 4 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 4 AND egreso_hora > 4) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango5,
                            ROUND (CASE
                                      WHEN ingreso_hora = 5 THEN CASE
                                                                   WHEN egreso_hora = 5 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 5 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 5 AND egreso_hora > 5) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango6,
                            ROUND (CASE
                                      WHEN ingreso_hora = 6 THEN CASE
                                                                   WHEN egreso_hora = 6 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 6 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 6 AND egreso_hora > 6) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango7,
                            ROUND (CASE
                                      WHEN ingreso_hora = 7 THEN CASE
                                                                   WHEN egreso_hora = 71 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 7 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 7 AND egreso_hora > 7) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango8,
                            ROUND (CASE
                                      WHEN ingreso_hora = 8 THEN CASE
                                                                   WHEN egreso_hora = 8 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 8 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 8 AND egreso_hora > 8) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango9,
                            ROUND (CASE
                                      WHEN ingreso_hora = 9 THEN CASE
                                                                   WHEN egreso_hora = 9 THEN (egreso_min - ingreso_min) / 60
                                                                   ELSE CASE
                                                                   WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                   ELSE 1
                                                                END
                                                                END
                                      ELSE CASE
                                      WHEN egreso_hora = 9 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 9 AND egreso_hora > 9) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango10,
                            ROUND (CASE
                                      WHEN ingreso_hora = 10 THEN CASE
                                                                    WHEN egreso_hora = 10 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 10 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 10 AND egreso_hora > 10) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango11,
                            ROUND (CASE
                                      WHEN ingreso_hora = 11 THEN CASE
                                                                    WHEN egreso_hora = 11 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 11 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 11 AND egreso_hora > 11) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango12,
                            ROUND (CASE
                                      WHEN ingreso_hora = 12 THEN CASE
                                                                    WHEN egreso_hora = 12 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 12 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 12 AND egreso_hora > 12) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango13,
                            ROUND (CASE
                                      WHEN ingreso_hora = 13 THEN CASE
                                                                    WHEN egreso_hora = 13 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 13 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 13 AND egreso_hora > 13) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango14,
                            ROUND (CASE
                                      WHEN ingreso_hora = 14 THEN CASE
                                                                    WHEN egreso_hora = 14 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 14 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 14 AND egreso_hora > 14) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango15,
                            ROUND (CASE
                                      WHEN ingreso_hora = 15 THEN CASE
                                                                    WHEN egreso_hora = 15 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 15 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 15 AND egreso_hora > 15) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango16,
                            ROUND (CASE
                                      WHEN ingreso_hora = 16 THEN CASE
                                                                    WHEN egreso_hora = 16 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 16 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 16 AND egreso_hora > 16) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango17,
                            ROUND (CASE
                                      WHEN ingreso_hora = 17 THEN CASE
                                                                    WHEN egreso_hora = 17 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 17 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 17 AND egreso_hora > 17) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango18,
                            ROUND (CASE
                                      WHEN ingreso_hora = 18 THEN CASE
                                                                    WHEN egreso_hora = 18 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 18 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 18 AND egreso_hora > 18) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango19,
                            ROUND (CASE
                                      WHEN ingreso_hora = 19 THEN CASE
                                                                    WHEN egreso_hora = 19 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 19 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 19 AND egreso_hora > 19) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango20,
                            ROUND (CASE
                                      WHEN ingreso_hora = 20 THEN CASE
                                                                    WHEN egreso_hora = 20 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 20 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 20 AND egreso_hora > 20) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango21,
                            ROUND (CASE
                                      WHEN ingreso_hora = 21 THEN CASE
                                                                    WHEN egreso_hora = 21 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 21 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 21 AND egreso_hora > 21) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango22,
                            ROUND (CASE
                                      WHEN ingreso_hora = 22 THEN CASE
                                                                    WHEN egreso_hora = 22 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 22 THEN egreso_min / 60
                                      ELSE CASE
                                      WHEN (ingreso_hora < 22 AND egreso_hora > 22) THEN 1
                                      ELSE 0
                                   END
                                   END
                                   END,
                                   2) rango23,
                            ROUND (CASE
                                      WHEN ingreso_hora = 23 THEN CASE
                                                                    WHEN egreso_hora = 23 THEN (egreso_min - ingreso_min) / 60
                                                                    ELSE CASE
                                                                    WHEN ingreso_min > 0 THEN (60 - ingreso_min) / 60
                                                                    ELSE 1
                                                                 END
                                                                 END
                                      ELSE CASE
                                      WHEN egreso_hora = 23 THEN egreso_min / 60
                                      ELSE 0
                                   END
                                   END,
                                   2) rango24
                       FROM (SELECT rep_id,
                                    persona_id,
                                    funcion_id,
                                    TO_CHAR (fecha, 'mmyyyy') fecha,
                                    presente,
                                    TO_CHAR (ingreso, 'hh24') ingreso_hora,
                                    TO_CHAR (ingreso, 'mi') ingreso_min,
                                    TO_CHAR (egreso, 'hh24') egreso_hora,
                                    TO_CHAR (egreso, 'mi') egreso_min
                               FROM garbarrhh.ina_reporte_detalles
                              WHERE (ingreso IS NOT NULL AND egreso IS NOT NULL) OR (ingreso IS NULL AND egreso IS NULL)))
           GROUP BY rep_id, persona_id, fecha) rd,
          garbarrhh.por_personas p,
          garbarrhh.por_sucursales s,
          garbarrhh.por_empresas e,
          garbarrhh.vw_funciones f,
          (SELECT re2.rep_id, re2.estado, re2.fecha_estado
             FROM garbarrhh.ina_reporte_estados re2
            WHERE (re2.rep_id, re2.rep_est_id) IN (SELECT   re1.rep_id, MAX (re1.rep_est_id) rep_est_id
                                                       FROM garbarrhh.ina_reporte_estados re1
                                                   GROUP BY re1.rep_id)) re
    WHERE r.rep_id = rd.rep_id AND p.persona_id = rd.persona_id AND r.suc_id = s.suc_id AND s.empnro = e.empnro AND f.ID(+) = rd.funcion_id AND r.rep_id = re.rep_id
/
