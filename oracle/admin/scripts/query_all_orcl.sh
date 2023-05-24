#!/bin/bash
. /home/oracle/.bash_profile
##################################################################
#./query_all_orcl.sh "and AGGREGATE_TARGET_NAME like 'Desa-SAN-Grp' --and target_name like '%324%' " "select instance_name from v\$instance" "test.log"
#./query_all_orcl.sh "and AGGREGATE_TARGET_NAME like 'Desa-SAN-Grp' and target_name like '%CH%' " "@capacity.sql" "capacity.log"
##################################################################
export ORAENV_ASK=NO;export ORACLE_SID=CDBOMS;. oraenv > /dev/null 2>&1
export sqlfile="$2"

fffile=$3

rm $fffile 2>/dev/null
# 
#
dblist=`echo -e "set heading off feedback off echo off;\nSELECT b.AGGREGATE_TARGET_NAME||':'||listagg(property_value,':') within group (order by target_name, property_name)
FROM   mgmt\\$target_properties a, MGMT\\$TARGET_MEMBERS b
WHERE  target_type = 'oracle_database' AND a.target_name = b.member_target_name 
$1
AND  property_name in ('InstanceName','MachineName','Port','Version') group by AGGREGATE_TARGET_NAME,target_name;" | sqlplus -S sysman/Prodentmgr13c@"(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(Host = lxentmgr01.ar.bsch) (Port=7365))(CONNECT_DATA = (service_name = RIOOMS)))"`


for i in $dblist
do

 IFS=":" connect=($i)
  # set -A connect  $connect
  # dbname=${connect[0]/CDB/RIO}
  group_name=${connect[0]}
  odbname=${connect[1]}
  dbname=${connect[1]}
  hostn=${connect[2]}
  portn=${connect[3]}
  version=${connect[4]}
 unset IFS


if [ $hostn = "dbportalsec.ar.bsch" ] || [ $hostn = "wasnorkompp07.ar.bsch" ] || [ $hostn = "lxentmgr01.ar.bsch" ] || [ $hostn = "ctrlmsrv03.ar.bsch" ] ||  [ $hostn = "ctrlmsrv04.ar.bsch" ] || [ $hostn = "clientsat3.ar.bsch" ] || [ $dbname = "clientsat3.ar.bsch" ] || [ $dbname = "-MGMTDB" ]
then
continue
fi




# para no correr contra el nodo 2 de estos RACs , asi solo correra contra el nodo 1 y el reporte no tendra datos repetidos
if [ $hostn = "dbexap01db02-vip.ar.bsch" ] || [ $hostn = "dbrlxinetp03-vip.ar.bsch" ] || [ $hostn = "dbrlxopersrv03-vip.ar.bsch" ] || [ $hostn = "dbrlxapiidesrv3.ar.bsch" ] || [ $hostn = "dbsrac2.ar.bsch" ] || [ $hostn = "dbracaix2.ar.bsch" ]
then
continue
fi


# aca se saca el ultimo caracter o numero de la variable dbname para estos hostn que son los 2 nodos de distintos RACs
if [ $hostn = "dbexap01db01-vip.ar.bsch" ] || [ $hostn = "dbrlxinetp01-vip.ar.bsch" ] || [ $hostn = "dbrlxopersrv01-vip.ar.bsch" ] || [ $hostn = "dbrlxapiidesrv1.ar.bsch" ] || [ $hostn = "dbexap01db02-vip.ar.bsch" ] || [ $hostn = "dbrlxinetp03-vip.ar.bsch" ] || [ $hostn = "dbrlxopersrv03-vip.ar.bsch" ] || [ $hostn = "dbrlxapiidesrv3.ar.bsch" ]
then
   dbname=${dbname%?}
fi





dbname=$(echo $dbname | sed 's/CDB/RIO/')

echo "Connecting to  ${hostn}:${portn}:${dbname} (version ${version})"

sqlplus -S dbsnmp/l_ellison2014@"(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(Host = ${hostn}) (Port=${portn}))(CONNECT_DATA = (SERVICE_NAME = ${dbname})))"  << EOF >> $fffile 2>&1
$sqlfile
--select name from v\$instance;
exit;
EOF

done



#sed -i '/^--/d' $fffile
#sed -i '/^$/d' $fffile
#sed -i '/^[[:space:]]*$/d' $fffile
#sed -i '/^ERROR/d' $fffile
#sed -i '/^ORA-/d' $fffile
#sed -i '/^descriptor/d' $fffile
#sed -i '/^select/d' $fffile
#sed -i '/^(select/d' $fffile
#sed -i '/^Linux-/d' $fffile
#sed -i '/^Process/d' $fffile
#sed -i '/^Additional/d' $fffile
#sed -i '/^Session/d' $fffile
#sed -i '/^*/d' $fffile


#echo "$fffile" | mailx -s "Capacity" -a "$fffile" dicabrera@santandertecnologia.com.ar
