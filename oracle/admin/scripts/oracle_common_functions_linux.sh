###########################
#
# Common Oracle Environment
#
###########################


function s_ {

        if [ $# = 0 ] ; then
                if [ _"${ORACLE_SID:0:1}" = _+ ] ; then
                        set -- / as sysasm
                else
                        set -- / as sysdba
                fi
        fi

	if [ -x $RLWRAP ] ; then
	        $RLWRAP -i -b '()=!<>&+-*|:;,' $ORACLE_HOME/bin/sqlplus $*
	else
	        $ORACLE_HOME/bin/sqlplus $*
	fi
}

function asm_ {
	if [ -x $RLWRAP ] ; then
		$RLWRAP -i -b '()=!<>&+-*|:;,' $ORA_CLU_HOME/bin/asmcmd $*
	else
		$ORA_CLU_HOME/bin/asmcmd $*
	fi
}

function rman_ {
	if [ -x $RLWRAP ] ; then
		$RLWRAP -i -b '()=!<>&+-*|:;,' $ORACLE_HOME/bin/rman $*
	else
		$ORACLE_HOME/bin/rman $*
	fi
}

function dg_ {
	if [ -x $RLWRAP ] ; then
		$RLWRAP -i -b '()=!<>&+-*|:;,' $ORACLE_HOME/bin/dgmgrl $*
	else
		$ORACLE_HOME/bin/dgmgrl $*
	fi
}

function lsn_ {
	if [ -x $RLWRAP ] ; then
		$RLWRAP -i -b '()=!<>&+-*|:;,' $ORACLE_HOME/bin/lsnrctl $*
	else
		$ORACLE_HOME/bin/lsnrctl $*
	fi
}

function adr_ {
	if [ -x $RLWRAP ] ; then
		$RLWRAP -i -b '()=!<>&+-*|:;,' $ORACLE_HOME/bin/adrci $*
	else
		$ORACLE_HOME/bin/adrci $*
	fi
}

function cm_ {
	if [ -x $RLWRAP ] ; then
		$RLWRAP -i -b '()=!<>&+-*|:;,' $ORACLE_HOME/bin/cmctl $*
	else
		$ORACLE_HOME/bin/cmctl $*
	fi
}

function diag () {
	if [ -n "${DB_UNIQUE_NAME}" ] ; then 
		cd $DIAGNOSTIC_DEST/diag/rdbms/`echo ${DB_UNIQUE_NAME} | tr [:upper:] [:lower:]`/${ORACLE_SID}/trace
	else
		echo 'DB_UNIQUE_NAME not set. Try to set an environment.'
	fi
}

function laldb () {
	if [ -n "${DB_UNIQUE_NAME}" ] ; then 
		less $DIAGNOSTIC_DEST/diag/rdbms/`echo ${DB_UNIQUE_NAME} | tr [:upper:] [:lower:]`/${ORACLE_SID}/trace/alert_${ORACLE_SID}.log
	else
		echo 'DB_UNIQUE_NAME not set. Try to set an environment.'
	fi
}
function taldb () {
	if [ -n "${DB_UNIQUE_NAME}" ] ; then 
		tail -100f $DIAGNOSTIC_DEST/diag/rdbms/`echo ${DB_UNIQUE_NAME} | tr [:upper:] [:lower:]`/${ORACLE_SID}/trace/alert_${ORACLE_SID}.log
	else
		echo 'DB_UNIQUE_NAME not set. Try to set an environment.'
	fi
}


function genpasswd() {
        echo `< /dev/urandom tr -dc _%A-Z-+a-z-0-9 | head -c${1:-30}`;
}


function F_isCDB  {
        # returns true if is CDB , false otherwise
        $ORACLE_HOME/bin/sqlplus -s /nolog <<EOF | grep ISCDB >/dev/null
                connect / as sysdba
                select 'ISCDB' as foo from v\$parameter where name='enable_pluggable_database' and value='TRUE';
                exit
EOF
}


function F_pmon_running () {
	# returns true if pmon running, false else
	sid=${1:-$ORACLE_SID}
	if [ -n "$sid" ] ; then
		ps -eaf | grep [p]mon_$sid >/dev/null
	else
		false
	fi
}

function dbsingle {

	my_sid=$1
	if [ -z "$my_sid" ] ; then
		singlestat
		return 0
	fi

	l_dbmatch=`single_dblist | grep -i "^$my_sid:" `
	
	if [ $? -eq 0 ] ; then
		export ORACLE_SID=`echo $l_dbmatch | awk -F: '{print $1}'`
		export ORACLE_HOME=`echo $l_dbmatch | awk -F: '{print $2}'`

		echo "ORACLE_SID      = $ORACLE_SID"
		# set variables according to current ORACLE_HOME variable
		setohenv

		F_pmon_running
		if [ $? -ne 0 ] ; then
			echo
			echo -e "${colred}Instance $my_sid is not running${colrst}. Cannot determine correct NLS_LANG."
		else
			L_props=`$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF 2>/dev/null | grep -v -e '^$'
set echo off feedback off heading off
SELECT 'export NLS_CHARSET='||value\\$ FROM sys.props\\$ WHERE name = 'NLS_CHARACTERSET' ;
SELECT 'export DIAGNOSTIC_DEST='||value FROM v\\$parameter WHERE name = 'diagnostic_dest' ;
EOF
`
			if [ -n "$L_props" ] ; then
				eval $L_props
				export NLS_LANG=AMERICAN_AMERICA.$NLS_CHARSET
			fi
		fi
		echo "NLS_LANG        = $NLS_LANG"
	else
		echo "Instance or DB $my_sid is not running on this server"
	fi

}

function dbrac {
	# the purpose of this function is to set the environment for a specific database when CRS is installed
	# for single instance databases, see dbsingle
	my_sid=$1
	if [ -z "$my_sid" ] ; then
		racstat
		return $?
	fi

	case ${my_sid} in
		"MGMTDB" | "GIMR" | "APX" | "ASM" | "GRID" | "CRS" )
			export ORACLE_HOME=$ORA_CLU_HOME
			export ORACLE_BASE=${ORACLE_BASE:-/u01/app/oracle}
			if [ $my_sid == "MGMTDB" ] || [ $my_sid == "GIMR" ] ; then
	                        export ORACLE_SID="-MGMTDB"
				MGMTDB_HOST=`srvctl status mgmtdb | grep "is running" | awk '{print $NF}'`
				CURRENT_HOST=`hostname -s`
				if [ "$MGMTDB_HOST" != $CURRENT_HOST ] ; then
					echo "Warning: the MGMTDB is running on $MGMTDB_HOST, not here"
				fi
			fi

			if [ $my_sid == "GRID" ] || [ $my_sid == "CRS" ] ; then
				export ORACLE_SID=$my_sid
			fi
			if [ $my_sid == "ASM" ] ; then
	                        export ORACLE_SID="+"`ps -eaf | grep [a]sm_pmon | awk -F+ '{print $NF}'`
			fi
			if [ $my_sid == "APX" ] ; then
                        	export ORACLE_SID="+"`ps -eaf | grep [a]px_pmon | awk -F+ '{print $NF}'`
			fi
			unset DB_ROLE
			unset CRS_DB_STATE
			unset DB_UNIQUE_NAME
			unset CRS_DB_RESOURCE
			echo "ORACLE_SID      = $ORACLE_SID"
			setohenv
			;;
		*)
			# Here the user wants a real database. For ease of use, we'll permit:
			# 	- a precise INSTANCE_NAME (if it does not match with the local one, exits with a WARNING)
			#	- a DB_UNIQUE_NAME (the local INSTANCE_NAME will be set automatically)
			#	- a cluster resource name (the local INSTANCE_NAME will be set automatically)

			l_short_hostname=`hostname -s`
			l_dbmatch=`crs_dblist | grep -i ":$my_sid:" | grep -i $l_short_hostname`
			if [ $? -eq 0 ] ; then
				export ORACLE_BASE=${ORACLE_BASE:-/u01/app/oracle}
				export CRS_DB_RESOURCE=`echo $l_dbmatch | awk -F: '{print $2}'`
				export CRS_DB_STATE=`echo $l_dbmatch | awk -F: '{print $3}'`
				export DB_UNIQUE_NAME=`echo $l_dbmatch | awk -F: '{print $4}'`
				export ORACLE_SID=`echo $l_dbmatch | awk -F: '{print $5}'`
				export ORACLE_HOME=`echo $l_dbmatch | awk -F: '{print $6}'`
				export DB_ROLE=`echo $l_dbmatch | awk -F: '{print $7}'`
				export DB_NAME=`echo $l_dbmatch | awk -F: '{print $8}'`

				echo "DB_UNIQUE_NAME  = $DB_UNIQUE_NAME"
				echo "ORACLE_SID      = $ORACLE_SID"
				echo "ROLE            = $DB_ROLE"
				# set variables according to current ORACLE_HOME variable
				setohenv
				# check it the DB has a private TNS_ADMIN
				L_tnscheck=$(srvctl getenv database -d $DB_UNIQUE_NAME -t TNS_ADMIN | grep ^TNS_ADMIN)
				if [ $? -eq 0 ] ; then
					eval $L_tnscheck
				else
					TNS_ADMIN=$ORACLE_HOME/network/admin
				fi
				export TNS_ADMIN
				echo "TNS_ADMIN       = $TNS_ADMIN"
				if [ ${CRS_DB_STATE} != "ONLINE" ] ; then
					echo
					echo -e "${colred}Instance $my_sid is ${CRS_DB_STATE}${colrst}. Cannot determine correct NLS_LANG."
				else
					L_props=`$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF 2>/dev/null | grep -v -e '^$'
set echo off feedback off heading off
SELECT 'export NLS_CHARSET='||value\\$ FROM sys.props\\$ WHERE name = 'NLS_CHARACTERSET' ;
SELECT 'export DIAGNOSTIC_DEST='||value FROM v\\$parameter WHERE name = 'diagnostic_dest' ;
EOF
`
					if [ -n "$L_props" ] ; then
						eval $L_props
						export NLS_LANG=AMERICAN_AMERICA.$NLS_CHARSET
					fi
				fi
                                echo "NLS_LANG        = $NLS_LANG"
			else
				echo "Instance or DB  $my_sid is not running on this server"
			fi
	esac
}


