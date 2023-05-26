#####################################################
##    Oracle LAD DC                                ##
##    Producto: Oracle Goldengate 12.2.x           ##
##              for Oracle Database                ##
##    Cliente: Directv Argentina                   ##
##    Objetivo: Creación de una HeartBeat Table    ##
#####################################################


A continuación se detalla el AP para la creación de una HeartBeat Table de monitoreo de arquitectura Goldengate para la Base de Datos ORACLE (únicamente).

	*Nota: El scope de Bases de Datos a afectar deberá estar en el Cambio respectivo

1. Prevalidación

   * Corroborar versión de Goldengate instalada, esto se puede ver facilmente en el banner de bienvenida al loggearse a la consola ggsci
		
		Deberá mostrar una versión 12.2.X De lo contrario esa instancia NO será objeto del CH
		
	    Salida esperada similar
		
		===
		[ggate@rdp3dbadm01 gg_12201_AR]$ ./ggsci

		Oracle GoldenGate Command Interpreter for Oracle
		Version 12.2.0.1.170221 OGGCORE_12.2.0.1.0OGGBP_PLATFORMS_170123.1033_FBO
		Linux, x64, 64bit (optimized), Oracle 12c on Jan 23 2017 23:22:14
		Operating system character set identified as UTF-8.
		
		Copyright (C) 1995, 2017, Oracle and/or its affiliates. All rights reserved.
		===

		
		
   * Corroborar el nombre del esquema de Base de Datos usado por Goldengate
   
		Para hacerlo de forma rápida debemos loggearnos a la BD desde ggsci usando el alias indicado en las primeras lineas
		de cualquiera de los archivos de parámetros de algún grupo de procesos. Ejemplo
		
		===
		GGSCI (rdp3dbadm01.dtvpan.com) 3> view param AREXTA

		EXTRACT arexta
		
		-- Env Setting
		SETENV (ORACLE_HOME = "/u01/app/oracle/product/12.1.0.2/dbhome_1")
		SETENV (NLS_LANG = "AMERICAN_AMERICA.AL32UTF8")
		USERIDALIAS ogg_rgibsp1
		EXTTRAIL /u01/app/oracle/product/gg_12201_AR/dirdat/EA
		
		...
		...
		...
		
		GGSCI (rdp3dbadm01.dtvpan.com) 4> dblogin USERIDALIAS ogg_rgibsp1
		Successfully logged into database.
		
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 5>
		
			**El identificador al lado izquierdo del @ es el usuario de Base de Datos** y a la derecha es el nombre de la instancia de BD

		===
		
   * Corroborar espacio disponible en Tablespace del usuario de Goldengate 
   
        
		===
		
		rgibsp11 SYS:SQL> col username for A30
		rgibsp11 SYS:SQL> SELECT username,default_tablespace FROM dba_users WHERE username ='OGG';
		
		USERNAME                       DEFAULT_TABLESPACE
		------------------------------ ------------------------------
		OGG                            USERS
		
		
		rgibsp11 SYS:SQL>select a.tablespace_name, round(sum(bytes)/1024/1024/1024,2) "Occupied GB" 
								,round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) "MAX GB"
								,round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) - round(sum(bytes)/1024/1024/1024,2) as "Free GB"
								,round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) * .10 as "Ten percent"
								,Trunc((((round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) - round(sum(bytes)/1024/1024/1024,2))*100) / (round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2))),2) as "Current percent Free"
								from dba_data_files a
								where a.tablespace_name IN ('USERS') 
								group by tablespace_name order by 6 desc;
		
		TABLESPACE_NAME                   Occupied GB         MAX GB        Free GB    Ten percent Current percent Free
		------------------------------ -------------- -------------- -------------- -------------- --------------------
		USERS                                       2             32             30            3.2                93.75

		===
		
		Con 2GB libres es más que suficiente ** En dado caso de no contar con espacio, se deberá tomar la acción pertinente con los datafiles para tener espacio mínimo
		
   

