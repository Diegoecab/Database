Ver SCN Actual de la base de Datos
select timestamp_to_scn(to_timestamp(sysdate,'DD-MM-RR HH24:MI:SS')) from dual;