function crs_dblist() {

	#output (validated in 11g and 12c):
	# :[resname]:[state]:[dbuniqname]:[instname]:[oraclehome]:[role]:[server]:[dbname]:
	# e.g.:
	# :ora.orcl_site1.db:ONLINE:ORCL_SITE1:ORCL1:/u01/app/oracle/product/rdbms1850:PRIMARY:server1:ORCL:

	${CRSCTL}  stat res -f -w "(TYPE = ora.database.type)" | awk -F= '{ if ($1 == "NAME" || $1 == "STATE" || $1 == "DB_UNIQUE_NAME" || $1 == "GEN_USR_ORA_INST_NAME" || $1 == "ORACLE_HOME" || $1 == "ROLE" || $1 == "TARGET_SERVER" || $1 == "USR_ORA_DB_NAME") { printf (":%s", $2); } if ( $0 ~ /^$/ ) printf(":\n"); }'
}

function svcstat() {
if [ $CRS_EXISTS -eq 1 ] ; then
${CRSCTL} stat res -f -w "(TYPE = ora.service.type)" | awk -F= '
function print_row() {
        dbbcol="";
        dbecol="";
        instbcol="";
        instecol="";
        instances=res["INSTANCE_COUNT 1"];
        for(i=1;i<=instances;i++) {
                # if at least one of the services is online, the service is online (then I paint it green)
                if (res["STATE " i] == "ONLINE" ) {
                        dbbcol="\033[0;32m";
                        dbecol="\033[0m";
                }
        }
        # db unique name is always the second part of the resource name
        # because it does not change, I can get it once from the resource name
	res["DB_UNIQUE_NAME"]=substr(substr(res["NAME"],5),1,index(substr(res["NAME"],5),".")-1);

	# same for service name
	res["SERVICE_NAME"]=substr(res["NAME"],index(substr(res["NAME"],5),".")+5,length(substr(res["NAME"],index(substr(res["NAME"],5),".")+5))-4);

	#starting printing the first part of the information
	printf ("%s%-24s %-30s %-30s%s",dbbcol, res["DB_UNIQUE_NAME"], res["SERVICE_NAME"], res["PLUGGABLE_DATABASE 1"], dbecol);

	# here, instance need to map to the correct server.
	# the mapping is done by attribute TARGET_SERVER (not last server)
	for ( n in node ) {
		node_name=node[n];
		status[node_name]="";
                for (i=1; i<=instances; i++) {
			# we are on the instance that matches the server
                        if (node_name == res["TARGET_SERVER " i]) {
                                res["SERVER_NAME " i]=node_name;
                                if (status[node_name] !~ "ONLINE") {
                                        # when a service relocates both instances get the survival target_server
                                        # but just one is ONLINE... so we need to get always the ONLINE one.
                                        #printf("was::%s:", status[node_name]);
                                        status[node_name]=res["STATE " i];
                                }

                                # colors modes
                                if ( res["STATE " i] == "ONLINE" && res["INTERNAL_STATE " i] == "STABLE" ) {
					# online and stable: GREEN
                                        status[node_name]=sprintf("\033[0;32m%-14s\033[0m", status[node_name]);
                                } 
				else if ( res["STATE " i] != "ONLINE" && res["INTERNAL_STATE " i] == "STABLE" ) {
					# offline and stable
					if ( res["TARGET " i] == "OFFLINE" ) {
						# offline, stable, target offline: BLACK
                                        	status[node_name]=sprintf("%-14s", status[node_name]);
					} 
					else {
						# offline, stable, target online: RED
	                                        status[node_name]=sprintf("\033[0;31m%-14s\033[0m", status[node_name]);
					}
                                } 
				else {
					# all other cases: offline and starting, online and stopping, clearning, etc.: YELLOW
                                        status[node_name]=sprintf("\033[0;33m%-14s\033[0m", status[node_name]);
                                }
                		#printf("%s %s %s %s\n", status[node_name], node[n], res["STATE " i], res["INTERNAL_STATE " i]);
                        }
                }
               printf(" %-14s", status[node_name]);
        }
	printf("\n");
}
function pad (string, len, char) {
        ret = string;
        for ( i = length(string); i<len ; i++) {
                ret = sprintf("%s%s",ret,char);
        }
        return ret;
}
BEGIN {
	debug = 0;
	first = 1;
	afterempty=1;
	# this loop should set:
	# node[1]=server1; node[2]=server2; nodes=2;
	nodes=0;
	while ("olsnodes" | getline a) {
		nodes++;
		node[nodes] = a;
	}
	fmt="%-24s %-30s %-30s";
	printf (fmt, "DB_Unique_Name", "Service_Name", "PDB");
	for ( n in node ) {
		printf (" %-14s", node[n]);
	}
	printf ("\n");
	printf (fmt, pad("",24,"-"), pad("",30,"-"), pad("",30,"-"));
	for ( n in node ) {
		printf (" %s", pad("",14,"-"));
	}
	printf ("\n");

}
# MAIN awk svcstat
{
	if ( $1 == "NAME" ) {
		if ( first != 1 && res["NAME"] == $2 ) {
			if ( debug == 1 ) print "Secondary instance";
			instance++;
		} 
		else {
			if ( first != 1 ) {
				print_row();
			}
			first = 0;
			instance=1;
			delete res;
			res["NAME"] = $2;
		}
	}
	else  {
		res[$1 " " instance] = $2 ;
	
	}
}
END {
	#if ( debug == 1 ) for (key in res) { print key ": " res[key] }
	print_row();
}
'
else 
	echo "svcstat not available on non-clustered environments"
	false
fi
}


