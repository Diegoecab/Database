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