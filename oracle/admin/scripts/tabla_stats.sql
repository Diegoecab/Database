/* tablas que tienen más borrados en los últimos 7 días */

SELECT dueno , tabla
         FROM (SELECT table_owner dueno,
                      table_name tabla
                 FROM sys.dba_tab_modifications
                WHERE deletes > 0
                  AND timestamp > sysdate -7
                ORDER BY deletes DESC)
                WHERE rownum <= 10; 


/* Procedure que envia mail despues de ejecutar estadisticas ...*/

create or replace procedure RESCATA_ESTAT is
     — Se setean los parámetros del servidor de correos 

     l_mailhost    VARCHAR2(64) := ‘número de IP’;
     l_from        VARCHAR2(64) := ‘Automatizacion_Jobs’;
     l_subject     VARCHAR2(64) := ‘Recopilación de estadisticas base de datos’;
     l_to          VARCHAR2(64) := ‘correo@correo.com’; 

     l_mail_conn   UTL_SMTP.connection;                 

     –Se genera el cursor con las tablas que tienen más borrados en los últimos 7 días
     cursor c1 is 


       SELECT dueno , tabla
         FROM (SELECT table_owner dueno,
                      table_name tabla
                 FROM sys.dba_tab_modifications
                WHERE deletes > 0
                  AND timestamp > sysdate -7
                ORDER BY deletes DESC)
                WHERE rownum <= 10; 


     var_sentencia varchar2(1000); 

      begin            

        –Se realiza la conexión al servidor de correos
        l_mail_conn := UTL_SMTP.open_connection(l_mailhost, 25);
        UTL_SMTP.helo(l_mail_conn, l_mailhost);
        UTL_SMTP.mail(l_mail_conn, l_from);
        UTL_SMTP.rcpt(l_mail_conn, l_to);
        UTL_SMTP.open_data(l_mail_conn);             

        –Se escribe el encabezado del correo
        UTL_SMTP.write_data(l_mail_conn, ‘Date: ‘ || TO_CHAR(SYSDATE, ‘DD-MON-YYYY HH24:MI:SS’) || Chr(13));
        UTL_SMTP.write_data(l_mail_conn, ‘From: ‘ || l_from || Chr(13));
        UTL_SMTP.write_data(l_mail_conn, ‘Subject: ‘ || l_subject || Chr(13));
        UTL_SMTP.write_data(l_mail_conn, ‘To: ‘ || l_to || Chr(13));
        UTL_SMTP.write_data(l_mail_conn, ” || Chr(13)); 

      for c1_aux in c1 loop

        –Se obtienen datos en forma dinámica desde el cursor y se parámetriza la llamada al procedimiento para recopilar estdísticas
        var_sentencia := ‘begin DBMS_STATS.GATHER_TABLE_STATS( OWNNAME=>’||””||c1_aux.dueno||””||’, TABNAME=> ‘||””||c1_aux.tabla         ||””||’ , ESTIMATE_PERCENT=>dbms_stats.auto_sample_size , METHOD_OPT=>’||””||’FOR ALL INDEXED COLUMNS’||””||’); end;’;                 

        –dbms_output.put_line(var_sentencia);                  
        –Se escriben más datos en la salida del correo
        UTL_SMTP.write_data(l_mail_conn, ‘**********************************************************’ ||Chr(13)||Chr(13));
        UTL_SMTP.write_data(l_mail_conn, ‘Tabla procesada:’ ||  c1_aux.dueno||’.'||c1_aux.tabla ||Chr(13)||Chr(13));                

        execute immediate var_sentencia;

      end loop;
 

      UTL_SMTP.write_data(l_mail_conn, ‘**********************************************************’ ||Chr(13)||Chr(13));
      UTL_SMTP.close_data(l_mail_conn);
      UTL_SMTP.quit(l_mail_conn);     

 end RESCATA_ESTAT;
 / 















IMPORTANTE¡¡¡


Como la información almacenada en la tabla SYS.DBA_TAB_MODIFICATIONS, proviene desde memoria , no es necesario esperar a que Oracle haga el vaciado de esta información , que en 9i es cada 15 minutos, esto se puede llevar a cabo ejecutándo el procedimiento

exec dbms_stats.FLUSH_DATABASE_MONITORING_INFO();

Lo cual hace que todas las tablas *_TAB_MODIFICATIONS , *_TAB_STATISTICS y *_IND_STATISTICS queden actualizada con la información que hay en ese momento en memoria

Si se necesita parar el monitoreo para una tabla

ALTER TABLE [NOMBRE_TABLA] NOMONITORING;










select column_name,NUM_DISTINCT,(select num_rows from DBA_TABLES where table_name = 'ACTA_ESTADOS' and owner='SAI') num_rows 
from DBA_TAB_COL_STATISTICS where table_name = 'ACTA_ESTADOS' and owner = 'SAI' and num_distinct > 
(select num_rows from DBA_TABLES where table_name = 'ACTA_ESTADOS' and owner='SAI')/2 order by 2 desc,1;

