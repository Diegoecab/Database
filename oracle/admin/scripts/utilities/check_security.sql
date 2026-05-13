REM    Chequeo Seguridad de base de datos
REM ======================================================================
REM check_security.sql        Version 1.1    23 Agosto 2010
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM
REM Dependencias:
REM
REM Notas:
REM     Ejecutar con usuario dba
REM    Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM
REM ======================================================================
REM
SET feedback off
--HOST del c:\prueba.html
SET serveroutput on
ALTER SESSION SET nls_date_format='dd/mm/yyyy hh24:mi:ss';

accept narchivo prompt 'Ingrese nombre de archivo a generar con extension html (Ej. c:\check_security.html) :  '

SPOOL &narchivo rep
/*
AUDITORIA:

alter system set audit_sys_operations= TRUE  scope=spfile;
alter system set audit_trail='DB_EXTENDED' scope=spfile;

--GRANT/REVOKE                TODOS LOS USUARIOS                    ->            
audit grant any object privilege by access  whenever not successful;
audit grant any object privilege by access  whenever successful;
--audit revoke any object by access whenever not successful; 
--audit revoke any object privilege by access whenever successful; 
audit grant any privilege by access  whenever not successful;
audit grant any privilege by access  whenever successful;
--audit revoke any privilege by access  whenever not successful;
--audit revoke any privilege by access  whenever successful;
audit grant any role by access  whenever not successful;
audit grant any role by access  whenever successful;
--audit revoke any role by access  whenever not successful;
--audit revoke any role by access  whenever successful;
--ALTER/DROP CLUSTER            USUARIOS CON PRIVILEGIOS ESPECIALES ->            
audit drop any cluster by system by access whenever not successful;
audit drop any cluster by system by access whenever successful;
audit alter any cluster by system by access whenever not successful;
audit alter any cluster by system by access whenever successful;
--ALTER DATABASE                USUARIOS CON PRIVILEGIOS ESPECIALES ->             
audit alter database by system by access whenever not successful;
audit alter database by system by access whenever successful;
--ALTER/DROP INDEX            USUARIOS CON PRIVILEGIOS ESPECIALES ->             
audit drop any index by system by access whenever not successful;
audit drop any index by system by access whenever successful;
audit alter any index by system by access whenever not successful;
audit alter any index by system by access whenever successful;
--ALTER/DROP PROCEDURE        USUARIOS CON PRIVILEGIOS ESPECIALES ->            
audit drop any procedure by system by access whenever not successful;
audit drop any procedure by system by access whenever successful;
audit alter any procedure by system by access whenever not successful;
audit alter any procedure by system by access whenever successful;
--CREATE/ALTER/DROP PROFILE    TODOS LOS USUARIOS->                            
audit create profile by access whenever not successful; 
audit create profile by access whenever successful; 
audit alter profile by system by access whenever not successful; 
audit alter profile by system by access whenever successful; 
audit create profile by access whenever successful; 
audit drop profile by system by access whenever not successful;
audit drop profile by system by access whenever successful;
audit create profile by access whenever successful; 
--CREATE/ALTER/DROP USER        TODOS LOS USUARIOS->                            
audit create user by access whenever not successful; 
audit create user by access whenever successful; 
audit alter user by access whenever not successful;  
audit alter user by access whenever successful;  
audit drop user by access whenever not successful; 
audit drop user by access whenever successful; 
--CREATE/ALTER/DROP ROLE        TODOS LOS USUARIOS->                            
audit create role by access whenever not successful; 
audit create role by access whenever successful; 
audit alter any role by access whenever not successful; 
audit alter any role by access whenever successful; 
audit drop any role by access whenever not successful;
audit drop any role by access whenever successful;
--ALTER/DROP ROLLBACK SEGMENT    USUARIOS CON PRIVILEGIOS ESPECIALES ->            
audit alter rollback segment by system by access whenever not successful;
audit alter rollback segment by system by access whenever successful;
audit drop rollback segment by system by access whenever not successful;
audit drop rollback segment by system by access whenever successful;
--ALTER/DROP SEQUENCE            USUARIOS CON PRIVILEGIOS ESPECIALES ->            
audit alter any sequence by system by access whenever not successful;  
audit alter any sequence by system by access whenever successful;  
audit drop any sequence by system by access whenever not successful;
audit drop any sequence by system by access whenever successful;
--ALTER/CREATE SESSION         TODOS LOS USUARIOS    (inc intentos fallidos) ->  
audit create session whenever not successful; 
audit create session whenever successful;
audit alter session whenever not successful; 
audit alter session whenever successful;
--DROP SYNONYM                USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit drop any synonym by system by access whenever not successful;
audit drop any synonym by system by access whenever successful;
--ALTER/INSERT/UPDATE/DELETE TABLE    USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter any table by system by access whenever not successful;
audit alter any table by system by access whenever successful;
audit insert any table by system by access whenever not successful;
audit insert any table by system by access whenever successful;
audit update any table by system by access whenever not successful;
audit update any table by system by access whenever successful;
audit delete any table by system by access whenever not successful;
audit delete any table by system by access whenever successful;
--ALTER/DROP TABLESPACE        USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter tablespace by system by access whenever not successful;
audit alter tablespace by system by access whenever successful;
audit drop tablespace by system by access whenever not successful;
audit drop tablespace by system by access whenever successful;
--ALTER/DROP TRIGGER            USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter any trigger by system by access whenever not successful;
audit alter any trigger by system by access whenever successful;
audit drop any trigger by system by access whenever not successful;
audit drop any trigger by system by access whenever successful;
--ALTER/DROP/INSERT/DELETE VIEW    USUARIOS CON PRIVILEGIOS ESPECIALES -> !! Alter INsert y Delete no aplica a vistas!!
audit drop any view by system by access whenever not successful;
audit drop any view by system by access whenever successful;
audit create any view by system by access whenever not successful;
audit create any view by system by access whenever successful;

Administración de Usuarios y Roles 

CREATE ROLE SECUR_ADMIN not identified;

GRANT CREATE SESSION TO SECUR_ADMIN;
GRANT ALTER SESSION TO SECUR_ADMIN;
GRANT CREATE PROFILE TO SECUR_ADMIN;
GRANT ALTER PROFILE TO SECUR_ADMIN;
GRANT DROP PROFILE TO SECUR_ADMIN;
GRANT CREATE ROLE TO SECUR_ADMIN;
GRANT ALTER ANY ROLE TO SECUR_ADMIN;
GRANT GRANT ANY ROLE TO SECUR_ADMIN;
GRANT DROP ANY ROLE TO SECUR_ADMIN;
GRANT CREATE USER TO SECUR_ADMIN;
GRANT ALTER USER TO SECUR_ADMIN;
GRANT DROP USER  TO SECUR_ADMIN;

--Valores Generales

alter system set RESOURCE_LIMIT = TRUE scope=spfile;

REVOKE EXECUTE ON SYS.UTL_FILE FROM PUBLIC;
REVOKE EXECUTE ON SYS.UTL_TCP FROM PUBLIC;
REVOKE EXECUTE ON SYS.UTL_SMTP FROM PUBLIC;
REVOKE EXECUTE ON SYS.UTL_HTTP FROM PUBLIC;
REVOKE EXECUTE ON SYS.DBMS_LOB FROM PUBLIC;
REVOKE EXECUTE ON SYS.DBMS_SQL FROM PUBLIC;
REVOKE EXECUTE ON SYS.DBMS_JOB FROM PUBLIC;
REVOKE EXECUTE ON SYS.DBMS_RANDOM FROM PUBLIC;
REVOKE EXECUTE ON SYS.DBMS_OBFUSCATION_TOOLKIT FROM PUBLIC;

alter system set log_archive_format='ORACLE_SIDredo_log_%s_%t_%r.bck' scope=spfile; --Reemplazar ORACLE_SID por el valor!


CREATE OR REPLACE FUNCTION SYS.verify_function (
   username       VARCHAR2,
   PASSWORD       VARCHAR2,
   old_password   VARCHAR2
)
   RETURN BOOLEAN
IS
   m            INTEGER;
   differ       INTEGER;
   isdigit      BOOLEAN;
   ischar       BOOLEAN;
   ispunct      BOOLEAN;
   digitarray   VARCHAR2 (20);
   punctarray varchar2(25);
   chararray    VARCHAR2 (52);
BEGIN
   digitarray := '0123456789';
   chararray := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
   punctarray := '!"#$%&()''*+,-/:;<=>?_';                --Caracter especial

   --Check if the password is same as the username
   IF PASSWORD = username
   THEN
--      dbms_output.put_line (1);
      raise_application_error (-20001, 'Password same as user');
   END IF;

   --Check for the minimum length of the password
   IF LENGTH (PASSWORD) < 8
   THEN
--      dbms_output.put_line (1);
      raise_application_error (-20002, 'Longuitud de password inferior a 8');
   END IF;

   --Check if the password is too simple. A dictionary of words may be
   --maintained and a check may be made so as not to allow the words
   --that are too simple for the password.
   IF NLS_LOWER (PASSWORD) IN
         ('welcome',
          'database',
          'account',
          'user',
          'password',
          'oracle',
          'computer',
          'abcd',
          'garbarino',
          'garba',
          'tiger'
         )
   THEN
      raise_application_error (-20002, 'Password too simple');
   END IF;

   --Check if the password contains at least one letter,
   --one digit and one punctuation mark.
   --1. Check for the digit
   --You may delete 1. and replace with 2. or 3. REEMPLAZADO
   isdigit := FALSE;
   m := LENGTH (PASSWORD);

   FOR i IN 1 .. 10
   LOOP
      FOR j IN 1 .. m
      LOOP
         IF SUBSTR (PASSWORD, j, 1) = SUBSTR (digitarray, i, 1)
         THEN
            isdigit := TRUE;
         --  GOTO findchar;
         END IF;
      END LOOP;
   END LOOP;

   IF isdigit = FALSE
   THEN
--      dbms_output.put_line (2);
      raise_application_error
                    (-20003,
                     'Password should contain at least one numeric character'
                    );
   END IF;

   --2. Check for the character <<findchar>>
   ischar := FALSE;

   FOR i IN 1 .. LENGTH (chararray)
   LOOP
      FOR j IN 1 .. m
      LOOP
         IF SUBSTR (PASSWORD, j, 1) = SUBSTR (chararray, i, 1)
         THEN
            ischar := TRUE;
         --  GOTO findpunct;
         END IF;
      END LOOP;
   END LOOP;

   IF ischar = FALSE
   THEN
--      dbms_output.put_line (3);
      raise_application_error
                            (-20003,
                             'Password should contain at least one character'
                            );
   END IF;

   --3. Check for the punctuation <<findpunct>>
   ispunct := FALSE;

   FOR i IN 1 .. LENGTH (punctarray)
   LOOP
      FOR j IN 1 .. m
      LOOP
         IF SUBSTR (PASSWORD, j, 1) = SUBSTR (punctarray, i, 1)
         THEN
            ispunct := TRUE;
            GOTO endsearch;
         END IF;
      END LOOP;
   END LOOP;

   IF ispunct = FALSE
   THEN
      raise_application_error
         (-20003,
          'La password debe ser alfanumerico y con al menos un caracter especial'
         );
   END IF;

   <<endsearch>>
   --Check if the password differs from the previous password by at least 3 letters

   --    IF old_password is null THEN
--      dbms_output.put_line (4);
     -- raise_application_error(-20004, 'Old password is null');
    --END IF;
    --Everything is fine; return TRUE ;
   differ := LENGTH (old_password) - LENGTH (PASSWORD);

   IF ABS (differ) < 3
   THEN
      IF LENGTH (PASSWORD) < LENGTH (old_password)
      THEN
         m := LENGTH (PASSWORD);
      ELSE
         m := LENGTH (old_password);
      END IF;

      differ := ABS (differ);

      FOR i IN 1 .. m
      LOOP
         IF SUBSTR (PASSWORD, i, 1) != SUBSTR (old_password, i, 1)
         THEN
            differ := differ + 1;
         END IF;
      END LOOP;

      IF differ < 3
      THEN
--        dbms_output.put_line (5);
         raise_application_error
                           (-20004,
                            'Password should differ by at least 3 characters'
                           );
      END IF;
   END IF;

   --Everything is fine; return TRUE ;
   RETURN (TRUE);
END;
/


CREATE PROFILE USUARIO_FINAL LIMIT
  SESSIONS_PER_USER 1
  CPU_PER_SESSION UNLIMITED
  CPU_PER_CALL UNLIMITED
  CONNECT_TIME UNLIMITED
  IDLE_TIME 15
  LOGICAL_READS_PER_SESSION UNLIMITED
  LOGICAL_READS_PER_CALL UNLIMITED
  COMPOSITE_LIMIT UNLIMITED
  PRIVATE_SGA UNLIMITED
  FAILED_LOGIN_ATTEMPTS 3
  PASSWORD_LIFE_TIME 30
  PASSWORD_REUSE_TIME 30
  PASSWORD_REUSE_MAX 10
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME 1
  PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION;

*/