function cmanconntdm() {
# based on Franck Pachot's snippet
	ps --no-headers -o pid,args -p$(pgrep -f "tnslsnr .* -mode proxy") |
	while IFS=" " read pid tnslsnr args ; do

		# get environment variables
 		awk '
		BEGIN{ RS="\0" }
		/^ORACLE_HOME|^TNS_ADMIN|^LD_LIBRARY_PATH/{printf "%s ",$0}
		END{print cmctl,here}
 		' cmctl="$(dirname $tnslsnr)/cmctl" here="<<-'CMCTL'" /proc/$pid/environ
		# name is probably the first arg without '-' nor '='
		name=$(echo "$args"|awk 'BEGIN{RS=" "}/^[^-][^=]*$/{print;exit}')
		echo "administer $name"
		echo "show connections detail"
		echo "CMCTL"
		done | sh | awk '
			function time(s) {
				if (s==4294967295) {
					return "runnning  "
				}
				d=int(s/86400)
				s=s-(d*86400)
				h=int(s/3600)
				s=s-(h*3600)
				m=int(s/60)
				s=s-(m*60)
				return sprintf("%dd+%02d:%02d:%02d",d,h,m,s)
			}
			function size(b) {
				u=""
				if (b>1024) {
					b=b/1024
					u="K"
				}
				if (b>1024) {
					b=b/1024
					u="M"
				}
				if (b>1024) {
					b=b/1024
					u="G"
				}
				return int(b)""u
			}
			function hostname(h) {
				a=h
				if (h~/^[0-9.]+$/) {
					"host "h| getline a
					close("host "h)
					sub(/^.* /,"",a)
					sub(/[.]$/,"",a)
				}
				return a
			}
			function pct(a,b) {
				return int(100*a/b)"%"
			}
		/Number of connections:/ {print} #{print>"/dev/stderr"}
		/Connection ID/ {id=$NF}
		/Gateway ID/ {gw=$NF}
		/Source/ {src=$NF}
		/Destination/ {dst=$NF}
		/Service/ {srv=$NF}
		/State/ {sta=$NF}
		/Idle time/ {idl=$NF}
		/Connected time/ || /Active time/ {con=$NF}
		/Bytes Received *.IN./ {rci=$NF}
		/Bytes Received *.OUT./ {rco=$NF}
		/Bytes Sent *.IN./ {sni=$NF}
		/Bytes Sent *.OUT./ {sno=$NF}
		/^$/ || /The command completed successfully/ {
			if (con>0) 
				printf "%-12s %60s %-40s %15s (idle: %9s) id:%6d gw:%3d\n", sta,hostname(src)"->"hostname(dst),srv,time(con),time(idl),id,gw
			con=0
		}
	' | sort -k3,2
}

