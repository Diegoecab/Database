# Status, Configuración y Chequeos de Recursos de Cluster
crsctl check crs                             # Status Servicios CRS
crsctl check cluster -n rac2                 # Status Servicios Cluster
crsctl check ctss                            # Status Servicio CTSS
crsctl config crs (requiere root)            # Configuración Autoarranque OHAS
cat /etc/oracle/scls_scr/rac1/root/ohasdstr  # Configuración Autoarranque OHAS
crsctl stat res -t                           # Status Todos Recursos Cluster
crsctl stat res ora.rac.db -p                # Configuración de un Recurso
crsctl stat res ora.rac.db -f                # Configuracion Completa
crsctl query css votedisk                    # Status Voting Disks
olsnodes -n -i -s -t                         # Listar Nodos Cluster
oifcfg getif                                 # Información Interfaces de Red
ocrcheck                                     # Status OCR (ejecutar como root para chequear corrupción lógica)
ocrcheck -local (requiere root)              # Status OCR con CRS/OHAS OFFLINE
ocrconfig -showbackup                        # Información Backups OCR
ocrconfig -add +TEST                          # Crear una copia de OCR en otro Diskgroup
cluvfy comp crs -n rac1                      # Verificar Integridad CRS
srvctl status database -d RAC                # Status Base de Datos
srvctl status instance -d RAC -i RAC1        # Status Instancia
srvctl status service -d RAC                 # Status Servicios de una BD
srvctl status nodeapps                       # Status Servicios de Red
srvctl status vip -n rac1                    # Status IP Virtual
srvctl status listener -l LISTENER           # Status Listener
srvctl status asm -n rac1                    # Status Instancia ASM
srvctl status scan                           # Status IP SCAN
srvctl status scan_listener                  # Status Listener SCAN
srvctl status server -n rac1                 # Status Nodo
srvctl status diskgroup -g DGRAC             # Status Disk Group
srvctl config database -d RAC                # Configuración Database
srvctl config service -d RAC                 # Configuración Servicios
srvctl config nodeapps                       # Configuración Servicios Red
srvctl config vip -n rac1                    # Configuración IP Virtual
srvctl config asm -a                         # Configuración Instancia ASM
srvctl config listener -l LISTENER           # Configuración Listener
srvctl config scan                           # Configuración IP SCAN
srvctl config scan_listener                  # Configuración SCAN Listener
 
# Arrancar, Parar y Reubicar Recursos de Cluster
crsctl stop cluster                                    # Parar Clusterware (requiere root)
crsctl start cluster                                   # Arrancar Clusterware (requiere root)
crsctl stop crs                                        # Parar OHAS (requiere root) - Incluye Parada Clusterware
crsctl start crs                                       # Arrancar OHAS (requiere root) - Incluye Arranque Clusterware
crsctl disable                                         # Deshabilitar Autoarranque CRS (requiere root)
crsctl disable                                         # Habilitar Autoarranque CRS (requiere root)
srvctl stop database -d RAC -o immediate               # Parar Database (parada IMMEDIATE)
srvctl start database -d RAC                           # Arrancar Database
srvctl stop instance -d RAC -i RAC1 -o immediate       # Parar Instancia BD (parada IMMEDIATE)
srvctl start instance -d RAC -i RAC1                   # Arrancar Instancia BD
srvctl stop service -d RAC -s OLTP -n rac1             # Parar Servicio
srvctl sart service -d RAC -s OLTP                     # Arrancar Servicio
srvctl stop nodeapps -n rac1                           # Parar Servicios Red (requiere parar dependencias)
srvctl start nodeapps                                  # Arrancar Servicios Red
srvctl stop vip -n rac1                                # Parar IP Virtual (requiere parar dependencias)
srvctl start vip -n rac1                               # Arrancar IP Virtual
srvctl stop asm -n rac1 -o abort -f                    # Parar Instancia ASM (es recomendable usar "crsctl stop cluster")
srvctl start asm -n rac1                               # Arrancar Instancia ASM (es recomendable usar "crsctl start cluser")
srvctl stop listener -l LISTENER                       # Parar Listener
srvctl start listener -l LISTENER                      # Arrancar Listener
srvctl stop scan -i 1                                  # Parar IP SCAN (requiere parar dependencias)
srvctl start scan -i 1                                 # Arrancar IP SCAN
srvctl stop scan_listener -i 1                         # Parar SCAN Listener
srvctl start scan_listener -i 1                        # Arrancar SCAN Listener
srvctl stop diskgroup -g TEST -n rac1,rac2             # Parar Disk Group (requiere parar dependencias)
srvctl start diskgroup -g TEST -n rac1,rac2            # Arrancar Disk Group (requiere parar dependencias)
srvctl relocate service -d RAC -s OLTP -i RAC1 -t RAC2 # Reubicar Servicio (del nodo 1 al nodo 2)
srvctl relocate scan_listener -i 1 rac1                # Reubicar SCAN Listener
4. Vamos a hacer un pequeño ejercicio con los ficheros OCR añadiendo y eliminando ubicaciones

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
# Como root, verificamos el estado del OCR
 # Veremos como la ubicación reside en +DGRAC
 /u01/app/11.2.0/grid/bin/ocrcheck
 
 # Añadimos una nueva ubicación para el OCR y eliminamos la antigua (+DGRAC)
 # El disco /dev/oracleasm/disks/TEST01 no debe estar en uso por ningún Disk Group
 /u01/app/11.2.0/grid/bin/ocrconfig -add /dev/oracleasm/disks/TEST01
 /u01/app/11.2.0/grid/bin/ocrconfig -delete +DGRAC
 
 # Validamos el resultado del cambio
 # Veremos como tenemos una única ubicación (/dev/oracleasm/disks/TEST01)
 /u01/app/11.2.0/grid/bin/ocrcheck
 
 # Por último, volvemos a ubicar el OCR en el diskgroup +DGRAC y comprobamos el resultado
 /u01/app/11.2.0/grid/bin/ocrconfig -add +DGRAC
 /u01/app/11.2.0/grid/bin/ocrconfig -delete /dev/oracleasm/disks/TEST01
 /u01/app/11.2.0/grid/bin/ocrcheck