DECLARE
   vaux     NUMBER         := 0;
   dbname   VARCHAR2 (100);
BEGIN
   SELECT display_value
     INTO dbname
     FROM v$parameter
    WHERE UPPER (NAME) = 'DB_NAME';

   DBMS_OUTPUT.put_line
      (   '
<html>
<head>
<title>Oracle - Seguridad Base de datos : '
       || dbname
       || '   '
       || SYSDATE
       || '</title>
<style type="text/css">
 body { font-family: verdana, arial; }
 table.stats
{text-align: center;
font-family: Verdana, Geneva, Arial, Helvetica, sans-serif ;
font-weight: normal;
font-size: 9px;
color: #555;
width: 280px;
border: 1px solid #D4E0EE;
border-collapse: collapse;
border-spacing: 0px;}

table.stats td
{padding: 4px;
}

table.stats tbody tr { background: #FCFDFE; }

table.stats tbody tr.odd { background: #F7F9FC; }

table.stats td.hed
{background-color: #666;
color: #fff;
padding: 4px;
text-align: left;
border-bottom: 2px #fff solid;
font-size: 12px;
font-weight: bold;}

p {
border: 3px solid #D4E0EE;
font-size: 14px;
padding: 5px 0 0 20px;
letter-spacing: -1px;
font-weight: 80;
font-family: Arial;
} 

p.okk {
border: none;
font-size: 14px;
background: #99FFCC;
letter-spacing: -1px;
font-weight: 80;
}

p.war {
border: none;
font-size: 14px;
background: #FFFF00;
letter-spacing: -1px;
font-weight: 80;
}
 </style>
</head>
<body>'
      );
   DBMS_OUTPUT.put_line
      (   '<hr> 
<h2 align="center"> Configuracion de seguridad - Oracle Database 10g</h2>
<h5> Base de datos: '
       || dbname
       || ' <br>
Fecha: '
       || SYSDATE
       || '<br>
Ejecutado con usuario: '
       || USER
       || '<br>
Desde IP: '
       || SYS_CONTEXT ('USERENV', 'IP_ADDRESS')
       || '</h5>

<hr>'
      );
   DBMS_OUTPUT.put_line ('<h4>Auditoria</h4>');
/*3.1
Aspectos generales    Dentro del archivo INIT<SID>.ora colocar:
        •  AUDIT_TRAIL = DB_EXTENDED
        •  AUDIT_SYS_OPERATIONS = TRUE
        •  AUDIT_FILE_DEST = 'directorio donde se almacenan las trazas'
El grupo DBA de Unix NO debe poseer permiso de escritura sobre el directorio especificado en el parámetro AUDIT_FILE_DEST
como así tampoco sobre los archivos que este directorio contenga.

*/
   DBMS_OUTPUT.put_line
      ('<p>Dentro del archivo INIT<SID>.ora colocar: <br>
AUDIT_TRAIL = DB_EXTENDED <br>
AUDIT_SYS_OPERATIONS = TRUE <br>
AUDIT_FILE_DEST = ''directorio donde se almacenan las trazas''<br>
El grupo DBA de Unix NO debe poseer permiso de escritura sobre el directorio especificado en el parámetro AUDIT_FILE_DEST <br>
como así tampoco sobre los archivos que este directorio contenga.</p>'
      );
/* TABLA 11 */
        --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
        <tbody><tr>
            <th align="center" width="20%">PARAMETRO</th>
            <th align="center" width="20%">VALOR</th>
            </tr>'
      );

   FOR r IN (SELECT NAME, display_value
               FROM v$parameter
              WHERE UPPER (NAME) IN
                       ('AUDIT_TRAIL',
                        'AUDIT_SYS_OPERATIONS',
                        'AUDIT_FILE_DEST'
                       ))
   LOOP
      IF     UPPER (r.NAME) = 'AUDIT_TRAIL'
         AND UPPER (r.display_value) <> 'DB_EXTENDED'
      THEN
         vaux := 1;
      END IF;

      IF     UPPER (r.NAME) = 'AUDIT_SYS_OPERATIONS'
         AND UPPER (r.display_value) <> 'TRUE'
      THEN
         vaux := 1;
      END IF;

      DBMS_OUTPUT.put_line
                      (   '<tr><td valign="top">'
                       || r.NAME
                       || '</td>
                          <td valign="top">'
                       || r.display_value
                       || ' </td> </tr>'
                      );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

   /* FIN TABLA 11*/
   IF vaux = 1
   THEN                  --Tengo usuarios que no estan expirados y bloqueados:
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Uno o mas parametros deben ser modificados</p>'
         );
      vaux := 0;
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

