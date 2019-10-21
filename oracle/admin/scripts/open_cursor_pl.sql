declare
p_ejercicio NUMBER := 2019;
p_numcred NUMBER := 38957;
p_act_int VARCHAR2(32) :=  'DUW';
p_f_e_desde DATE := to_date('01-ENE-19','DD-MON-YY');
p_f_e_hasta DATE := to_date('31-DIC-19','DD-MON-YY');
p_f_i_desde DATE := to_date('01-ENE-19','DD-MON-YY');
p_f_i_hasta DATE := to_date('31-DIC-19','DD-MON-YY');
CURSOR lineas  (       p_ejercicio  IN  slu.DLOG_CRED.aa_ejervg%TYPE
                              , p_numcred    IN  slu.DLOG_CRED.c_numcred%TYPE
                              , p_act_int    IN  slu.DLOG_CRED.c_act_int%TYPE
                              , p_f_e_desde  IN  slu.DLOG_CRED.f_ejec_cred%TYPE
                              , p_f_e_hasta  IN  slu.DLOG_CRED.f_ejec_cred%TYPE
                              , p_f_i_desde  IN  slu.DLOG_CRED.f_ejec_cred%TYPE
                              , p_f_i_hasta  IN  slu.DLOG_CRED.f_ejec_cred%TYPE
                              )
            IS
              SELECT aa_ejervg,c_numcred,c_act_int,fecha_imputacion,fecha_ejecucion,tipo_formulario,
                     nro_formulario,c_delegacion,t_doc_respal,n_doc_respal,aa_doc_respal,cod_ente,
                     cuit_ente,desc_ente,vigente,restringido,preventivo,reserva_comp,comp,res_dev,dev,pagado
                FROM slu.VW_PARAM_GESTION
               WHERE aa_ejervg = p_ejercicio
                 AND c_numcred = p_numcred
                 AND c_act_int = p_act_int
              AND fecha_ejecucion  >= TRUNC(NVL(p_f_e_desde, fecha_ejecucion))
              AND fecha_ejecucion  <= TRUNC(NVL(p_f_e_hasta, fecha_ejecucion))
              AND fecha_imputacion >= TRUNC(NVL(p_f_i_desde, fecha_imputacion))
              AND fecha_imputacion <= TRUNC(NVL(p_f_i_hasta, fecha_imputacion))
              ORDER BY aa_ejervg,c_numcred,c_act_int,fecha_imputacion,fecha_ejecucion,
                       tipo_formulario,nro_formulario;
lineas_record lineas%ROWTYPE;
begin
open lineas (p_ejercicio,p_numcred, p_act_int, p_f_e_desde,p_f_e_hasta,p_f_i_desde, p_f_i_hasta);
LOOP
      FETCH lineas INTO lineas_record;
	  EXIT WHEN lineas%NOTFOUND;
end loop;
close lineas;
end;
/
