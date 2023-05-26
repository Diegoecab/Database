grep -E "Completed:.* until change" /u01/app/oracle/diag/rdbms/ibscn/ibscn2/trace/alert_ibscn2.log -A1 | grep -v Completed | awk '{print $2" " $3" " $4}'

grep -P '^(?=.*RFS)(?=.*18023)' alert_ibscn2.log