/* 3.2    Auditoría de Acciones    Las acciones que deben ser auditadas en la base de datos son las siguientes:

--GRANT/REVOKE                TODOS LOS USUARIOS                    ->
audit grant any object privilege by access  whenever not successful;
audit grant any object privilege by access  whenever successful;
--audit revoke any object by access whenever not successful;
--audit revoke any object privilege by access whenever successful;
audit grant any privilege by access  whenever not successful;
audit grant any privilege by access  whenever successful;
--audit revoke any privilege by access  whenever not successful;
--audit revoke any privilege by access  whenever successful;
audit grant any role by access  whenever not successful;
audit grant any role by access  whenever successful;
--audit revoke any role by access  whenever not successful;
--audit revoke any role by access  whenever successful;
--ALTER/DROP CLUSTER            USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit drop any cluster by system by access whenever not successful;
audit drop any cluster by system by access whenever successful;
audit alter any cluster by system by access whenever not successful;
audit alter any cluster by system by access whenever successful;
--ALTER DATABASE                USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter database by system by access whenever not successful;
audit alter database by system by access whenever successful;
--ALTER/DROP INDEX            USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit drop any index by system by access whenever not successful;
audit drop any index by system by access whenever successful;
audit alter any index by system by access whenever not successful;
audit alter any index by system by access whenever successful;
--ALTER/DROP PROCEDURE        USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit drop any procedure by system by access whenever not successful;
audit drop any procedure by system by access whenever successful;
audit alter any procedure by system by access whenever not successful;
audit alter any procedure by system by access whenever successful;
--CREATE/ALTER/DROP PROFILE    TODOS LOS USUARIOS->
audit create profile by access whenever not successful;
audit create profile by access whenever successful;
audit alter profile by system by access whenever not successful;
audit alter profile by system by access whenever successful;
audit create profile by access whenever successful;
audit drop profile by system by access whenever not successful;
audit drop profile by system by access whenever successful;
audit create profile by access whenever successful;
--CREATE/ALTER/DROP USER        TODOS LOS USUARIOS->
audit create user by access whenever not successful;
audit create user by access whenever successful;
audit alter user by access whenever not successful;
audit alter user by access whenever successful;
audit drop user by access whenever not successful;
audit drop user by access whenever successful;
--CREATE/ALTER/DROP ROLE        TODOS LOS USUARIOS->
audit create role by access whenever not successful;
audit create role by access whenever successful;
audit alter any role by access whenever not successful;
audit alter any role by access whenever successful;
audit drop any role by access whenever not successful;
audit drop any role by access whenever successful;
--ALTER/DROP ROLLBACK SEGMENT    USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter rollback segment by system by access whenever not successful;
audit alter rollback segment by system by access whenever successful;
audit drop rollback segment by system by access whenever not successful;
audit drop rollback segment by system by access whenever successful;
--ALTER/DROP SEQUENCE            USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter any sequence by system by access whenever not successful;
audit alter any sequence by system by access whenever successful;
audit drop any sequence by system by access whenever not successful;
audit drop any sequence by system by access whenever successful;
--ALTER/CREATE SESSION         TODOS LOS USUARIOS    (inc intentos fallidos) ->
audit create session whenever not successful;
audit create session whenever successful;
audit alter session whenever not successful;
audit alter session whenever successful;
--DROP SYNONYM                USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit drop any synonym by system by access whenever not successful;
audit drop any synonym by system by access whenever successful;
--ALTER/INSERT/UPDATE/DELETE TABLE    USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter any table by system by access whenever not successful;
audit alter any table by system by access whenever successful;
audit insert any table by system by access whenever not successful;
audit insert any table by system by access whenever successful;
audit update any table by system by access whenever not successful;
audit update any table by system by access whenever successful;
audit delete any table by system by access whenever not successful;
audit delete any table by system by access whenever successful;
--ALTER/DROP TABLESPACE        USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter tablespace by system by access whenever not successful;
audit alter tablespace by system by access whenever successful;
audit drop tablespace by system by access whenever not successful;
audit drop tablespace by system by access whenever successful;
--ALTER/DROP TRIGGER            USUARIOS CON PRIVILEGIOS ESPECIALES ->
audit alter any trigger by system by access whenever not successful;
audit alter any trigger by system by access whenever successful;
audit drop any trigger by system by access whenever not successful;
audit drop any trigger by system by access whenever successful;
--ALTER/DROP/INSERT/DELETE VIEW    USUARIOS CON PRIVILEGIOS ESPECIALES -> !! Alter INsert y Delete no aplica a vistas!!
audit drop any view by system by access whenever not successful;
audit drop any view by system by access whenever successful;
audit create any view by system by access whenever not successful;
audit create any view by system by access whenever successful;

"Utilizar el parámetro de configuración de auditoría “BY ACCESS” cuando sea posible  debido a que el mismo genera un amplio registro de auditoría.
En caso de que el servidor no soporte dicho parámetro, reemplazarlo por “BY SESSION”."
WHENEVER SUCCESSFUL / WHENEVER NOT SUCCESSFUL    Se deberán registrar ambas opciones en los eventos a auditar
*/
   DBMS_OUTPUT.put_line
      ('<p>Auditoría de Acciones<br>
Las acciones que deben ser auditadas en la base de datos son las siguientes <br> <br>
<table class="stats" border="1" cellpadding="0" cellspacing="0" width="100%">
        <tbody><tr>
            <th align="center" width="50%">EVENTO</th>
            <th align="center" width="100%">ALCANCE</th>'
      );
   DBMS_OUTPUT.put_line
      ('
<tr><td valign="top">GRANT/REVOKE<td valign="top">TODOS LOS USUARIOS</td> </tr>
<tr><td valign="top">ALTER/DROP CLUSTER<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER DATABASE<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/DROP INDEX<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/DROP PROCEDURE<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">CREATE/ALTER/DROP PROFILE<td valign="top">TODOS LOS USUARIOS</td> </tr>
<tr><td valign="top">CREATE/ALTER/DROP USER<td valign="top">TODOS LOS USUARIOS</td> </tr>
<tr><td valign="top">CREATE/ALTER/DROP ROLE<td valign="top">TODOS LOS USUARIOS</td> </tr>
<tr><td valign="top">ALTER/DROP ROLLBACK SEGMENT<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/DROP SEQUENCE<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/CREATE SESSION<td valign="top">TODOS LOS USUARIOS</td> </tr>
<tr><td valign="top">DROP SYNONYM<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/INSERT/UPDATE/DELETE TABLE<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/DROP TABLESPACE<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/DROP TRIGGER<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
<tr><td valign="top">ALTER/DROP/INSERT/DELETE VIEW<td valign="top">USUARIOS CON PRIVILEGIOS ESPECIALES</td> </tr>
            </tr>
            </tbody></table>
            <br>
Auditorias actuales (privilege)<br>
</p>'
      );
--Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="100%">
        <tbody><tr>
            <th align="center">USERNAME</th>
            <th align="center">PRIVILEGE</th>
            <th align="center">SUCCESS</th>
            <th align="center">FAILURE</th>
            </tr>'
      );

   FOR r IN (SELECT   user_name usuario, PRIVILEGE, success, failure
                 FROM dba_priv_audit_opts
             ORDER BY user_name, PRIVILEGE)
   LOOP
      DBMS_OUTPUT.put_line
                     (   '<tr><td valign="top">'
                      || r.usuario
                      || '</td>
                          <td valign="top">'
                      || r.PRIVILEGE
                      || ' </td>
                       <td valign="top">'
                      || r.success
                      || ' </td>'
                      || ' </td>
                       <td valign="top">'
                      || r.failure
                      || ' </td> </tr>'
                     );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table><br>');
   DBMS_OUTPUT.put_line
      ('<p class="war"><b>VERIFICAR</b> Verificar que se este auditando todo lo requerido</p>'
      );
   DBMS_OUTPUT.put_line
           ('<br><hr width="50%"><h4>Administración de Usuarios y Roles </h4>');
/*2.2
Las cuentas por defecto creadas por Oracle deben tener el siguiente estado:

Usuarios expirado y bloqueado:

ANONYMOUS CTXSYS DBSNMP DIP DMSYS EXFSYS HR MDDATA MDSYS MGMT_VIEW ODM ODM_MTR OE OLAPSYS ORDPLUGINS ORDSYS
OUTLN PM QS QS_ADM QS_CB QS_CBADM QS_CS QS_ES QS_OS QS_WS RMAN SCOTT SH SI_INFORMTN_SCHEMA SYSMAN WK_TEST WKPROXY
WKSYS WMSYS XDB

Adicionalmente, la instalación de Oracle 10 permite asignar a los usuarios SYS, SYSTEM, SYSMAN y DBSNMP la misma contraseña.
Dicha característica no debe ser utilizada
*/
   DBMS_OUTPUT.put_line
      ('<p> Los siguientes usuarios tienen que estar con acceso expirado y bloqueado </p>'
      );
/* TABLA 6 */

   --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">ESTADO</th>
  </tr>'
      );

   FOR r IN (SELECT username, account_status
               FROM dba_users
              WHERE username IN
                       ('ANONYMOUS',
                        'CTXSYS',
                        'DBSNMP',
                        'DIP',
                        'DMSYS',
                        'EXFSYS',
                        'HR',
                        'MDDATA',
                        'MDSYS',
                        'MGMT_VIEW',
                        'ODM',
                        'ODM_MTR',
                        'OE',
                        'OLAPSYS',
                        'ORDPLUGINS',
                        'ORDSYS',
                        'OUTLN',
                        'PM',
                        'QS',
                        'QS_ADM',
                        'QS_CB',
                        'QS_CBADM',
                        'QS_CS',
                        'QS_ES',
                        'QS_OS',
                        'QS_WS',
                        'RMAN',
                        'SCOTT',
                        'SH',
                        'SI_INFORMTN_SCHEMA',
                        'SYSMAN',
                        'WK_TEST',
                        'WKPROXY',
                        'WKSYS',
                        'WMSYS',
                        'XDB'
                       )
                AND (   account_status NOT LIKE 'EXPIRED%'
                     OR account_status NOT LIKE '%LOCKED'
                    ))
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                    (   '<tr><td valign="top">'
                     || r.username
                     || '</td>
                           <td valign="top">'
                     || r.account_status
                     || '</td></tr>'
                    );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 6*/
   IF vaux = 1
   THEN                  --Tengo usuarios que no estan expirados y bloqueados:
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Hay usuarios que necesitan ser bloqueados y/o expirados</p>'
         );
      vaux := 0;
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

   DBMS_OUTPUT.put_line
      ('<p>Adicionalmente, la instalación de Oracle 10 permite asignar a los usuarios SYS, SYSTEM, SYSMAN y DBSNMP la misma contraseña. <br>
Dicha característica no debe ser utilizada.<br>
Los siguientes usuarios tiene la misma password que el usuario SYS: <br></p>'
      );
/* TABLA 7 */

   --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
  </tr>'
      );

   FOR r IN (SELECT username usuario, PASSWORD
               FROM dba_users
              WHERE PASSWORD IN (SELECT PASSWORD
                                   FROM dba_users
                                  WHERE username IN ('SYS'))
                AND username <> 'SYS')
   LOOP
      DBMS_OUTPUT.put_line ('<tr><td valign="top">' || r.usuario
                            || '</td></tr>'
                           );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 7*/
   IF vaux = 1
   THEN                                 -- Usuarios con misma contrase que SYS
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Hay usuarios que tienen la misma password que SYS</p>'
         );
      vaux := 0;
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

/* Cuentas de Usuario
Las cuentas de usuarios deben tener las siguientes características:
USER - Si es externo OPS$nombre_de_usuario
IDENTIFIED - BY password. En caso de ser externo: By Externaly
DEFAULT TABLESPACE - Tbs segun corresponda, nunca debe ser SYSTEM
TEMPORARY TABLESPACE - Temp
QUOTA - Tamaño expresado en Kb o Mb segun corresponda
PROFILE - Nombre del perfil según corresponda.
*/
   DBMS_OUTPUT.put_line
      ('<p>Cuentas de Usuario<br>
DEFAULT TABLESPACE - Tablespace segun corresponda, nunca debe ser SYSTEM<br>Usuarios con default tablespace SYSTEM</p>'
      );
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
  </tr>'
      );

   FOR r IN (SELECT username
               FROM dba_users
              WHERE default_tablespace = 'SYSTEM'
                AND username NOT IN ('SYS', 'SYSTEM', 'OUTLN', 'MGMT_VIEW'))
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line (   '<tr><td valign="top">'
                            || r.username
                            || '</td></tr>'
                           );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 8*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Uno o mas usuarios tienen default tablespace SYSTEM</p>'
         );
      vaux := 0;
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

/*2.3
No se debe generar roles con clave
*/
   DBMS_OUTPUT.put_line
      ('<p>No se debe generar roles con clave<br>
Los siguientes roles contienen clave: <br></p>'
      );
/* TABLA 8 */

   --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">ROL</th>
  </tr>'
      );

   FOR r IN (SELECT ROLE
               FROM dba_roles
              WHERE password_required = 'YES')
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line ('<tr><td valign="top">' || r.ROLE || '</td></tr>');
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 8*/
   IF vaux = 1
   THEN                                 -- Usuarios con misma contrase que SYS
      DBMS_OUTPUT.put_line
          ('<p class="war"><b>VERIFICAR</b> Uno o mas roles tienen clave</p>');
      vaux := 0;
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

