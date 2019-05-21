SET serveroutput on
SET feedback off

DECLARE
----------------------- Parametros ------------------------
   p_owner           VARCHAR2 (50)    := 'gem_tv';
   p_sequence_name   VARCHAR2 (50)    := 'acd_codigo';
   p_nro_final       PLS_INTEGER      := 410;
-----------------------------------------------------------
   l_nro_actual      PLS_INTEGER;
   l_sql             VARCHAR2 (32767);
BEGIN
   p_owner := UPPER (p_owner);
   p_sequence_name := UPPER (p_sequence_name);
   l_sql :=
       'select ' || p_owner || '.' || p_sequence_name || '.nextval from dual';

   EXECUTE IMMEDIATE l_sql
                INTO l_nro_actual;

   DBMS_OUTPUT.put_line ('l_nro_actual = ' || l_nro_actual);

   FOR i IN 1 .. (p_nro_final - l_nro_actual)
   LOOP
      EXECUTE IMMEDIATE l_sql
                   INTO l_nro_actual;
   END LOOP;

   l_sql :=
        'select ' || p_owner || '.' || p_sequence_name || '.currval from dual';

   EXECUTE IMMEDIATE l_sql
                INTO l_nro_actual;

   DBMS_OUTPUT.put_line ('l_nro_actual new = ' || l_nro_actual);
END;