ram Ok

swap 8G, deberia ser 9G (0.75 veces la memoria disponible)

tmp Ok


Crear el grupo oper
(/usr/sbin/groupadd oper)


Usuario Oracle tambien pertenezca a oper

/usr/sbin/useradd -g oinstall -G dba[,oper] oracle
/usr/sbin/usermod -g oinstall -G dba[,oper] oracle


Ver las opciones que vamos a utilizar en GARDB como ser FLASHBACK DATABASE


1227MB en 01 min 42 seg prom 23MB /seg

gardbop

Luego de instalar el soft ver los links



/u01/oracle/oraInventory/orainstRoot.sh
/u01/oracle/product/db10gr2/root.sh

Soft Base: ./runInstaller -ignoreSysprereqs -silent -noconfig -responseFile /u01/soft/database/response/enterpriseGarba.rsp
Parche: ./runInstaller -silent -responseFile /u01/soft/parche/Disk1/response/patchsetGarba.rsp
Base Datos: dbca -silent -createDatabase -templateName General_Purpose.dbc -responseFile /u01/soft/database/response/dbcaGarba.rsp
Listener: netca /silent /responsefile /u01/soft/database/response/netcaGarba.rsp


Pasar requerimientos de espacio


"sysoltp307op"