/*2.1


2.3.b
CREATE ROLE SECUR_ADMIN not identified;

GRANT CREATE SESSION TO SECUR_ADMIN;
GRANT  ALTER SESSION TO SECUR_ADMIN;
GRANT  CREATE PROFILE TO SECUR_ADMIN;
GRANT ALTER PROFILE TO SECUR_ADMIN;
GRANT  DROP PROFILE TO SECUR_ADMIN;
GRANT CREATE ROLE TO SECUR_ADMIN;
GRANT ALTER ANY ROLE TO SECUR_ADMIN;
GRANT GRANT ANY ROLE TO SECUR_ADMIN;
GRANT DROP ANY ROLE TO SECUR_ADMIN;
GRANT CREATE USER TO SECUR_ADMIN;
GRANT  ALTER USER TO SECUR_ADMIN;
GRANT DROP USER TO SECUR_ADMIN;
*/
--(12 grants)
   DBMS_OUTPUT.put_line
      ('<p> Administrador de Seguridad: <br>
Se deberá crear el rol SECUR_ADMIN con los siguientes privilegios: <br>
CREATE SESSION <br>
ALTER SESSION <br>
CREATE PROFILE <br>
ALTER PROFILE <br>
DROP PROFILE <br>
CREATE ROLE <br>
ALTER ANY ROLE <br>
GRANT ANY ROLE <br>
DROP ANY ROLE <br>
CREATE USER <br>
ALTER USER <br>
DROP USER <br>
A fin de cumplir las tareas antes descriptas, no se deberá otorgar el rol DBA predeterminado en la base de datos, como tampoco otorgar privilegios tales como SYSDBA o SYSOPER. </p><br>'
      );

   FOR r IN (SELECT ROLE
               FROM dba_roles
              WHERE ROLE = 'SECUR_ADMIN')
   LOOP
      vaux := 1;

      FOR r IN
         (SELECT COUNT (*) secur_admin
            FROM dba_sys_privs
           WHERE grantee = 'SECUR_ADMIN'
             AND PRIVILEGE IN                        --Aca solo entraria 1 vez
                    ('CREATE SESSION',
                     'ALTER SESSION',
                     'CREATE PROFILE',
                     'ALTER PROFILE',
                     'DROP PROFILE',
                     'CREATE ROLE',
                     'ALTER ANY ROLE',
                     'GRANT ANY ROLE',
                     'DROP ANY ROLE',
                     'CREATE USER',
                     'ALTER USER',
                     'DROP USER'
                    ))
      LOOP
         IF r.secur_admin <> 12
         THEN                                       --Cantidad de privilegios
            DBMS_OUTPUT.put_line
               ('<p>El grupo SECUR_ADMIN esta creado pero no tiene todos los privilegios necesarios.</p><br> 
                                Privilegios actuales: <br>'
               );
            /* TABLA 9 */
                --Tabla + Titulo Columnas
            DBMS_OUTPUT.put_line
               ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
        <tbody><tr>
            <th align="center" width="20%">PRIVILEGE</th>
            </tr>'
               );

            FOR r IN (SELECT PRIVILEGE
                        FROM dba_sys_privs
                       WHERE grantee = 'SECUR_ADMIN'
                         AND PRIVILEGE IN
                                ('CREATE SESSION',
                                 'ALTER SESSION',
                                 'CREATE PROFILE',
                                 'ALTER PROFILE',
                                 'DROP PROFILE',
                                 'CREATE ROLE',
                                 'ALTER ANY ROLE',
                                 'GRANT ANY ROLE',
                                 'DROP ANY ROLE',
                                 'CREATE USER',
                                 'ALTER USER',
                                 'DROP USER'
                                ))
            LOOP
               DBMS_OUTPUT.put_line (   '<tr><td valign="top">'
                                     || r.PRIVILEGE
                                     || '</td></tr>'
                                    );
            END LOOP;

            --Cierro tabla
            DBMS_OUTPUT.put_line ('</tbody></table>');
         /* FIN TABLA 9*/
         ELSE                      --Esta creado y tiene todos los privilegios
            DBMS_OUTPUT.put_line
               ('<p class="okk">Esta creado y tiene todos los privilegios necesarios.</p>'
               );
         END IF;
      END LOOP;
   END LOOP;

   IF vaux <> 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> El rol SECUR_ADMIN no esta creado</p>'
         );
   END IF;

   vaux := 0;
/* c) Crear cuenta local! */

   /*

   Deberán quitarse todos los roles por defecto otorgados al momento de la creación del usuario. Los roles por defecto son:
   • CONNECT
   • RESOURCE
   • DBA
   • EXP_FULL_DATABASE
   • IMP_FULL_DATABASE
   */
   DBMS_OUTPUT.put_line
      ('<p>Deberán quitarse todos los roles por defecto otorgados al momento de la creación del usuario. <br>
Los roles por defecto son:<br>
CONNECT<br>
RESOURCE<br>
DBA<br>
EXP_FULL_DATABASE<br>
IMP_FULL_DATABASE<br><br>
Los usuarios que tienen alguno de estos roles son:<br><br></p>'
      );
/* TABLA 10 */
        --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
        <tbody><tr>
            <th align="center" width="20%">USUARIO</th>
            <th align="center" width="20%">ROL</th>
            </tr>'
      );

   FOR r IN
      (SELECT   grantee, granted_role
           FROM dba_role_privs
          WHERE granted_role IN
                   ('CONNECT',
                    'RESOURCE',
                    'DBA',
                    'EXP_FULL_DATABASE',
                    'IMP_FULL_DATABASE'
                   )
            AND grantee IN (
                   SELECT username
                     FROM dba_users
                    WHERE username NOT IN
                             ('SYS',
                              'SYSTEM',
                              'CTXSYS',
                              'EXFSYS',
                              'MDDATA',
                              'MDSYS',
                              'OLAPSYS',
                              'OUTLN',
                              'SCOTT',
                              'SYSMAN',
                              'TSMSYS',
                              'WMSYS',
                              'XDB'
                             ))                            --que sean usuarios
       ORDER BY 1, 2)
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                    (   '<tr><td valign="top">'
                     || r.grantee
                     || '</td>
                           <td valign="top">'
                     || r.granted_role
                     || '</td></tr>'
                    );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

   /* FIN TABLA 10*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Algunos usuarios contienen roles por defecto</p>'
         );
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

   vaux := 0;
/* 2.4

Acceso al Diccionario de Datos    Dentro del archivo INIT<SID>.ora colocar:
    • O7_DICTIONARY_ACCESSIBILITY = FALSE
*/
   DBMS_OUTPUT.put_line
      ('<p>Dentro del archivo INIT<SID>.ora colocar: <br>
O7_DICTIONARY_ACCESSIBILITY = FALSE
</p>'
      );

   FOR r IN (SELECT display_value
               FROM v$parameter
              WHERE UPPER (NAME) = 'O7_DICTIONARY_ACCESSIBILITY')
   LOOP
      IF r.display_value = 'TRUE'
      THEN
         DBMS_OUTPUT.put_line
                          (   '<p class="war"><b>VERIFICAR</b> Valor actual '
                           || r.display_value
                           || '</p>'
                          );
      ELSE
         DBMS_OUTPUT.put_line
                           ('<p class="okk" > Configurado correctamente </p>');
      END IF;
   END LOOP;

/*2.5
Creación de Roles con opción WHIT ADMIN OPTION
Esta opción NO deberá configurarse para ningún usuario no administrador,
a fin de evitar que se altere el normal esquema de privilegios otorgados sobre los objetos de la base de datos.
*/

   /*Nueva TABLA*/
   DBMS_OUTPUT.put_line
      ('<p>Creación de Roles con opción WHIT ADMIN OPTION<br>
Esta opción NO deberá configurarse para ningún usuario no administrador, <br>
a fin de evitar que se altere el normal esquema de privilegios otorgados sobre los objetos de la base de datos.</p>'
      );
--Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
        <tbody><tr>
            <th align="center" width="20%">USUARIO</th>
            </tr>'
      );

   FOR r IN (SELECT DISTINCT grantee
                        FROM dba_role_privs
                       WHERE admin_option = 'YES'
                         AND grantee IN (
                                SELECT username
                                  FROM dba_users
                                 WHERE username NOT IN
                                          ('SYS',
                                           'SYSTEM',
                                           'CTXSYS',
                                           'EXFSYS',
                                           'MDDATA',
                                           'MDSYS',
                                           'OLAPSYS',
                                           'OUTLN',
                                           'SYSMAN',
                                           'TSMSYS',
                                           'WMSYS',
                                           'XDB'
                                          )))
   LOOP
      vaux := vaux + 1;
      DBMS_OUTPUT.put_line ('<tr><td valign="top">' || r.grantee
                            || '</td></tr>'
                           );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

   /* FIN TABLA 10*/
   IF vaux > 3
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Hay mas de 3 usuarios que contienen roles con opción WITH ADMIN OPTION</p>'
         );
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

   vaux := 0;
   DBMS_OUTPUT.put_line ('<br><hr width="50%"><h4>Valores Generales</h4>');
/*1.1.1
'SESSIONS_PER_USER: limita al usuario a un número determinado de sesiones concurrentes.
El valor de este parámetro debe ser 1 (uno) para usuarios finales, para usuarios administradores debe ser UNLIMTED
y para usuarios de las aplicaciones será de "xxx_definir"
*/
   DBMS_OUTPUT.put_line
      ('<p><i>Para el Kernel</i><br>
SESSIONS_PER_USER: limita al usuario a un número determinado de sesiones concurrentes. 
El valor de este parámetro debe ser 1 (uno) para usuarios finales, para usuarios administradores debe ser UNLIMTED 
y para usuarios de las aplicaciones será de "xxx_definir" </p>'
      );
