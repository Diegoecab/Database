REM	Script para recrear usuario, eliminando todos los objetos
REM ======================================================================
REM user_recrea.sql		Version 1.1	01 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set serveroutput on
set lines 999 pages 999 verify off  feedback off heading off
whenever SQLERROR exit sql.sqlcode;
accept userid  prompt 'Ingrese usuario a recrear:  '
accept direc  prompt 'Ingrese ruta de temporal, ej /home/oracle/user.sql:  '
spool  &direc;
DECLARE
   usuariob   VARCHAR2 (100);
BEGIN
   usuariob := NULL;

   BEGIN
      SELECT 'x'
        INTO usuariob
        FROM dba_users
       WHERE username = UPPER ('&userid');
   EXCEPTION
      WHEN OTHERS
      THEN
         GOTO usernex;
   END;
   DBMS_OUTPUT.put_line ('alter session set nls_date_format=''dd/mm/yyyy hh24:mi:ss'';');
   DBMS_OUTPUT.put_line ('set feedback off heading off');
   DBMS_OUTPUT.put_line ('select sysdate from dual;');
   DBMS_OUTPUT.put_line ('prompt Eliminando usuario &userid ...');
   DBMS_OUTPUT.put_line ('drop user ' || '&userid' || ' cascade;');
   DBMS_OUTPUT.put_line ('select sysdate from dual;');

    DBMS_OUTPUT.put_line ('prompt Creando usuario &userid ...');
   FOR cur1
      IN (SELECT    'create user '
                 || '&userid'
                 || ' identified by values '''
                 || password
                 || '''  default tablespace '
                 || default_tablespace
                 || ' temporary tablespace '
                 || temporary_tablespace
                 || '  ;'
                    AS usuario
            FROM dba_users
           WHERE username = UPPER ('&userid'))
   LOOP
      DBMS_OUTPUT.put_line (cur1.usuario);
   END LOOP;

   DBMS_OUTPUT.put_line ('prompt Cuotas de tablespaces ...');

   FOR cur1
      IN (SELECT 'alter user &userid quota '
                 || DECODE (max_bytes,
                            -1, 'unlimited',
                            CEIL (max_bytes / 1024 / 1024) || 'M')
                 || ' on '
                 || tablespace_name
                 || '  ;' 
                    AS alteruser
            FROM dba_ts_quotas
           WHERE username = UPPER ('&userid'))
   LOOP
      DBMS_OUTPUT.put_line (cur1.alteruser);
   END LOOP;

   DBMS_OUTPUT.put_line ('prompt  grants de roles ...');

   FOR cur1
      IN (SELECT 'GRANT ' || GRANTed_role || ' to &userid'
                 || DECODE (admin_option,
                            'NO', ';',
                            'YES', ' with admin option;')
                    "ROLE"
            FROM dba_role_privs
           WHERE grantee = UPPER ('&userid'))
   LOOP
      DBMS_OUTPUT.put_line (cur1.role);
   END LOOP;

   DBMS_OUTPUT.put_line ('prompt grants de objetos ...');

   FOR cur1
      IN (SELECT 'GRANT ' || privilege || ' to &userid'
                 || DECODE (admin_option,
                            'NO', ';',
                            'YES', ' with admin option;')
                    "PRIV"
            FROM dba_sys_privs
           WHERE grantee = UPPER ('&userid'))
   LOOP
      DBMS_OUTPUT.put_line (cur1.priv);
   END LOOP;

   DBMS_OUTPUT.put_line ('select sysdate from dual;');
   GOTO salir;

  <<usernex>>
   DBMS_OUTPUT.put_line ('prompt El usuario &userid no existe en la base de datos');
  <<salir>>
   NULL;
END;
/
spool off;
--@&direc