function cmanconn() {
	# Franck Pachot's snippet: https://medium.com/@FranckPachot/oracle-connection-manager-cman-quick-reporting-script-cc711acbc966
	ps --no-headers -o pid,args -p$(pgrep -f "tnslsnr .* -mode proxy") |
	while IFS=" " read pid tnslsnr args ; do 
		# get environment variables
		awk '
			BEGIN{ RS="\0"}
			/^ORACLE_HOME|^TNS_ADMIN|^LD_LIBRARY_PATH/ {
				printf "%s ",$0
			}
			END { print cmctl,here }
		' cmctl="$(dirname $tnslsnr)/cmctl" here="<<-'CMCTL'" /proc/$pid/environ

		# name is probably the first arg without '-' nor '='
		name=$(echo "$args"|awk '
			BEGIN { RS=" " }
			/^[^-][^=]*$/ {
				print;exit
			}')
		echo "administer $name"
 		echo "show connections detail"
		echo "show connections count"
		echo "CMCTL"
	done | sh | awk '
		function time(s) {
			if (s==4294967295) {
				return "runnning  "
			}
			d=int(s/86400)
			s=s-(d*86400)
			h=int(s/3600)
			s=s-(h*3600)
			m=int(s/60)
			s=s-(m*60)
			return sprintf("%dd+%02d:%02d:%02d",d,h,m,s)
		}
		function size(b) {
			u=""
			if(b>1024) {
				b=b/1024
				u="K"
			}
			if(b>1024) {
				b=b/1024
				u="M"
			}
			if(b>1024) {
				b=b/1024
				u="G"
			}
			return int(b)""u
		}
		function hostname(h) {
			a=h
			if (h~/^[0-9.]+$/) {
				"host "h| getline a
				close("host "h)
				sub(/^.* /,"",a)
				sub(/[.]$/,"",a)
			}
			return a
		}
		function pct(a,b) {
			return int(100*a/b)"%"
		}
		/Number of connections:/ { print } 
		/Connection ID/ { id=$NF }
		/Gateway ID/ { gw=$NF }
		/Source/ { src=$NF }
		/Destination/ { dst=$NF }
		/Service/ { srv=$NF }
		/State/ { sta=$NF }
		/Idle time/ { idl=$NF }
		/Connected time/ { con=$NF }
		/Bytes Received *.IN./ { rci=$NF }
		/Bytes Received *.OUT./ { rco=$NF }
		/Bytes Sent *.IN./ { sni=$NF }
		/Bytes Sent *.OUT./ { sno=$NF }
		/^$/ || /The command completed successfully/ {
			if (con>0)
				printf "%-12s %60s %-40s %15s (idle: %9s) %9s>(%3d%%) %9s<(%3d%%) id:%6d gw:%3d\n", sta,hostname(src)"->"hostname(dst),srv,time(con),time(idl),size(rci),pct(sno,rci),size(rco),pct(sni,rco),id,gw
			con=0
		}
	' | sort -k3,2
}

function cmansvc() {
# Franck Pachot snippet: https://medium.com/@FranckPachot/oracle-connection-manager-cman-quick-reporting-script-cc711acbc966
ps --no-headers -o pid,args -p$(pgrep -f "tnslsnr .* -mode proxy") |
while IFS=" " read pid tnslsnr args
do
 # get environment variables
 awk '
  BEGIN{RS="\0"}
  /^ORACLE_HOME|^TNS_ADMIN|^LD_LIBRARY_PATH/{printf "%s ",$0}
  END{print cmctl,here}
  ' cmctl="$(dirname $tnslsnr)/cmctl" here="<<-'CMCTL'" /proc/$pid/environ
 # name is probably the first arg without '-' nor '='
 name=$(echo "$args"|awk 'BEGIN{RS=" "}/^[^-][^=]*$/{print;exit}')
 echo "administer $name"
 echo "show services"
 echo "CMCTL"
done | sh | awk '
function hostname(h){a=h;if (h~/^[0-9.]+$/){"host "h| getline a;close("host "h);sub(/^.* /,"",a);sub(/[.]$/,"",a)}return a}
/Service ".*" has .* instance/{
 gsub(qq," ")
 sub(/[.].*/,"") # remove domain
 service=$2
 all_service[service]=1
 stats="-"
}
/Instance ".*", status READY, has .* handler.* for this service/{
 gsub(qq," ")
 instance=$2
 all_instance[instance]=0
 stats="-"
}
/established:.* refused:.* state:.*/{
 sub(/^ */,"")
 sub(/.DEDICATED./,"D")
 sub(/established:/,"")
 sub(/refused:/,"/")
 sub(/state:/,"")
 sub(/ready/,"R")
 stats=$0
}
/ADDRESS.*HOST=.*PORT=/{
 port=$0;sub(/.*PORT=/,"",port);sub(/[)].*/,"",port)
 host=$0;sub(/.*HOST=/,"",host);sub(/[)].*/,"",host)
 if (host ~ /^[xxx0-9.]+$/) {
  "host "host| getline host_host
  sub(/^.* /,"",host_host)
  sub(/[.]$/,"",host_host)
  host=host_host
 }
 host=hostname(host)
 sub(/[.].*/,"",host) # remove domain
 all_instance_host[instance]=host
 all_instance_port[instance]=port
 all_instance_instance[instance]=instance
 all_instance_stats[instance]=stats
 all_service_instance[service,instance]=instance
 if (length(host) > all_instance[instance] ) {
  all_instance[instance]= length(host)
 }
 if (length(port) > all_instance[instance] ) {
  all_instance[instance]= length(port)
 }
 if (length(instance) > all_instance[instance] ) {
  all_instance[instance]= length(instance)
 }
}
END{
  # host
  printf "1%39s ","host:"
  for (instance in all_instance){
   printf "%-"all_instance[instance]"s ", all_instance_host[instance]
  }
  printf "\n"
  # port
  printf "2%39s ","port:"
  for (instance in all_instance){
   printf "%-"all_instance[instance]"s ", all_instance_port[instance]
  }
  printf "\n"
  # instance
  printf "3%39s ","instance:"
  for (instance in all_instance){
   printf "%-"all_instance[instance]"s ", all_instance_instance[instance]
  }
  printf "\n"
  # stats
  printf "4%39s ","established/refused:"
  for (instance in all_instance){
   printf "%-"all_instance[instance]"s ", all_instance_stats[instance]
  }
  printf "\n"
  # header
  printf "5%39s ","---------------------------------------"
  for (instance in all_instance){
   printf "%-"all_instance[instance]"s ", substr("----------------------------------------",1,all_instance[instance])
  }
  printf "\n"
 # services
 for (service in all_service){
  printf "%-40s ",service
  for (instance in all_instance){
   if (all_service_instance[service,instance]!="") {
    printf "%-"all_instance[instance]"s ", all_service_instance[service,instance]
   } else {
    printf "%-"all_instance[instance]"s ", ""
   }
  }
  printf "\n"
 }
}' qq='"'| sort
}