/* TABLA 1*/

   --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">SESSIONS_PER_USER</th>
  </tr>'
      );

   FOR r IN (SELECT   a.username usuario, b.LIMIT SESSIONS_PER_USER
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_type = 'KERNEL'
                    AND resource_name = 'SESSIONS_PER_USER'
                    AND a.username NOT IN
                           ('SYS',
                            'SYSTEM',
                            'CTXSYS',
                            'EXFSYS',
                            'MDDATA',
                            'MDSYS',
                            'OLAPSYS',
                            'OUTLN',
                            'SYSMAN',
                            'TSMSYS',
                            'WMSYS',
                            'XDB'
                           )
             ORDER BY 1)
   LOOP
      IF r.SESSIONS_PER_USER = 'UNLIMITED'
      THEN
         vaux := vaux + 1;
      END IF;

      DBMS_OUTPUT.put_line
                     (   '<tr><td valign="top">'
                      || r.usuario
                      || '</td>
                           <td valign="top">'
                      || r.SESSIONS_PER_USER
                      || ' </td></tr>'
                     );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 1*/
   IF vaux > 10
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Hay mas de 10 usuarios con perfil con sessions_per_user UNLIMITED </p>'
         );
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk">Configurado correctamente </p>');
   END IF;

   vaux := 0;
/*1.1.1
'IDLE_TIME: El valor de este parámetro puede variar según el tipo de usuario,
se recomienda que para usuarios finales y usuarios con permisos especiales (rol DBA)
su valor sea 15 minutos.
*/
   DBMS_OUTPUT.put_line
      ('<p><i>Para el Kernel</i><br>
IDLE_TIME: El valor de este parámetro puede variar según el tipo de usuario, 
se recomienda que para usuarios finales y usuarios con permisos especiales (rol DBA) 
su valor sea 15 minutos.</p>'
      );
/* TABLA 2*/

   --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">IDLE_TIME</th>
  </tr>'
      );

   FOR r IN (SELECT   a.username usuario, b.LIMIT IDLE_TIME
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name = 'IDLE_TIME'
                    AND b.LIMIT <> '15'
                    AND a.username NOT IN
                           ('SYS',
                            'SYSTEM',
                            'CTXSYS',
                            'EXFSYS',
                            'MDDATA',
                            'MDSYS',
                            'OLAPSYS',
                            'OUTLN',
                            'SYSMAN',
                            'TSMSYS',
                            'WMSYS',
                            'XDB',
                            'ANONYMOUS',
                            'DBSNMP',
                            'DIP',
                            'DMSYS',
                            'MGMT_VIEW',
                            'ORACLE_OCM',
                            'ORDPLUGINS',
                            'ORDSYS',
                            'SCOTT',
                            'SI_INFORMTN_SCHEMA'
                           )
             ORDER BY 1)
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                    (   '<tr><td valign="top">'
                     || r.usuario
                     || '</td>
                           <td valign="top">'
                     || r.IDLE_TIME
                     || ' </td></tr>'
                    );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 2*/
   IF vaux = 1
   THEN                                            --Lo pongo como VERIFICAR .
      DBMS_OUTPUT.put_line
         ('<p class="war" ><b>VERIFICAR</b> Hay uno o mas usuarios con perfil con valor de IDLE_TIME distinto a 15</p>'
         );
      vaux := 0;
   ELSE                                                     --Lo pongo como OK
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente</p>');
   END IF;

/*
""• FAILED_LOGIN_ATTEMPTS:  3 para usuarios de la base / UNLIMITED para usuarios de servicio/interface
"
"• PASSWORD_LIFE_TIME:  30 para usuarios de la base / UNLIMITED para usuarios de servicio/interface
"
• PASSWORD_REUSE_TIME:  Mismo valor que PASSWORD_LIFE_TIME
• PASSWORD_REUSE_MAX: 10
• PASSWORD_LOCK_TIME : UNLIMITED
• PASSWORD_GRACE_TIME: 1
• PASSWORD_VERIFY_FUNCTION: VERIFY_FUNCTION

"
*/
   DBMS_OUTPUT.put_line
      ('<p><i>Para el Password</i><br>
FAILED_LOGIN_ATTEMPTS:  3 para usuarios de la base / UNLIMITED para usuarios de servicio/interface<br>
PASSWORD_LIFE_TIME:  30 para usuarios de la base / UNLIMITED para usuarios de servicio/interface<br>
PASSWORD_REUSE_TIME:  Mismo valor que PASSWORD_LIFE_TIME<br>
PASSWORD_REUSE_MAX: 10<br>
PASSWORD_LOCK_TIME : UNLIMITED<br>
PASSWORD_GRACE_TIME: 1<br>
PASSWORD_VERIFY_FUNCTION: VERIFY_FUNCTION
</p>'
      );

   FOR r IN (SELECT   COUNT (a.username) cantidad
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name IN ('FAILED_LOGIN_ATTEMPTS')
                    AND b.LIMIT = 'UNLIMITED'
             ORDER BY 1)
   LOOP
      IF r.cantidad >= 3
      THEN  --Lo pongo como VERIFICAR . Tendrian que haber pocos en UNLIMITED
         DBMS_OUTPUT.put_line
            (   '<p class="war" ><b>VERIFICAR</b> FAILED_LOGIN_ATTEMPTS : Hay '
             || r.cantidad
             || ' usuarios con el valor en UNLIMITED</p>'
            );
      ELSE                                                  --Lo pongo como OK
         DBMS_OUTPUT.put_line
                          (   '<p class="okk" > FAILED_LOGIN_ATTEMPTS : Hay '
                           || r.cantidad
                           || ' usuarios con el valor en UNLIMITED</p>'
                          );
      END IF;
   END LOOP;

   DBMS_OUTPUT.put_line
      ('<p>PASSWORD_LIFE_TIME: 30 para usuarios de la base / UNLIMITED para usuarios de servicio/interface</p>'
      );

   FOR r IN (SELECT   COUNT (a.username) cantidad
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name IN ('PASSWORD_LIFE_TIME')
                    AND b.LIMIT = 'UNLIMITED'
                    AND username NOT IN
                           ('SYS',
                            'SYSTEM',
                            'CTXSYS',
                            'EXFSYS',
                            'MDDATA',
                            'MDSYS',
                            'OLAPSYS',
                            'OUTLN',
                            'SYSMAN',
                            'TSMSYS',
                            'WMSYS',
                            'XDB',
                            'ANONYMOUS',
                            'DBSNMP',
                            'DIP',
                            'DMSYS',
                            'MGMT_VIEW',
                            'ORACLE_OCM',
                            'ORDPLUGINS',
                            'ORDSYS',
                            'SCOTT',
                            'SI_INFORMTN_SCHEMA'
                           )
             ORDER BY 1)
   LOOP
      IF r.cantidad >= 3
      THEN  --Lo pongo como VERIFICAR . Tendrian que haber pocos en UNLIMITED
         DBMS_OUTPUT.put_line
             (   '<p class="war" ><b>VERIFICAR</b> PASSWORD_LIFE_TIME : Hay '
              || r.cantidad
              || ' usuarios con el valor en UNLIMITED</p>'
             );
      ELSE                                                  --Lo pongo como OK
         DBMS_OUTPUT.put_line
                           (   '<p class="okk" > PASSWORD_LIFE_TIME : Hay '
                            || r.cantidad
                            || ' usuarios finales con el valor en UNLIMITED</p>'
                           );
      END IF;
   END LOOP;

--PASSWORD_REUSE_TIME
   DBMS_OUTPUT.put_line
      ('<p>PASSWORD_REUSE_TIME: Usuarios con perfil con valor de PASSWORD_REUSE_TIME diferente al valor de PASSWORD_LIFE_TIME</p>'
      );
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">LIMIT</th>
  </tr>'
      );

   FOR r IN (SELECT   a.username usuario, b.LIMIT
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name IN ('PASSWORD_REUSE_TIME')
                    AND b.LIMIT <>
                           (SELECT LIMIT
                              FROM dba_profiles
                             WHERE resource_name = 'PASSWORD_LIFE_TIME'
                               AND PROFILE = a.PROFILE)
             ORDER BY 1)
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                      (   '<tr><td valign="top">'
                       || r.usuario
                       || ' </td>
                        <td valign="top">'
                       || r.LIMIT
                       || ' </td></tr>'
                      );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 3*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war" ><b>VERIFICAR</b>Hay usuarios con perfil con valor de PASSWORD_REUSE_TIME diferente al valor de PASSWORD_LIFE_TIME</p>'
         );
      vaux := 0;
   ELSE                                                     --Lo pongo como OK
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente</p>');
   END IF;

