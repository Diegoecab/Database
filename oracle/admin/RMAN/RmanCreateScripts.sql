RMAN

Creacion de Script:


create script Back_Full comment "Backup Full" {backup database;}


Reemplazar Script:


replace script Back_Full comment "Backup Full" {backup database;}




Listar Scripts:


list all script names;


Ejecutar scripts:

RUN { EXECUTE SCRIPT
full_backup
; }


Ver script:


Print script "Back_Full";


Eliminar script:

DELETE SCRIPT 'full_backup';


Ejecutar script al momento de ejecutar RMAN


rman TARGET SYS/oracle@trgt CATALOG rman/cat@catdb SCRIPT 'full_backup';