function racstat() {

if [ $CRS_EXISTS -eq 1 ] ; then
${CRSCTL} stat res -f -w "(TYPE = ora.database.type)" | awk -F= '

function print_row() {
        dbbcol="";
        dbecol="";
        instbcol="";
        instecol="";
        instances=res["INSTANCE_COUNT 1"];
        for(i=1;i<=instances;i++) {
                # if at least one of the instances is open, all the db is open (then I paint it green)
                if (res["STATE_DETAILS " i] == "Open" ) {
                        dbbcol="\033[0;32m";
                        dbecol="\033[0m";
                }
                # if relocating, the new instance will have empty GEN_USR_ORA_INST_NAME
                # but "USR_ORA_INST_NAME" will be set to the new instance name
                # whereas the old instance name will have GEN_USR_ORA_INST_NAME set correctly for its duration
                if ( res["GEN_USR_ORA_INST_NAME " i] ) {
                        res["INSTANCE_NAME " i] = res["GEN_USR_ORA_INST_NAME " i];
                }
                else {
                        res["INSTANCE_NAME " i] = res["USR_ORA_INST_NAME " i];
                }
        }
        # db name does not change independently on the number of instances, so will always rely on instance 1
        if ( res["USR_ORA_DB_NAME 1"] ) {
                res["DB_NAME"] = res["USR_ORA_DB_NAME 1"];
        } else {
                res["DB_NAME"] = "";
        }
        #starting printing the first part of the information
        printf ("%s%-24s %-8s%s",dbbcol, res["DB_UNIQUE_NAME 1"], res["DB_NAME"], dbecol);
        # here, instance need to map to the correct server.
        # the mapping is node by attribute TARGET_SERVER (not last server)
        for ( n in node ) {
                node_name=node[n];
                srv_instance[node_name]="";
                for (i=1; i<=instances; i++) {
                        inst_name=res["INSTANCE_NAME " i];
                        # we are on the instance that matches the server
                        if (node_name == res["TARGET_SERVER " i]) {
                                res["SERVER_NAME " i]=node_name;
                                srv_instance[node_name]=inst_name;
                                # colors modes
                                if ( res["STATE " i] == "ONLINE" && res["INTERNAL_STATE " i] == "STABLE" ) {
                                        # online and stable: GREEN
                                        srv_instance[node_name]=sprintf("\033[0;32m%-14s\033[0m", srv_instance[node_name]);
                                }
                                else if ( res["STATE " i] != "ONLINE" && res["INTERNAL_STATE " i] == "STABLE" ) {
                                        # offline and stable
                                        if ( res["TARGET " i] == "OFFLINE" ) {
                                                # offline, stable, target offline: BLACK
                                                srv_instance[node_name]=sprintf("%-14s", srv_instance[node_name]);
                                        }
                                        else {
                                                # offline, stable, target online: RED
                                                srv_instance[node_name]=sprintf("\033[0;31m%-14s\033[0m", srv_instance[node_name]);
                                        }
                                }
                                else {
                                        # all other cases: offline and starting, online and stopping, clearning, etc.: YELLOW
                                        srv_instance[node_name]=sprintf("\033[0;33m%-14s\033[0m", srv_instance[node_name]);
                                }
                                #printf("%s %s %s %s\n", srv_instance[node_name], node[n], res["STATE " i], res["INTERNAL_STATE " i]);
                        }
                }
               printf(" %-14s", srv_instance[node_name]);
        }
		printf(" %-50s\n", res["ORACLE_HOME 1"]);
}
function pad (string, len, char) {
        ret = string;
        for ( i = length(string); i<len ; i++) {
                ret = sprintf("%s%s",ret,char);
        }
        return ret;
}
BEGIN {
        debug =0 ;
        first = 1;
        # this loop should set:
        # node[1]=server1; node[2]=server2; nodes=2;
        nodes=0;
        while ("olsnodes" | getline a) {
                nodes++;
                node[nodes] = a;
        }
        fmt="%-24s %-8s";
        printf (fmt, "DB_Unique_Name", "DB_Name");
        for ( n in node ) {
                printf (" %-14s", node[n]);
        }
        printf (" %-50s\n", "Oracle_Home");
        printf (fmt, pad("",24,"-"), pad("",8,"-"));
        for ( n in node ) {
                printf (" %s", pad("",14,"-"));
        }
		printf (" %s", pad("",50,"-"));
        printf ("\n");

}
# MAIN awk racstat
{
        if ( $1 == "NAME" ) {
                if ( first != 1 && res["NAME"] == $2 ) {
                        if ( debug == 1 ) print "Secondary instance";
                        instance++;
                }
                else {
                        if ( first != 1 ) {
                                print_row();
                        }
                        first = 0;
                        instance=1;
                        if ( debug == 1 ) print "Primary instance";
                        delete res;
                        res["NAME"] = $2;
                }
        }
        else  {
                res[$1 " " instance] = $2 ;
                if ( debug == 1 ) print $1;
                if ( debug == 1 ) print $1 " " instance;
                if ( debug == 1 ) print res[$1 " " instance];

        }
}
END {
        if ( debug == 1 ) for (key in res) { print key ": " res[key] }
        print_row();
}
'
else
        echo "racstat not available on non-clustered environments"
        false
fi

} # end of function cstat

