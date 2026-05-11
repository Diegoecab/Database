#!/bin/bash
# ------------------------------------------------------------------------------
# File       : asmdu.sh
# Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asmdu(1).
# Category   : storage
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./asmdu(1).sh
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
#
# du of each subdirectory in a directory for ASM
#
D=$1

if [[ -z $D ]]
then
 echo "Please provide a directory !"
 exit 1
fi

(for DIR in `asmcmd ls ${D}`
 do
     echo ${DIR} `asmcmd du ${D}/${DIR} | tail -1`
 done) | awk -v D="$D" ' BEGIN {  printf("\n\t\t%40s\n\n", D " subdirectories size")           ;
                                  printf("%25s%16s%16s\n", "Subdir", "Used MB", "Mirror MB")   ;
                                  printf("%25s%16s%16s\n", "------", "-------", "---------")   ;}
                               {
                                  printf("%25s%16s%16s\n", $1, $2, $3)                         ;
                                  use += $2                                                    ;
                                  mir += $3                                                    ;
                               }
                         END   { printf("\n\n%25s%16s%16s\n", "------", "-------", "---------");
                                 printf("%25s%16s%16s\n\n", "Total", use, mir)                 ;} '
