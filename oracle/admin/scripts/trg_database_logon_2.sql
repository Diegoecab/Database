CREATE OR REPLACE TRIGGER trg_database_logon
   AFTER LOGON ON DATABASE
BEGIN
   IF SYS_CONTEXT ('USERENV', 'session_user') = 'ORABPEL'
   THEN
      execute immediate ('ALTER SESSION SET SQL_TRACE=TRUE');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'No tiene permiso para conectarse a la base de datos'
                       );
END trg_database_logon;
/