--PASSWORD_REUSE_MAX: 10
   DBMS_OUTPUT.put_line ('<p>PASSWORD_REUSE_MAX: 10</p>');
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">LIMIT</th>
  </tr>'
      );

   FOR r IN (SELECT   a.username usuario, b.LIMIT
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name IN ('PASSWORD_REUSE_MAX')
                    AND LIMIT <> '10'
                    AND username NOT IN
                           ('SYS',
                            'SYSTEM',
                            'CTXSYS',
                            'EXFSYS',
                            'MDDATA',
                            'MDSYS',
                            'OLAPSYS',
                            'OUTLN',
                            'SYSMAN',
                            'TSMSYS',
                            'WMSYS',
                            'XDB',
                            'ANONYMOUS',
                            'DBSNMP',
                            'DIP',
                            'DMSYS',
                            'MGMT_VIEW',
                            'ORACLE_OCM',
                            'ORDPLUGINS',
                            'ORDSYS',
                            'SCOTT',
                            'SI_INFORMTN_SCHEMA'
                           )
             ORDER BY 1)
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                   (   '<tr><td valign="top">'
                    || r.usuario
                    || '</td>
                            <td valign="top">'
                    || r.LIMIT
                    || '</td></tr>'
                   );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war" ><b>VERIFICAR</b> Hay usuarios con perfil con valor de PASSWORD_REUSE_MAX diferente a 10</p>'
         );
      vaux := 0;
   ELSE                                                     --Lo pongo como OK
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente</p>');
   END IF;

--PASSWORD_LOCK_TIME
   DBMS_OUTPUT.put_line ('<p>PASSWORD_LOCK_TIME: UNLIMITED</p>');
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">LIMIT</th>
  </tr>'
      );

   FOR r IN (SELECT   a.username usuario, b.LIMIT
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name IN ('PASSWORD_LOCK_TIME')
                    AND LIMIT <> 'UNLIMITED'
                    AND username NOT IN
                           ('SYS',
                            'SYSTEM',
                            'CTXSYS',
                            'EXFSYS',
                            'MDDATA',
                            'MDSYS',
                            'OLAPSYS',
                            'OUTLN',
                            'SYSMAN',
                            'TSMSYS',
                            'WMSYS',
                            'XDB',
                            'ANONYMOUS',
                            'DBSNMP',
                            'DIP',
                            'DMSYS',
                            'MGMT_VIEW',
                            'ORACLE_OCM',
                            'ORDPLUGINS',
                            'ORDSYS',
                            'SCOTT',
                            'SI_INFORMTN_SCHEMA'
                           )
             ORDER BY 1)
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                       (   '<tr><td valign="top">'
                        || r.usuario
                        || '</td>
                        <td valign="top">'
                        || r.LIMIT
                        || '</td></tr>'
                       );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war" ><b>VERIFICAR</b> Hay usuarios con PASSWORD_LOCK_TIME diferente a UNLIMITED</p>'
         );
      vaux := 0;
   ELSE                                                     --Lo pongo como OK
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente</p>');
   END IF;

--PASSWORD_GRACE_TIME: 1
   DBMS_OUTPUT.put_line ('<p>PASSWORD_GRACE_TIME: 1</p>');
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">LIMIT</th>
  </tr>'
      );

   FOR r IN (SELECT   a.username usuario, b.LIMIT
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name IN ('PASSWORD_GRACE_TIME')
                    AND LIMIT <> '1'
                    AND username NOT IN
                           ('SYS',
                            'SYSTEM',
                            'CTXSYS',
                            'EXFSYS',
                            'MDDATA',
                            'MDSYS',
                            'OLAPSYS',
                            'OUTLN',
                            'SYSMAN',
                            'TSMSYS',
                            'WMSYS',
                            'XDB',
                            'ANONYMOUS',
                            'DBSNMP',
                            'DIP',
                            'DMSYS',
                            'MGMT_VIEW',
                            'ORACLE_OCM',
                            'ORDPLUGINS',
                            'ORDSYS',
                            'SCOTT',
                            'SI_INFORMTN_SCHEMA'
                           )
             ORDER BY 1)
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line (   '<tr><td valign="top">'
                            || r.usuario
                            || '</td>
<td valign="top">'
                            || r.LIMIT
                            || '</td></tr>'
                           );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war" ><b>VERIFICAR</b> Hay usuarios con PASSWORD_GRACE_TIME diferente a 1</p>'
         );
      vaux := 0;
   ELSE                                                     --Lo pongo como OK
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente</p>');
   END IF;

--PASSWORD_VERIFY_FUNCTION: VERIFY_FUNCTION
   DBMS_OUTPUT.put_line
      ('<p>PASSWORD_VERIFY_FUNCTION: VERIFY_FUNCTION<br>
NOTA: Caracterís</p>'
      );
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">LIMIT</th>
  </tr>'
      );

   FOR r IN (SELECT   a.username usuario, b.LIMIT
                 FROM dba_users a JOIN dba_profiles b
                      ON a.PROFILE = b.PROFILE
                    AND resource_name IN ('PASSWORD_VERIFY_FUNCTION')
                    AND LIMIT <> 'VERIFY_FUNCTION'
                    AND username NOT IN
                           ('SYS',
                            'SYSTEM',
                            'CTXSYS',
                            'EXFSYS',
                            'MDDATA',
                            'MDSYS',
                            'OLAPSYS',
                            'OUTLN',
                            'SYSMAN',
                            'TSMSYS',
                            'WMSYS',
                            'XDB',
                            'ANONYMOUS',
                            'DBSNMP',
                            'DIP',
                            'DMSYS',
                            'MGMT_VIEW',
                            'ORACLE_OCM',
                            'ORDPLUGINS',
                            'ORDSYS',
                            'SCOTT',
                            'SI_INFORMTN_SCHEMA'
                           )
             ORDER BY 1)
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                   (   '<tr><td valign="top">'
                    || r.usuario
                    || '</td>
                            <td valign="top">'
                    || r.LIMIT
                    || '</td></tr>'
                   );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war" ><b>VERIFICAR</b> Hay usuarios con PASSWORD_VERIFY_FUNCTION diferente a VERIFY_FUNCTION</p>'
         );
      vaux := 0;
   ELSE                                                     --Lo pongo como OK
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente</p>');
   END IF;

/* TABLA 3 */

   --Tabla + Titulo Columnas
/*
dbms_output.put_line ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">RESOURCE_NAME</th>
    <th align="center" width="20%">LIMIT</th>
  </tr>');


FOR r IN (select a.username usuario,b.resource_name, b.limit limit
from dba_users a join dba_profiles  b
on a.profile = b.profile
and resource_name in ('FAILED_LOGIN_ATTEMPTS',
'PASSWORD_LIFE_TIME',
'PASSWORD_REUSE_TIME',
'PASSWORD_REUSE_MAX',
'PASSWORD_LOCK_TIME',
'PASSWORD_GRACE_TIME',
'PASSWORD_VERIFY_FUNCTION')
order by 1)
loop
dbms_output.put_line ('<tr><td valign="top">'||r.usuario||'</td>
                     <td valign="top">'||r.resource_name||'</td>
                     <td valign="top">'||r.limit||'</td></tr>');
end loop;


--Cierro tabla
dbms_output.put_line ('</tbody></table>');

/* FIN TABLA 3*/

   /*
   Dentro del archivo INIT<SID>.ora colocar:
   • RESOURCE_LIMIT = TRUE
   */
   DBMS_OUTPUT.put_line
      ('<p>Dentro del archivo INIT<SID>.ora colocar:<br>
RESOURCE_LIMIT = TRUE 
</p>'
      );

   FOR r IN (SELECT display_value
               FROM v$parameter
              WHERE UPPER (NAME) = 'RESOURCE_LIMIT')
   LOOP
      IF r.display_value = 'FALSE'
      THEN
         DBMS_OUTPUT.put_line
                         (   '<p class="war" ><b>VERIFICAR</b> Valor actual '
                          || r.display_value
                          || '</p>'
                         );
      ELSE
         DBMS_OUTPUT.put_line
                            ('<p class="okk" >Configurado correctamente </p>');
      END IF;
   END LOOP;

