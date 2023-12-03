grep -Ri "Archived Log entry " -B1 --no-file|grep 2023-10-24 |sed 's/2023-10-24T//g' | uniq -w2 -c
grep "Media Recovery Log" * -B1 --no-file | grep 2023-10-24|sed 's/2023-10-24T//g' | uniq -w5 -c
