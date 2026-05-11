# ------------------------------------------------------------------------------
# File       : reco_log_standby_past_gap.12.1.sh
# Purpose    : Oracle Data Guard administration helper: reco log standby past gap 12 1(1).
# Category   : backup_recovery/dataguard
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./reco_log_standby_past_gap.12.1(1).sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : REVIEW
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
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