function ora_prompt() {
        PSERR=$?
	F_colordef
	if [ "$ORACLE_HOME" == "$OH" ] ; then
		L_oraversion="\${G_ORAVERSION:-\"OH not set\"}${G_ORAEDITION:+" [$G_ORAEDITION]"}"
	else
		L_oraversion="Environment mismatch. Consider running setohenv."
	fi

        #PS1="\n# [ \u@\h:${colcyn}$PWD${colrst} [\\t] [${colylw}\${G_ORAVERSION:-\"OH not set\"}${G_ORAEDITION:+" [$G_ORAEDITION]"} SID=${coluylw}${ORACLE_SID:-\"not set\"}${colrst}] \$( if [[ \$PSERR -eq 0 ]]; then echo \"${colugrn}0${colrst}\" ; else echo \"${colured}\$PSERR${colrst}\";fi) ] #\\n# "
	if [ "$USER" == "root" ] ; then
        	PS1="\n# [ ${colred}\u@\h:${colcyn}$PWD${colrst} [\\t] [${colylw}$L_oraversion SID=${coluylw}${ORACLE_SID:-\"not set\"}${colrst}] \$( if [[ \$PSERR -eq 0 ]]; then echo \"${colugrn}0${colrst}\" ; else echo \"${colured}\$PSERR${colrst}\";fi) ] #\\n# "
	else
        	PS1="\n# [ \u@\h:${colcyn}$PWD${colrst} [\\t] [${colylw}$L_oraversion SID=${coluylw}${ORACLE_SID:-\"not set\"}${colrst}] \$( if [[ \$PSERR -eq 0 ]]; then echo \"${colugrn}0${colrst}\" ; else echo \"${colured}\$PSERR${colrst}\";fi) ] #\\n# "
	fi
}

function F_oraversion() {
	L_OH=${1:-$ORACLE_HOME}
	if [ $L_OH ] && [ -d $L_OH ] ; then
	
        	comp_file=$L_OH/inventory/ContentsXML/comps.xml
        	comp_xml=`grep "COMP NAME" $comp_file | head -1`
	
        	comp_name=`echo $comp_xml | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`
        	comp_vers=`echo $comp_xml | tr ' ' '\n' | grep ^VER= | awk -F\" '{print $2}'`
        	case $comp_name in
                	"oracle.crs")
                        	L_ORAVERSION=$comp_vers
				[[ -x $L_OH/bin/oraversion ]] &&	L_ORAVERSION=`$L_OH/bin/oraversion -compositeVersion`
                        	;;
			"oracle.sysman.top.agent"| "oracle.sysman.emagent.installer")
                        	L_ORAVERSION=$comp_vers
                        	;;
                	"oracle.server")
                        	L_ORAVERSION=`grep "PATCH NAME=\"oracle.server\"" $comp_file 2>/dev/null | tr ' ' '\n' | grep ^VER= | awk -F\" '{print $2}'`;
                        	if [ -z "$L_ORAVERSION" ]; then
                                	L_ORAVERSION=$comp_vers
                        	fi
				[[ -x $L_OH/bin/oraversion ]] &&	L_ORAVERSION=`$L_OH/bin/oraversion -compositeVersion`
                	;;
                	"oracle.client")
                        	L_ORAVERSION=$comp_vers
				[[ -x $L_OH/bin/oraversion ]] &&	L_ORAVERSION=`$L_OH/bin/oraversion -compositeVersion`
                        	;;
        	esac
		echo $L_ORAVERSION
	else
		echo "Cannot retreieve version"
		false
	fi
}


