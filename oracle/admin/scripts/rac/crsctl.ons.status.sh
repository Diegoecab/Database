[grid@rdp3dbadm02 ~]$ crsctl stat res ora.ons -t
--------------------------------------------------------------------------------
Name           Target  State        Server                   State details
--------------------------------------------------------------------------------
Local Resources
--------------------------------------------------------------------------------
ora.ons
               ONLINE  ONLINE       rdp3dbadm01              STABLE
               ONLINE  ONLINE       rdp3dbadm02              STABLE
--------------------------------------------------------------------------------
[grid@rdp3dbadm02 ~]$ cat $ORACLE_HOME/opmn/conf/ons.config
usesharedinstall=true
allowgroup=true
localport=6100          # line added by Agent
remoteport=6200         # line added by Agent
nodes=rdp3dbadm01:6200,rdp3dbadm02:6200         # line added by Agent
[grid@rdp3dbadm02 ~]$ $ORACLE_HOME/opmn/bin/onsctli ping
ons is running ...
[grid@rdp3dbadm02 ~]$
