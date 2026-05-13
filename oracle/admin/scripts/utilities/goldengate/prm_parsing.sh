# ------------------------------------------------------------------------------
# File       : prm_parsing.sh
# Purpose    : Oracle administration helper: prm parsing.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./prm_parsing.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
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