function F_oraedition() {
	L_OH=${1:-$ORACLE_HOME}
	if [ $L_OH ] && [ -d $L_OH ] ; then
	
        	comp_file=$L_OH/inventory/ContentsXML/comps.xml
        	comp_xml=`grep "COMP NAME" $comp_file | head -1`
	
        	comp_name=`echo $comp_xml | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`
        	comp_vers=`echo $comp_xml | tr ' ' '\n' | grep ^VER= | awk -F\" '{print $2}'`
        	case $comp_name in
                	"oracle.crs")
                        	L_ORAEDITION=GRID
                        	;;
			"oracle.sysman.top.agent"| "oracle.sysman.emagent.installer")
                        	L_ORAEDITION=AGT
                        	;;
                	"oracle.server")
				L_ORAEDITION="DBMS "`grep "oracle_install_db_InstallType" $L_OH/inventory/globalvariables/oracle.server/globalvariables.xml 2>/dev/null | tr ' ' '\n' | grep VALUE | awk -F\" '{print $2}'`
                		;;
                	"oracle.client")
                        	L_ORAEDITION=CLIENT
                        	;;
        	esac
	fi
	if [ "$L_ORAEDITION" ] ; then
		echo $L_ORAEDITION
	else
		echo "Cannot retreieve edition"
		false
	fi
}



tidy_dotora () {

# Heavily based on Jeremy Scheider's work:
# https://ardentperf.com/2008/11/28/parsing-listenerora-with-awk-and-sed/
#
# you can source this function in bash and use it like:
# cat $TNS_ADMIN/listener.ora | tidy_dotora 

awk '

# function for padding
function pad (string, len, char) {
	ret = string;
	for ( padi = length(string); padi<len ; padi++) {
			ret = sprintf("%s%s",ret,char);
	}
	return ret;
}
	
BEGIN {
	level=1;
	first=1;
	lastcomment=0;
}
	
{
#MAIN

	# just skip any comments and print as is
	if ($0 ~ "^[[:space:]]*#") {
		if (lastcomment==0) {
			printf("\n");
		}
		print;
		lastcomment=1;
		next;
	}
	lastcomment=0;

	# this puts every occurrence of =, ( and ) in different tokens
	gsub(/=/,"`=");
	gsub(/\(/,"`(");
	gsub(/\)/,"`)");
	split($0,tokens,"`");

	i=1; while(i in tokens) {

		# trim token and continue if empty
		gsub(/ /, "",tokens[i]);
		if(!tokens[i]) {i++; continue;}

		# got ( "open bracket": new level begins
		# increase the level, newline and pad
		if(tokens[i]~"^[(]") {
			level++;
			printf ("\n");
			printf (pad("", 2*level-1, " "));
		}
	
		# got ) "close bracket" : level ends
		# decrease the level but newline only if another one was closed immediately before
		if(tokens[i]~"^[)]") {
			level--;
			if (wentdown==1) {
				printf("\n");
				printf (pad("", 2*level+1, " "));
			}
			wentdown=1;
		} else {
			wentdown=0;
		}
	
		# if level==1 and is alphanumeric, it is a "TOP" entry (LISTENER, SID_LIST_LISTENER or property)
		# add extra line (and eventually track it for other usage)
		if(level==1 && i==1 && tokens[i]~"[A-Za-z]") {
			TOP=tokens[i];
			if (first==1) {
				first=0;
			} else {
				printf "\n\n";
			}
		}

		printf (tokens[i]);
		i++;
	}
}
END {
	# new line at the end of file
	printf("\n");
}' 
}



function lsoh() {
CENTRAL_ORAINV=`grep ^inventory_loc /etc/oraInst.loc 2>/dev/null | awk -F= '{print $2}'`
IFS='
'
echo
printf "%-27s %-55s %-12s %-9s\n" HOME LOCATION VERSION EDITION
echo --------------------------- ------------------------------------------------------- ------------ ---------
for line in `grep "<HOME NAME=" $CENTRAL_ORAINV/ContentsXML/inventory.xml | grep -v "REMOVED=\"T\"" 2>/dev/null` ; do

        L_OH=`echo $line | tr ' ' '\n' | grep ^LOC= | awk -F\" '{print $2}'`
        L_OH_NAME=`echo $line | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`
	L_ORAEDITION=`F_oraedition $L_OH`
	L_ORAVERSION=`F_oraversion $L_OH`
        printf "%-27s %-55s %-12s %-9s\n" $L_OH_NAME  $L_OH $L_ORAVERSION $L_ORAEDITION
done
echo
}


# given the current ORACLE_HOME, sets the additional environment variables (PATH, LD_LIBRARY_PATH, etc)
function setohenv() {
if [ -d "${ORACLE_HOME}" ] ; then
	unset G_ORAVERSION
	unset G_ORAEDITION

	G_ORAVERSION=`F_oraversion`
	G_ORAEDITION=`F_oraedition`
	export OH=$ORACLE_HOME
	export ORACLE_BASE=${ORACLE_BASE:-/u01/app/oracle}
	export ORACLE_HOME=$OH
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib
	export OH_NAME
	export G_ORAVERSION
	export G_ORAEDITION
	export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$DEFAULT_PATH
	echo "VERSION         = $G_ORAVERSION"
	echo "ORACLE_HOME     = $ORACLE_HOME"
else
	echo "ORACLE_HOME must be set prior to running setohenv function"
fi	
}

