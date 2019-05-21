DECLARE
   inv    NUMBER;
   inv2   NUMBER;
BEGIN
   SELECT cantidad
     INTO inv
     FROM (SELECT COUNT (*) cantidad
             FROM dba_objects
            WHERE status <> 'VALID'
              AND object_name NOT IN
                     ('SNAPSHOT','WB_RTI_WORKFLOW_UTIL','WB_OLAP_LOAD_CUBE','WB_OLAP_LOAD_DIMENSION',
                        'WB_OLAP_LOAD_DIMENSION_GENUK','PKG_CALCULOSPROCESAR','PKG_INTERFACE_PROCESOINICIAL',
                        'F_CALCULA_GAREX_GS', 'F_CALCULA_VENTAS_GS','F_CALCULA_RENTABILIDAD_GS','F_MAIN_GESTION_SUCURSAL')
              AND owner NOT IN ('OWB2_GAR', 'ADMREC')) aux
    WHERE aux.cantidad > 0
      AND EXISTS (
             SELECT 1
               FROM v$instance
              WHERE instance_name IN ('gardb', 'gardw', 'clondb')
                 OR instance_name LIKE '%OP');

   IF inv > 0
   THEN
      FOR cur_rec IN (SELECT   owner, object_type, object_name
                          FROM dba_objects
                         WHERE status <> 'VALID'
                         AND object_name NOT IN
                     ('SNAPSHOT','WB_RTI_WORKFLOW_UTIL','WB_OLAP_LOAD_CUBE','WB_OLAP_LOAD_DIMENSION',
                        'WB_OLAP_LOAD_DIMENSION_GENUK','PKG_CALCULOSPROCESAR','PKG_INTERFACE_PROCESOINICIAL',
                        'F_CALCULA_GAREX_GS', 'F_CALCULA_VENTAS_GS','F_CALCULA_RENTABILIDAD_GS','F_MAIN_GESTION_SUCURSAL')
                      ORDER BY 1, 2, 3)
      LOOP
         BEGIN
            IF cur_rec.object_type = 'PACKAGE BODY'
            THEN
               EXECUTE IMMEDIATE    'ALTER PACKAGE "'
                                 || cur_rec.owner
                                 || '"."'
                                 || cur_rec.object_name
                                 || '" COMPILE BODY';
            ELSE
               EXECUTE IMMEDIATE    'ALTER '
                                 || cur_rec.object_type
                                 || ' "'
                                 || cur_rec.owner
                                 || '"."'
                                 || cur_rec.object_name
                                 || '" COMPILE';
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
         NULL;
         END;
      END LOOP;
   END IF;

BEGIN
   SELECT cantidad
     INTO inv2
     FROM (SELECT COUNT (*) cantidad
             FROM dba_objects
            WHERE status <> 'VALID'
              AND object_name NOT IN
                     ('SNAPSHOT','WB_RTI_WORKFLOW_UTIL','WB_OLAP_LOAD_CUBE','WB_OLAP_LOAD_DIMENSION',
                        'WB_OLAP_LOAD_DIMENSION_GENUK','PKG_CALCULOSPROCESAR','PKG_INTERFACE_PROCESOINICIAL',
                        'F_CALCULA_GAREX_GS', 'F_CALCULA_VENTAS_GS','F_CALCULA_RENTABILIDAD_GS','F_MAIN_GESTION_SUCURSAL' )
              AND owner NOT IN ('OWB2_GAR', 'ADMREC')) aux
    WHERE aux.cantidad > 0
      AND EXISTS (
             SELECT 1
               FROM v$instance
              WHERE instance_name IN ('gardb', 'gardw', 'clondb')
                 OR instance_name LIKE '%OP');
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                 NULL;
                 END;

   IF inv2 > 0
   THEN
      DBMS_OUTPUT.put_line ('CONTROL &1 &2 OBJ WARNING Objetos invalidos : ' || inv2 ||'.  No se pudo recompilar el/los objetos');
   ELSE
      DBMS_OUTPUT.put_line ('CONTROL &1 &2 OBJ NOTIFICATION Objetos invalidos : ' || inv || '.  Objetos compilados correctamente');
   END IF;
   EXCEPTION WHEN NO_DATA_FOUND THEN
   NULL;
END;
/