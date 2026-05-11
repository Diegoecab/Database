# ------------------------------------------------------------------------------
# File       : asm_adddisk_asmlib.sh
# Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm adddisk asmlib(1).
# Category   : storage
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./asm_adddisk_asmlib(1).sh
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
/usr/sbin/oracleasm listdisks

/usr/sbin/oracleasm scandisk

con root:

crear disco (una vez el system nos de el path)

/usr/sbin/oracleasm createdisk DATA013 /dev/mapper/DATA2T016p1


Con grid:


$HOME/asmdu2.sh

Validar que está el nuevo disco:
[grid@rgmadbp1752 ~]$ $ORACLE_HOME/bin/kfod asm_diskstring='ORCL:*' disks=all

Agregarlo al ASM	   
ALTER DISKGROUP DATA ADD DISK
      'ORCL:DATA013' size 2097152M
       REBALANCE POWER 4;
	   
select name, header_status from v$asm_disk;
	 
$HOME/asmdu2.sh