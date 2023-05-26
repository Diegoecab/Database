ls -lart >>  /tmp/lstxt
for p in $(cat /tmp/lstxt | grep "Feb  5 " | awk '{print $9}' | grep .aud); do cp $p ./feb5/.; done;
grep "ACTION:\[3\] \"102\"" -B3 * | grep APP_BACO_BIPLUS_ADMIN -B3 | grep "Feb  5"
