awk '
BEGIN {
 print "set linesize 200 pagesize 1000"
 print "column completion_time format a32"
 print "column applied_time format a38"
 print "column gap format a30"
 s="with a as("
}
/^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]T[0-9][0-9]:[0-9][0-9]:[0-9][0-9][.][0-9]*[+][0-9]*:[0-9]*/ {
 sub(/T/," ");ts=$0
}
/Media Recovery Log/{
 print s" select timestamp" q ts q "applied_time,"q $NF q "name from dual "
 s=" union all"
}
END{
 print ") select thread#,sequence#,cast(completion_time as timestamp) completion_time,applied_time,applied_time-completion_time gap"
 print " from a right outer join v$archived_log using(name) order by completion_time, applied_time;"
}
' q="'" alert.log >> test.sql