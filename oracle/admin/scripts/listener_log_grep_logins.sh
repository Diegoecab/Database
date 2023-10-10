file=/oracle/diag/tnslsnr/dblxorainet01/listener_7366/trace/listener_7366.log
BASE=RIO29
FECHA=01-JUL-2021
HORA=18
cat $file|grep ^[0-9]|grep -v service_update|grep -v service_register|grep "$FECHA $HORA"|grep -v ping|awk '{print $1,$2}'|cut -d ":" -f 1,2|sort | uniq|while read ff
do
echo $ff " ----> " `cat $file|grep "$ff"|grep -i $BASE|grep 0$|wc -l`
done