# setoh looks for a home with the specific name in the inventory, sets ORACLE_HOME and then calls setohenv to complete the environment
function setoh() {

SEARCH=${1:-"_foo_"}

CENTRAL_ORAINV=`grep ^inventory_loc /etc/oraInst.loc 2>/dev/null | awk -F= '{print $2}'`
IFS='
'

found=0

for line in `grep "<HOME NAME=" $CENTRAL_ORAINV/ContentsXML/inventory.xml 2>/dev/null` ; do

	if [ $found -eq 1 ] ; then
		continue
	fi
	OH=`echo $line | tr ' ' '\n' | grep ^LOC= | awk -F\" '{print $2}'`
	OH_NAME=`echo $line | tr ' ' '\n' | grep ^NAME= | awk -F\" '{print $2}'`

	if [ "$SEARCH" == "$OH_NAME" ] ; then
		found=1
		ORACLE_HOME=$OH
		setohenv
		continue
	fi
done
if [ $found -eq 0 ] ; then
    echo "cannot find Oracle Home $1"
	false
else
	true
fi

}

function isRACoh () {
	# params: either the full path ORACLE_HOME or none if ORACLE_HOME variable is already set
	# returns: Enabled if the oracle binary is RACi enabled, Disabled in any other cases
	OH2CHECK=${1:-$ORACLE_HOME}
	ar -t $OH2CHECK/rdbms/lib/libknlopt.a|grep kcsm.o >/dev/null
	if [ $? -eq 0 ] ; then
		echo "Enabled"
	else
		echo "Disabled"
		false
	fi
}

function F_colordef () {
	tty -s
	ISTTY=$?
	if [ $ISTTY -eq 0 ] ; then
	# tty is defined, using colors

        #######################################
        # define colors for bash candiness
        # colxxx = foreground plain
        # colbxxx = foreground bold
        # coluxxx = foreground underline
        # colbgxxx = background
        # blk=black grn=green ylw=yellow pur=purple cyn=cyan wht=white
        # They must be used with echo -e $colxxx
        colblk='\e[0;30m' # Black - Regular
        colred='\e[0;31m' # Red
        colgrn='\e[0;32m' # Green
        colylw='\e[0;33m' # Yellow
        colblu='\e[0;34m' # Blue
        colpur='\e[0;35m' # Purple
        colcyn='\e[0;36m' # Cyan
        colwht='\e[0;37m' # White
        colbblk='\e[1;30m' # Black - Bold
        colbred='\e[1;31m' # Red
        colbgrn='\e[1;32m' # Green
        colbylw='\e[1;33m' # Yellow
        colbblu='\e[1;34m' # Blue
        colbpur='\e[1;35m' # Purple
        colbcyn='\e[1;36m' # Cyan
        colbwht='\e[1;37m' # White
        colublk='\e[4;30m' # Black - Underline
        colured='\e[4;31m' # Red
        colugrn='\e[4;32m' # Green
        coluylw='\e[4;33m' # Yellow
        colublu='\e[4;34m' # Blue
        colupur='\e[4;35m' # Purple
        colucyn='\e[4;36m' # Cyan
        coluwht='\e[4;37m' # White
        colbgblk='\e[40m'   # Black - Background
        colbgred='\e[41m'   # Red
        colbggrn='\e[42m'   # Green
        colbgylw='\e[43m'   # Yellow
        colbgblu='\e[44m'   # Blue
        colbgpur='\e[45m'   # Purple
        colbgcyn='\e[46m'   # Cyan
        colbgwht='\e[47m'   # White
        colrst='\e[0m'    # Text Reset
	else
		#no tty used, no colors
	colblk=''
	colred=''
	colgrn=''
	colylw=''
	colblu=''
	colpur=''
	colcyn=''
	colwht=''
	colbblk=''
	colbred=''
	colbgrn=''
	colbylw=''
	colbblu=''
	colbpur=''
	colbcyn=''
	colbwht=''
	colublk=''
	colured=''
	colugrn=''
	coluylw=''
	colublu=''
	colupur=''
	colucyn=''
	coluwht=''
	colbgblk=''
	colbgred=''
	colbggrn=''
	colbgylw=''
	colbgblu=''
	colbgpur=''
	colbgcyn=''
	colbgwht=''
	colrst=''
	fi
}


function disp {
  fromhost=`who -m | cut -d\( -f2 | cut -d\) -f1`
  export DISPLAY=$fromhost:${1:-0}.0
  echo DISPLAY=$DISPLAY
}


function dus {
  du -sk * | sort -n
}

function pmon {
ps -ef |grep [p]mon 
}

function singlestat {
    for db in `ps -eaf | grep [p]mon_ | awk -Fmon_ '{print $NF}'`;
    do
        declare "pmon$db=UP";
    done;
    OLDIFS=$IFS;
    IFS="
";
    printf "%-13s %-8s %-50s\n" ORACLE_SID STATUS ORACLE_HOME;
    l_hostname=`hostname -s`;
    for dbline in `cat /etc/oratab | grep -v ^# | grep -v ^\$ `;
    do
        sid=`echo $dbline | awk -F: '{print $1}'`;
        oh=`echo $dbline | awk -F: '{print $2}'`;
        statvar=pmon$sid;
        status=${!statvar:-DOWN};
        if [ "$status" == "UP" ]; then
            statcolor=${colgrn};
        else
            statcolor=${colred};
        fi;
        printf "${statcolor}%-13s %-8s ${colrst}%-50s\n" $sid $status $oh;
    done;
    IFS=$OLDIFS
}

function single_dblist () {
    cat /etc/oratab | grep -v ^# | grep -v ^\$
}