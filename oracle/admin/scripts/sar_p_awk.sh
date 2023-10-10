sar -p -d 15 4320
tail -f sar_p_d_18H.txt | awk '{ if ($11 > 80.00) { print } }'