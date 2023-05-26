grep "^MAP" /u01/app/oracle/product/gg_18c_bi/dirprm/pered1b.prm | grep -oP '(?<=TARGET )[^ ]*' |sed 's/;//g'



for d in $(ps -ef | grep [\.]\/mgr | awk '{print $10}' | sed 's/\/mgr\.prm//'); do
echo $d
cd $d;
for f in $(ls *.prm | grep -v "jagent.prm" | grep -v "mgr.prm"); do
echo $f": "
grep "^MAP" $f | grep -oP '(?<=TARGET )[^ ]*' |sed 's/;//g'
done
done

find /u01/app/oracle/product/gg_18c_bi/dirprm/ -name *.prm -exec grep "^MAP" {} | grep -oP '(?<=TARGET )[^ ]*' |sed 's/;//g' \;