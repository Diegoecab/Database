echo "hostname|ip|Agent processes|Status Agent|Telnet" > /tmp/test/output.txt


comandos.sh:
host=$(hostname | sed 's/.dtvpan.com//g' | sed 's/.dtvdev.net//g' | tr '\n' ' ')
ip=$(hostname -I | awk '{print $1}')
ps=$(ps -ef | grep oemagent | grep -v grep| wc -l)
ag=$(su -c "/opt/oracle/oemagentdtv/agent_13.3.0.0.0/bin/emctl status agent | grep -i \"agent is\"" oemagent ) 2>/dev/null
cr=$(su -c "curl -m 3 -v telnet://oem.dtvpan.com:4900 </dev/null 2>&1" oemagent )
cr=$(echo $cr|grep Connected|wc -l)
echo "$host|$ip|$ps|$ag|$cr"

hosts.txt: lista completa de IP/hostnames a los cuales conectar


for i in `cat hosts.txt` ; do
sudo ssh -t $i < comandos.sh >> /tmp/test/output.txt 2>/dev/null
done