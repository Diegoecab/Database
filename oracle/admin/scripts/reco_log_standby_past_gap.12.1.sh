awk '
BEGIN {
print "set linesize 200 pagesize 1000"
print "column completion_time format a32"
print "column applied_time format a38"
print "column gap format a30"
s="with a as("
}
/^[A-Z][a-z][a-z] [A-Z][a-z][a-z] / {
ts=$0
}
/Media Recovery Log/{
print s" select cast (to_date(" q ts q "," q "DY MON DD HH24:MI:SS YYYY" q ") as timestamp)applied_time,"q $NF q " name from dual "
s=" union all"
}
END{
print ") select thread#,sequence#,cast(completion_time as timestamp) completion_time,applied_time,applied_time-completion_time gap"
print " from a join v$archived_log using(name) order by completion_time, applied_time;"
}
' q="'" /u01/app/oracle/diag/rdbms/ibscn/ibscn1/trace/alert_ibscn1.log >> check_gap.sql