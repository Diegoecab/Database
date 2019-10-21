#!/bin/sh

#
# Generated on Wed Sep 25 15:38:02 CDT 2019
# Start of user configurable variables
#
LANG=C
export LANG

#Trap to cleanup cookie file in case of unexpected exits.
trap 'rm -f $COOKIE_FILE; exit 1' 1 2 3 6 

# SSO username 
printf 'SSO User Name:' 
read SSO_USERNAME

# Path to wget command
WGET=/usr/bin/wget

# Log directory and file
LOGDIR=.
LOGFILE=$LOGDIR/wgetlog-$(date +%m-%d-%y-%H:%M).log

# Print wget version info 
echo "Wget version info: 
------------------------------
$($WGET -V) 
------------------------------" > "$LOGFILE" 2>&1 

# Location of cookie file 
COOKIE_FILE=$(mktemp -t wget_sh_XXXXXX) >> "$LOGFILE" 2>&1 
if [ $? -ne 0 ] || [ -z "$COOKIE_FILE" ] 
then 
 echo "Temporary cookie file creation failed. See $LOGFILE for more details." |  tee -a "$LOGFILE" 
 exit 1 
fi 
echo "Created temporary cookie file $COOKIE_FILE" >> "$LOGFILE" 

# Output directory and file
OUTPUT_DIR=.
#
# End of user configurable variable
#

# The following command to authenticate uses HTTPS. This will work only if the wget in the environment
# where this script will be executed was compiled with OpenSSL.
# 
 $WGET  --secure-protocol=auto --save-cookies="$COOKIE_FILE" --keep-session-cookies --http-user "$SSO_USERNAME" --ask-password  "https://edelivery.oracle.com/osdc/cliauth" -O /dev/null 2>> "$LOGFILE"

# Verify if authentication is successful 
if [ $? -ne 0 ] 
then 
 echo "Authentication failed with the given credentials." | tee -a "$LOGFILE"
 echo "Please check logfile: $LOGFILE for more details." 
else
 echo "Authentication is successful. Proceeding with downloads..." >> "$LOGFILE" 
 $WGET --load-cookies="$COOKIE_FILE" "https://edelivery.oracle.com/osdc/softwareDownload?fileName=V978971-01.zip&token=UzV5YWo4SWpFTDV3cTM1VmZKQ3lpUSE6OiFmaWxlSWQ9MTAxMTYxNTk1JmZpbGVTZXRDaWQ9ODc4Nzk5JnJlbGVhc2VDaWRzPTg1NjczMyZwbGF0Zm9ybUNpZHM9MzUmZG93bmxvYWRUeXBlPTk1NzYxJmFncmVlbWVudElkPTU4OTk0MjMmZW1haWxBZGRyZXNzPWRjYWJyZXJhQGRhdGFzdGFyLmNvbS5hciZ1c2VyTmFtZT1FUEQtRENBQlJFUkFAREFUQVNUQVIuQ09NLkFSJmlwQWRkcmVzcz0xOTAuMjEwLjIyOC4xMjEmdXNlckFnZW50PU1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS83Ni4wLjM4MDkuMTAwIFNhZmFyaS81MzcuMzYmY291bnRyeUNvZGU9QVI" -O "$OUTPUT_DIR/V978971-01.zip" >> "$LOGFILE" 2>&1 
fi 

# Cleanup
rm -f "$COOKIE_FILE" 
echo "Removed temporary cookie file $COOKIE_FILE" >> "$LOGFILE" 

