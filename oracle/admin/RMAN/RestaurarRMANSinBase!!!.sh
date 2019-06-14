###############################################################################



                    #RESTORE - RECOVER DATABASE ORASP01#



###############################################################################
#############################Variables#########################################
###############################################################################
export ORACLE_SID=orasp01
export ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
export DIR_BACK=/backup_impo/RMAN/backups
export DIR_BACK_CONTROLF=$DIR_BACK/controlfile
export DIR_BACK_ARCHIVES=$DIR_BACK/archives
export DIR_BACK_LEVEL0=$DIR_BACK/level0
export DIR_BACK_LEVEL1=$DIR_BACK/level1
export DIR_LOGS=$DIR_BACK/logs
###############################################################################
#############################Start orasp01#####################################
###############################################################################
$ORACLE_HOME/bin/sqlplus / as sysdba <<EOF
shutdown immediate
startup nomount force
quit
EOF
###############################################################################
#############################Start Catalogo Rman###############################
###############################################################################
export ORACLE_SID=rman
$ORACLE_HOME/bin/sqlplus / as sysdba <<EOF
startup
quit
EOF
###############################################################################
#############################Restore - Recover database########################
###############################################################################
export ORACLE_SID=orasp01
$ORACLE_HOME/bin/rman target / catalog rman/oracle@catalog
set DBID=1355438840;
restore controlfile from '
alter database mount;
catalog start with '$DIR_BACK_LEVEL0' noprompt;
catalog start with '$DIR_BACK_LEVEL1' noprompt;
catalog start with '$DIR_BACK_ARCHIVES' noprompt;
catalog start with '$DIR_BACK_CONTROLF' noprompt;
run {
set until sequence
restore database;
recover database;
alter database open;
}
