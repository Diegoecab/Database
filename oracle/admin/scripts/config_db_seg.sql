--AUDITORIA:

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

--Administración de Usuarios y Roles 

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
  SESSIONS_PER_USER UNLIMITED
  CPU_PER_SESSION UNLIMITED
  CPU_PER_CALL UNLIMITED
  CONNECT_TIME UNLIMITED
  IDLE_TIME UNLIMITED
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
  PASSWORD_VERIFY_FUNCTION VERIFY_FUNCTION
 /