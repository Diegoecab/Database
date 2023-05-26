
lsoh ()
{
    CENTRAL_ORAINV=`grep ^inventory_loc /etc/oraInst.loc | awk -F= '{print $2}'`;
    IFS='
';
    echo;
    printf "%-22s %-55s %-12s %-9s\n" HOME LOCATION VERSION EDITION;
    echo ---------------------- ------------------------------------------------------- ------------ ---------;
    for line in `grep "<HOME NAME=" ${CENTRAL_ORAINV}/ContentsXML/inventory.xml 2>/dev/null`;
    do
        unset ORAVERSION;
        unset ORAEDITION;
        OH=`echo $line | tr ' ' '\n' | grep ^LOC= | awk -F\" '{print $2}'`;
        OH_NAME=`echo $line | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`;
        comp_file=$OH/inventory/ContentsXML/comps.xml;
        comp_xml=`grep "COMP NAME" $comp_file | head -1`;
        comp_name=`echo $comp_xml | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`;
        comp_vers=`echo $comp_xml | tr ' ' '\n' | grep ^VER= | awk -F\" '{print $2}'`;
        case $comp_name in
            "oracle.crs")
                ORAVERSION=$comp_vers;
                ORAEDITION=GRID
            ;;
            "oracle.sysman.top.agent")
                ORAVERSION=$comp_vers;
                ORAEDITION=AGT
            ;;
            "oracle.server")
                ORAVERSION=`grep "PATCH NAME=\"oracle.server\"" $comp_file 2>/dev/null | tr ' ' '\n' | grep ^VER= | awk -F\" '{print $2}'`;
                ORAEDITION="DBMS";
                if [ -z "$ORAVERSION" ]; then
                    ORAVERSION=$comp_vers;
                fi;
                ORAMAJOR=`echo $ORAVERSION |  cut -d . -f 1`;
                case $ORAMAJOR in
                    11 | 12)
                        ORAEDITION="DBMS "`grep "oracle_install_db_InstallType" $OH/inventory/globalvariables/oracle.server/globalvariables.xml 2>/dev/null | tr ' ' '\n' | grep VALUE | awk -F\" '{print $2}'`
                    ;;
                    10)
                        ORAEDITION="DBMS "`grep "s_serverInstallType" $OH/inventory/Components21/oracle.server/*/context.xml 2>/dev/null | tr ' ' '\n' | grep VALUE | awk -F\" '{print $2}'`
                    ;;
                esac
            ;;
        esac;
        [[ -n $ORAEDITION ]] && printf "%-22s %-55s %-12s %-9s\n" $OH_NAME $OH $ORAVERSION $ORAEDITION;
    done;
    echo
}