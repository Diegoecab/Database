##Ejemplo

rman target sys/npd-sys-2014@CELULARP auxiliary sys/npd-sys-2014@CELULARD


run {
allocate channel primary1 type disk;
allocate channel primary2 type disk;
allocate channel primary3 type disk;
allocate channel primary4 type disk;
allocate auxiliary channel aux1 type disk;
allocate auxiliary channel aux2 type disk;
allocate auxiliary channel aux3 type disk;
allocate auxiliary channel aux4 type disk;
duplicate target database to 'PDCD' from active database;
}


##Ejemplo
LISTENER_5322 =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = oraspdcdev01.iaas.ar.bsch)(PORT = 5322))
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC5322))
    )
  )

SID_LIST_LISTENER_5322=
 (SID_LIST=
  (SID_DESC=
   (GLOBAL_DBNAME=PDCD)
   (ORACLE_HOME = /oracle/app/oracle/product/12c)
   (SID_NAME = PDCD)
  )
)

tnsnames.ora
CDB196D_DG = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(Host = lxdesaora7.ar.bsch)(Port=5322))(CONNECT_DATA = (service_name = CDB196D_DG)))
PDCD_DG = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(Host = oraspdcdev01.iaas.ar.bsch)(Port=5322))(CONNECT_DATA = (sid = PDCD)))


(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=LXHOMOORA7.ar.bsch)(Port=6482))(CONNECT_DATA=(SID=CDB196H)))


rman target sys/SanxenxO_0932@CDB196D_DG auxiliary sys/SanxenxO_0932@PDCD_DG
startup clone nomount;
run {
allocate channel primary1 type disk;
allocate channel primary2 type disk;
allocate channel primary3 type disk;
allocate channel primary4 type disk;
allocate auxiliary channel aux1 type disk;
allocate auxiliary channel aux2 type disk;
allocate auxiliary channel aux3 type disk;
allocate auxiliary channel aux4 type disk;
DUPLICATE TARGET DATABASE
  FOR STANDBY
  FROM ACTIVE DATABASE
  DORECOVER
  SPFILE
    SET "db_unique_name"="PDCQ" COMMENT 'Is a duplicate'
    SET LOG_ARCHIVE_DEST_2="service=CDB196H ASYNC REGISTER VALID_FOR=(online_logfile,primary_role)"
    SET FAL_CLIENT="PDCQ" COMMENT "Is standby"
	set audit_file_dest="/oracle/app/oracle/audit/PDCQ"
	set audit_trail="none"
    SET FAL_SERVER="CDB196H" COMMENT "Is primary"
  NOFILENAMECHECK;
}



alter system set log_archive_dest_2='service=PDCD_DG ASYNC valid_for=(ONLINE_LOGFILE,PRIMARY_ROLE) COMPRESSION=ENABLE db_unique_name=PDCD';

##Ejemplo

run {
allocate auxiliary channel ch1 type disk;
allocate auxiliary channel ch2 type disk;
allocate auxiliary channel ch3 type disk;
allocate auxiliary channel ch4 type disk;
allocate auxiliary channel ch5 type disk;
allocate auxiliary channel ch6 type disk;
allocate auxiliary channel ch7 type disk;
allocate auxiliary channel ch8 type disk;

duplicate database to 'csibsr' backup location '/REMOTE_BKPS/csibsr/DCABRERA' NOFILENAMECHECK;

}