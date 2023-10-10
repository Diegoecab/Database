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