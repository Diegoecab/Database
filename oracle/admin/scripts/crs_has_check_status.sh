#GI check status

#Functions
chk_has ()
{
OH=$1
unset ASM CSS CTSS EVM SCAN SCANLIST OCR HAS
##Checkeo instancia ASM
ASM=`$OH/bin/srvctl status asm | /bin/cut -c8-14`
##Checkeo CSS
CSS=`$OH/bin/crsctl check css | cut -c47-52`
#Checkeo CTSS
CTSS=`$OH/bin/crsctl check css | cut -c47-52`
##Checkeo EVM
EVM=`$OH/bin/crsctl check evm | cut -c28-33`
##Checkeo OCR
OCR=`$OH/bin/cluvfy comp ocr | grep -i failed`
##Checkeo OHAS
HAS=`$OH/bin/crsctl check has`
echo "ASM: ${ASM} CSS: ${CSS} CTSS: ${CSS} EVM: ${EVM} SCAN: ${SCAN} SCANLIST ${SCANLIST} OCR: ${OCR} HAS: ${HAS}"
}

chk_crs ()
{
OH=$1
unset ASM CSS CTSS EVM SCAN SCANLIST OCR HAS
##Checkeo instancia ASM
ASM=`$OH/bin/srvctl status asm | /bin/cut -c8-14`
##Checkeo CSS
CSS=`$OH/bin/crsctl check css | cut -c47-52`
#Checkeo CTSS
CTSS=`$OH/bin/crsctl check css | cut -c47-52`
##Checkeo EVM
EVM=`$OH/bin/crsctl check evm | cut -c28-33`
##Checkeo SCAN
SCAN=`$OH/bin/srvctl status scan | grep -i not`
##Checkeo SCAN Listener
SCANLIST=`$OH/bin/srvctl status scan_listener | grep -i not`
##Checkeo OCR
OCR=`$OH/bin/cluvfy comp ocr | grep -i failed`
##Checkeo OHAS
HAS=`$OH/bin/crsctl check crs`
echo "ASM: ${ASM} CSS: ${CSS} CTSS: ${CSS} EVM: ${EVM} SCAN: ${SCAN} SCANLIST ${SCANLIST} OCR: ${OCR} HAS: ${HAS}"
}

fn_get_inv ()
{
#Ora Inventory
v_orcl_inventory_loc=$(grep inventory_loc /etc/oraInst.loc | awk -F= '{ print $2 }')
v_orcl_inventory_file="${v_orcl_inventory_loc}/ContentsXML/inventory.xml"
}

fn_gi_chk_proc ()
{
#1) Check has/crs by running processes
v_orcl_oh_is_has_running=$(ps -ef | grep -iw [o]hasd.bin | wc -l)
v_orcl_oh_has_path=$(ps -ef | grep -iw [o]hasd.bin | awk '{print $8}')
echo $v_orcl_oh_has_path
v_orcl_oh_has_path=$(echo ${v_orcl_oh_has_path} | sed 's|\(.*\)/.*|\1|' | sed 's|\(.*\)/.*|\1|')
echo $v_orcl_oh_has_path
v_orcl_oh_is_crs=$(grep "LOC=\"" ${v_orcl_inventory_file} | grep "${v_orcl_oh_has_path}" | grep -v "REMOVED=\"T\"" | grep -i \"CRS=\\\"true\\\"\" | wc -l)
echo $v_orcl_oh_is_crs

if [ "${v_orcl_oh_is_crs}" == "0" ] ; then
 ${v_orcl_oh_has_path}/bin/crsctl check has
fi
}

#2) Check has/crs by inventory
fn_gi_chk_inv ()
{
fn_get_inv
for line in `grep "<HOME NAME=" $v_orcl_inventory_file | grep -v "REMOVED=\"T\"" `;
    do
        unset ORAVERSION;
        unset ORAEDITION;
        OH=`echo $line | tr ' ' '\n' | grep ^LOC= | awk -F\" '{print $2}'`;
        OH_NAME=`echo $line | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`;
        comp_file=$OH/inventory/ContentsXML/comps.xml;
        comp_xml=`grep "COMP NAME" $comp_file 2>/dev/null | head -1 `;
        comp_name=`echo $comp_xml 2>/dev/null| tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`;
        comp_vers=`echo $comp_xml 2>/dev/null| tr ' ' '\n' | grep ^VER= | awk -F\" '{print $2}'`;
        v_orcl_oh_is_crs=$(grep "${OH}" $v_orcl_inventory_file | grep -i "CRS=\"true\"" | wc -l)
        
        if [ "${comp_name}" == "oracle.crs" ] && [ "${v_orcl_oh_is_crs}" == "0" ]  ; then #Es HAS
            echo "Checking HAS on $OH ($comp_name $comp_vers)"
            chk_has ${OH}
        fi
        
        if [ "${comp_name}" == "oracle.crs" ] && [ "${v_orcl_oh_is_crs}" == "1" ]  ; then #Es RAC
            echo "Checking CRS on $OH ($comp_name $comp_vers)"
            ${OH}/bin/crsctl check crs
        fi
done
}


#2) Check db status by inventory
fn_db_chk_inv ()
{
fn_get_inv
for line in `grep "<HOME NAME=" $v_orcl_inventory_file | grep -v "REMOVED=\"T\""`;
    do
        unset ORAVERSION;
        unset ORAEDITION;
        OH=`echo $line | tr ' ' '\n' | grep ^LOC= | awk -F\" '{print $2}'`;
        OH_NAME=`echo $line | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`;
        comp_file=$OH/inventory/ContentsXML/comps.xml;
        comp_xml=`grep "COMP NAME" $comp_file 2>/dev/null | head -1 `;
        comp_name=`echo $comp_xml 2>/dev/null| tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`;
        comp_vers=`echo $comp_xml 2>/dev/null| tr ' ' '\n' | grep ^VER= | awk -F\" '{print $2}'`;
        v_orcl_oh_is_crs=$(grep "${OH}" $v_orcl_inventory_file | grep -v "REMOVED=\"T\"" | grep -i "CRS=\"true\"" | wc -l)
        
        if [ "${comp_name}" == "oracle.crs" ] && [ "${v_orcl_oh_is_crs}" == "0" ]  ; then #Es HAS
            echo "Checking DBs on $OH ($comp_name $comp_vers)"
            dblist=$($OH/bin/srvctl config database)
            for i in $dblist
            do
            echo "Check DB $i"
            $OH/bin/srvctl status database -d $i
            done
        fi
        
        if [ "${comp_name}" == "oracle.crs" ] && [ "${v_orcl_oh_is_crs}" == "1" ]  ; then #Es RAC
            echo "Checking Dbs on $OH ($comp_name $comp_vers)"
            ${OH}/bin/crsctl check crs
        fi
done
}


fn_gi_chk_inv
fn_db_chk_inv