2. Creación de HeartBeat Table

   * En una consola ggsci conectados a la BD con DBLOGIN debemos asegurarnos de que el esquema de Goldengate esté definido en el archivo de parámetros GLOBALES
   
		===
		
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 8> view param ./GLOBALS
		
		ENABLEMONITORING
		
		** De lo contrario hay que editar el archivo de parámetros agregando el esquema correspondiente
		
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 9> edit param ./GLOBALS
		
		** Agregar la siguiente linea: GGSCHEMA <Goldengate DataBase User Name>
		
		GGSCHEMA OGG
		
		** Guardar cambios, en el ejemplo se vería algo así
		
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 8> view param ./GLOBALS
		
		ENABLEMONITORING
		GGSCHEMA OGG
		
		===
		
   * Dar Stop a TODOS y cada uno de los procesos de la instancia de Goldengate (Incluyendo JAGENT y MGR)
   
		===
		
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 9> Stop ER *
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 10> Stop JAGENT !
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 11> Stop mgr !
		*** Esperar 2 minutos
		
		===
		
  * Iniciar Manager y Crear HeartBeat Table (se debe estar loggeado a la BD desde ggsci)
  
		===
		
		** Salida similar esperada
		
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 11> Start MGR
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 11> Add HeartBeatTable

		2018-05-31 16:58:10  INFO    OGG-14001  Successfully created heartbeat seed table ["GG_HEARTBEAT_SEED"].
		
		2018-05-31 16:58:10  INFO    OGG-14032  Successfully added supplemental logging for heartbeat seed table ["GG_HEARTBEAT_SEED"].
		
		2018-05-31 16:58:10  INFO    OGG-14000  Successfully created heartbeat table ["GG_HEARTBEAT"].
		
		2018-05-31 16:58:10  INFO    OGG-14033  Successfully added supplemental logging for heartbeat table ["GG_HEARTBEAT"].
		
		2018-05-31 16:58:10  INFO    OGG-14016  Successfully created heartbeat history table ["GG_HEARTBEAT_HISTORY"].
		
		2018-05-31 16:58:10  INFO    OGG-14023  Successfully created heartbeat lag view ["GG_LAG"].
		
		2018-05-31 16:58:10  INFO    OGG-14024  Successfully created heartbeat lag history view ["GG_LAG_HISTORY"].
		
		2018-05-31 16:58:10  INFO    OGG-14003  Successfully populated heartbeat seed table with [GGCERT1].
		
		2018-05-31 16:58:10  INFO    OGG-14004  Successfully created procedure ["GG_UPDATE_HB_TAB"] to update the heartbeat tables.
		
		2018-05-31 16:58:10  INFO    OGG-14017  Successfully created procedure ["GG_PURGE_HB_TAB"] to purge the heartbeat history table.
		
		2018-05-31 16:58:10  INFO    OGG-14005  Successfully created scheduler job ["GG_UPDATE_HEARTBEATS"] to update the heartbeat tables.
		
		2018-05-31 16:58:10  INFO    OGG-14018  Successfully created scheduler job ["GG_PURGE_HEARTBEATS"] to purge the heartbeat history table.
		
		
		** Revisar que la Tabla ya aparezca con un comando Info
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 11> Info HeartBeatTable
		
		HEARTBEAT table OGG.gg_heartbeat exists.

		HEARTBEAT table OGG.gg_heartbeat_seed exists.
		
		HEARTBEAT table OGG.gg_heartbeat_history exists.
		
		Frequency interval: 60 seconds.
		
		Purge frequency interval: 1 days.
		
		Retention time: 30 days.
		
		GGSCI (ggcert1.egls as ogg@GGCERT1) 18>

					
		===
		
		
		
   * Iniciar Procesos restantes de GoldenGate
   
		===
		
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 11> Start Jagent
		GGSCI (rdp3dbadm01.dtvpan.com as ogg@rgibsp12) 11> Start ER *
		
		** Vigilar que no se vaya a Abended nada y que el lag sea 0
		
		===

3. Validación de funcionamiento

   * Entrar a la BD y hacer el siguiente Query
   
   set hea on
   set wrap off
   set lin 300
   set pages 50
   column Extract format a9
   column Data_Pump format a10
   column Replicat format a9
   
   
   select to_char(incoming_heartbeat_ts,'DD-MON-YY HH24:MI:SSxFF') Source_HB_Ts
   	, incoming_extract Extract
   	, extract (day from (incoming_extract_ts - incoming_heartbeat_ts))*24*60*60+
   		extract (hour from (incoming_extract_ts - incoming_heartbeat_ts))*60*60+
   		extract (minute from (incoming_extract_ts - incoming_heartbeat_ts))*60+
   		extract (second from (incoming_extract_ts - incoming_heartbeat_ts)) Extract_Lag
   	, incoming_routing_path Data_Pump
   	, extract (day from (incoming_routing_ts - incoming_extract_ts))*24*60*60+
   		extract (hour from (incoming_routing_ts - incoming_extract_ts))*60*60+
   		extract (minute from (incoming_routing_ts - incoming_extract_ts))*60+
   		extract (second from (incoming_routing_ts - incoming_extract_ts)) Data_Pump_Read_Lag
   	, incoming_replicat Replicat
   	, extract (day from (incoming_replicat_ts - incoming_routing_ts))*24*60*60+
   		extract (hour from (incoming_replicat_ts - incoming_routing_ts))*60*60+
   		extract (minute from (incoming_replicat_ts - incoming_routing_ts))*60+
   		extract (second from (incoming_replicat_ts - incoming_routing_ts)) Replicat_Read_Lag
   	, extract (day from (heartbeat_received_ts - incoming_replicat_ts))*24*60*60+
   		extract (hour from (heartbeat_received_ts - incoming_replicat_ts))*60*60+
   		extract (minute from (heartbeat_received_ts - incoming_replicat_ts))*60+
   		extract (second from (heartbeat_received_ts - incoming_replicat_ts)) Replicat_Apply_Lag
   	, extract (day from (heartbeat_received_ts - incoming_heartbeat_ts))*24*60*60+
   		extract (hour from (heartbeat_received_ts - incoming_heartbeat_ts))*60*60+
   		extract (minute from (heartbeat_received_ts - incoming_heartbeat_ts))*60+
   		extract (second from (heartbeat_received_ts - incoming_heartbeat_ts)) Total_Lag
   from ogg.gg_heartbeat_history order by heartbeat_received_ts desc;
   
  
set pagesize 200 linesize 200
col heartbeat_received_ts format a30
col incoming_path format a24
col incoming_lag format 999,999,999.999
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
SELECT heartbeat_received_ts, incoming_path, incoming_lag FROM ogg.gg_lag_history;

column heartbeat_received_ts format a30
column incoming_path format a40
column incoming_lag format 999,999,999.999
select heartbeat_received_ts, incoming_path, incoming_lag from ogg.gg_lag_history;

  
   *** Es probable que al inicio nos de 0 Rows Selected, depende mucho de la actividad de la BD, pero si esperamos unos minutos esas tablas deberán mostrar información
   
FIN del CH