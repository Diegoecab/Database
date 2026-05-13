# ------------------------------------------------------------------------------
# File       : slavestatus.sh
# Purpose    : mysql replication helper: slavestatus.
# Engine     : mysql
# Category   : replication
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./slavestatus.sh
# Parameters : SBM, arg2
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
mysql --defaults-file=/home/mysql/mysql.login << eof > slave_status.log
show slave status\G
exit
eof

#grep "Seconds_Behind_Master: 0" slave_status.log
SBM=`grep Seconds_Behind_Master slave_status.log|awk '{print $2}'`
echo Seconds_Behind_Master=$SBM
#if [ $? -ge 1 ]; then
if [ $SBM -ge 1800 ]; then
        echo "rgopdbp1505 slave status Seconds_Behind_Master=$SBM" | mail -s "rgopdbp1505 slave status Seconds_Behind_Master=$SBM" -r mysql@rgopdbp1505 dbaoracle@directvla.com.ar < slave_status.log
fi
# logs en /var/lib/mysql/