/*
Dentro del archivo INIT<SID>.ora colocar:
• REMOTE_OS_AUTHENT = FALSE
*/
   DBMS_OUTPUT.put_line
      ('<p>Dentro del archivo INIT<SID>.ora colocar: <br>
REMOTE_OS_AUTHENT = FALSE
</p>'
      );

   FOR r IN (SELECT display_value
               FROM v$parameter
              WHERE UPPER (NAME) = 'REMOTE_OS_AUTHENT')
   LOOP
      IF r.display_value = 'TRUE'
      THEN
         DBMS_OUTPUT.put_line (   '<p class="war" ><b>VERIFICAR</b>'
                               || r.display_value
                               || ' Verificar!</p>'
                              );
      ELSE
         DBMS_OUTPUT.put_line
                            ('<p  class="okk">Configurado correctamente </p>');
      END IF;
   END LOOP;

/* 1.7
Los paquetes que deben ser desasignados al rol Public son los siguientes
• DBMS_RANDOM
• UTL_SMTP
• UTL_TCP
• UTL_HTTP
•  UTL_FILE
•  DBMS_JOB
• DBMS_LOB
•  DBMS_SQL
• DBMS_BACKUP_RESTORE
• DBMS_OBFUSCATION_TOOLKIT

Para eliminar la autorización ejecutar la siguiente sentencia:
•  revoke execute on <paquete> from PUBLIC
*/
   DBMS_OUTPUT.put_line
      ('<p>Los paquetes que deben ser desasignados al rol Public son los siguientes<br>
DBMS_RANDOM<br>
UTL_SMTP<br>
UTL_TCP<br>
UTL_HTTP<br>
UTL_FILE<br>
DBMS_JOB<br>
DBMS_LOB<br>
DBMS_SQL<br>
DBMS_BACKUP_RESTORE<br>
DBMS_OBFUSCATION_TOOLKIT<br>
<br>
Paquetes asignados a PUBLIC <br></p>'
      );
/* TABLA 4 */

   --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">OWNER</th>
    <th align="center" width="20%">PAQUETE</th>
  </tr>'
      );

   FOR r IN (SELECT owner, table_name paquete
               FROM dba_tab_privs
              WHERE grantee = 'PUBLIC'
                AND table_name IN
                       ('DBMS_RANDOM',
                        'UTL_SMTP',
                        'UTL_TCP',
                        'UTL_HTTP',
                        'UTL_FILE',
                        'DBMS_JOB',
                        'DBMS_LOB',
                        'DBMS_SQL',
                        'DBMS_BACKUP_RESTORE',
                        'DBMS_OBFUSCATION_TOOLKIT'
                       ))
   LOOP
      vaux := 1;
      DBMS_OUTPUT.put_line
                        (   '<tr><td valign="top">'
                         || r.owner
                         || '</td>
                       <td valign="top">'
                         || r.paquete
                         || '</td> </tr>'
                        );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 4*/
   IF vaux = 1
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Hay paquetes asignados a Public</p>'
         );
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

   vaux := 0;
/*
1.8
Eliminar la autorización ejecutando la siguiente sentencia para aquellos casos que no requieran este privilegio:
• revoke CREATE DATABASE LINK from <username | role_name>
*/
   DBMS_OUTPUT.put_line
      ('<p>Eliminar la autorización "CREATE DATABASE LINK" de aquellos usuarios que no los necesiten</p>'
      );
/* TABLA 5 */

   --Tabla + Titulo Columnas
   DBMS_OUTPUT.put_line
      ('<table class="stats" border="1" cellpadding="0" cellspacing="0" width="25%">
  <tbody><tr>
    <th align="center" width="20%">USUARIO</th>
    <th align="center" width="20%">ADMIN_OPTION</th>
  </tr>'
      );

   FOR r IN (SELECT grantee usuario, privilege, admin_option
               FROM dba_sys_privs
              WHERE PRIVILEGE in ('CREATE DATABASE LINK','INSERT ANY TABLE','UPDATE ANY TABLE','DELETE ANY TABLE')
                AND grantee IN (SELECT username
                                  FROM dba_users
                                 WHERE username NOT IN ('SYS')))
   LOOP
      vaux := vaux + 1;
      DBMS_OUTPUT.put_line
                    (   '<tr><td valign="top">'
                     || r.usuario
                     || '</td>
                           <td valign="top">'
                     || r.admin_option
                     || '</td> </tr>'
                    );
   END LOOP;

--Cierro tabla
   DBMS_OUTPUT.put_line ('</tbody></table>');

/* FIN TABLA 5*/
   IF vaux > 3
   THEN
      DBMS_OUTPUT.put_line
         ('<p class="war"><b>VERIFICAR</b> Hay mas de 3 usuarios y/o roles con el privilegio asignado</p>'
         );
   ELSE
      DBMS_OUTPUT.put_line ('<p class="okk" > Configurado correctamente </p>');
   END IF;

   vaux := 0;
   DBMS_OUTPUT.put_line ('<br><hr width="50%"><h4>Backup</h4>');
/*
5.1    Modo Archivelog    La base de datos deberá trabajar siempre en modo archivelog,
a fin de poder recuperar el listado de operaciones realizadas sobre la misma.
*/
   DBMS_OUTPUT.put_line
         ('<p>La base de datos deberá trabajar siempre en modo archivelog</p>');

   FOR r IN (SELECT log_mode
               FROM v$database)
   LOOP
      IF r.log_mode = 'NOARCHIVELOG'
      THEN
         DBMS_OUTPUT.put_line
            ('<p class="war"><b>VERIFICAR</b> La base debe estar modo ARCHIVELOG</p>'
            );
      ELSE
         DBMS_OUTPUT.put_line
                           ('<p class="okk" > Configurado correctamente </p>');
      END IF;
   END LOOP;

/*
•  LOG_ARCHIVE_FORMAT: Deberá seguirse el siguiente formato a fin de identificar unívocamente las copias de los redo log files almacenadas:
"ORACLE_SIDredo_log_%%%s_%%%t.bck", donde:
%s identifica el número de secuencia de la copia del redo log file.
%t identifica el thread que generó el archivo redo log.
ORACLE_SID: identifica la instancia a la que pertenece la copia del redo log file.
*/

   --ORACLE_SIDredo_log_%s_%t.bck

   --select name,display_value from v$parameter where upper(name) like upper('log_archive_format')

   --INDICAR EN DOCUMENTO QUE EL FORMATO SERIA ORACLE_SIDredo_log_%s_%t_%r.bck y no ORACLE_SIDredo_log_%s_%t.bck!!
   DBMS_OUTPUT.put_line
      ('<p>LOG_ARCHIVE_FORMAT: Debera tener el formato ORACLE_SIDredo_log_%s_%t_%r.bck</p>'
      );

   FOR r IN (SELECT NAME, display_value
               FROM v$parameter
              WHERE UPPER (NAME) LIKE UPPER ('log_archive_format'))
   LOOP
      FOR t IN (SELECT display_value
                  FROM v$parameter
                 WHERE UPPER (NAME) = UPPER ('instance_name'))
      LOOP
         IF r.display_value <> t.display_value || 'redo_log_%s_%t_%r.bck'
         THEN
            DBMS_OUTPUT.put_line
               (   '<p class="war"><b>VERIFICAR</b> Verificar formato. Formato actual '
                || r.display_value
                || '. <br>Cambiar a formato '
                || t.display_value
                || 'redo_log_%s_%t_%r.bck </p>'
               );
         ELSE
            DBMS_OUTPUT.put_line
                           ('<p class="okk" > Configurado correctamente </p>');
         END IF;
      END LOOP;
   END LOOP;

   DBMS_OUTPUT.put_line ('</body> </html>');
END;
/



SPOOL off;
--FALTA FORMATO ARCHIVE!
--host c:\prueba.html