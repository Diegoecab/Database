
afdload start
You can use afdload to manually load or unload the Oracle ASM Filter Driver.
2021-02-26 14:16:13.331 [CLSECHO(34800)]AFD-0641: Checking for existing AFD installation.
2021-02-26 14:16:13.416 [CLSECHO(34811)]AFD-0643: Validating AFD installation files for operating system.
2021-02-26 14:16:13.452 [CLSECHO(34819)]AFD-9393: Verifying ASM administrator setup.
2021-02-26 14:16:13.499 [CLSECHO(34830)]AFD-0637: Loading installed AFD drivers.
2021-02-26 14:16:13.541 [CLSECHO(34838)]AFD-9154: Loading 'oracleafd.ko' driver.
2021-02-26 14:16:14.108 [CLSECHO(34895)]AFD-0649: Verifying AFD devices.
2021-02-26 14:16:14.151 [CLSECHO(34903)]AFD-9156: Detecting control device '/dev/oracleafd/admin'.
2021-02-26 14:16:15.406 [CLSECHO(35861)]AFD-9294: updating file /etc/sysconfig/oracledrivers.conf
2021-02-26 14:16:15.448 [CLSECHO(35869)]AFD-9322: completed


cd /dev/oracleafd/disks


$ $ORACLE_HOME/bin/asmcmd afd_state





asmcmd afd_lsdsk


asmcmd afd_configure


asmcmd afd_state
 asmcmd afd_dsset '/dev/ORA_*'
 asmcmd afd_label "ORA_RIO257D_D_01" /dev/ORA_RIO257D_D_01
 asmcmd afd_scan
 asmcmd afd_lsdsk
 crsctl modify resource ora.driver.afd -attr "ACL='owner:grid:rwx,pgrp:oinstall:r-x,other::r--,user:grid:r-x' " -init
 crsctl get resource ora.driver.afd
