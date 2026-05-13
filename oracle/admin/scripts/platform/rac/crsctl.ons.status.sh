# ------------------------------------------------------------------------------
# File       : crsctl.ons.status.sh
# Purpose    : Oracle RAC or cluster administration helper: crsctl ons status.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./crsctl.ons.status.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
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
