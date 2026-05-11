#!/bin/bash
# ------------------------------------------------------------------------------
# File       : cellash.sh
# Purpose    : Oracle Exadata administration helper: cellash.
# Category   : platform/exadata
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./cellash.sh
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

CMD="LIST ACTIVEREQUEST ATTRIBUTES name,asmDiskGroupNumber,asmFileIncarnation,asmFileNumber\
          ,consumerGroupID,consumerGroupName,dbID,dbName,dbRequestID,fileType,id,instanceNumber\
          ,ioBytes,ioBytesSofar,ioGridDisk,ioOffset,ioReason,ioType,objectNumber,parentID\
          ,requestState,sessionID,sessionSerNumber,sqlID,tableSpaceNumber"

CMD2="LIST ACTIVEREQUEST DETAIL"

echo set echo on

while true ; do
    echo REM TIME `date +"%Y-%m-%d %H:%M:%S"`
    echo $CMD2
    sleep 1
done
