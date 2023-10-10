ORASID=326D
grep -i $ORASID listener_5321.log| grep -v telegraf| grep -v `hostname` | grep -v `hostname -I | awk '{print $1}'` | grep establish| grep -oP '(?<=USER=)\w+'| sort | uniq -c | sort -nr
grep -i $ORASID listener_5321.log| grep -v telegraf| grep -v `hostname` | grep -v `hostname -I | awk '{print $1}'` | grep establish| grep -oP '(?<=HOST=)\w+'| sort | uniq -c | sort -nr
grep -i $ORASID listener_5321.log| grep -v telegraf| grep -v `hostname` | grep -v `hostname -I | awk '{print $1}'` | grep establish| grep -oP '(?<=PROGRAM=)\w+'| sort | uniq -c | sort -nr