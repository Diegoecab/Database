#!/bin/ksh
for i in `/etc/init.d/oracleasm listdisks`
do
v_asmdisk=`/etc/init.d/oracleasm querydisk -d $i | awk  '{print $2}'`
v_minor=`/etc/init.d/oracleasm querydisk -d $i | awk -F[ '{print $2}'| awk -F] '{print $1}' | awk '{print $1}'`
v_major=`/etc/init.d/oracleasm querydisk -d $i | awk -F[ '{print $2}'| awk -F] '{print $1}' | awk '{print $2}'`
v_device=`ls -la /dev | grep $v_minor | grep $v_major | awk '{print $10}'`
echo "ASM disk $v_asmdisk based on /dev/$v_device  [$v_minor $v_major]"
done




[grid@dtvqaora1 ~]$ ./querydisks.sh
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "DBSPI01" based on /dev/  [8,49 ]

Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA01" based on /dev/  [8,65 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA02" based on /dev/  [8,81 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA03" based on /dev/  [8,97 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA04" based on /dev/  [8,113 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA05" based on /dev/  [8,129 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA06" based on /dev/  [8,145 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA07" based on /dev/  [8,193 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMFRA01" based on /dev/  [8,161 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMFRA02" based on /dev/  [8,177 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "QAASMDATA07" based on /dev/  [8,17 ]

Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "QAASMDOCR" based on /dev/  [8,209 ]




QAASMDATA07
brw-r----- 1 root disk 8,  17 Nov  7 10:26 /dev/sdb1
DBSPI01
brw-r----- 1 root disk 8,  49 Nov  7 10:26 /dev/sdd1




[grid@dtvqaora2 ~]$ ./querydisks.sh
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA01" based on /dev/  [8,17 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA02" based on /dev/  [8,33 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA03" based on /dev/  [8,49 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA04" based on /dev/  [8,65 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA05" based on /dev/  [8,81 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA06" based on /dev/  [8,97 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMDATA07" based on /dev/  [8,145 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMFRA01" based on /dev/  [8,113 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "IBSASMFRA02" based on /dev/  [8,129 ]
Usage: grep [OPTION]... PATTERN [FILE]...
Try `grep --help' for more information.
ASM disk "QAASMDOCR" based on /dev/  [8,161 ]





brw-r----- 1 root disk 8,  17 Oct 12 16:08 /dev/sdb1
brw-r----- 1 root disk 8,  49 Oct 12 16:08 /dev/sdd1





[grid@dtvqaora2 ~]$ ls -ltr /dev/sd*

brw-r----- 1 root disk 8, 160 Oct 12 16:07 /dev/sdk
brw-r----- 1 root disk 8, 144 Oct 12 16:07 /dev/sdj
brw-r----- 1 root disk 8, 128 Oct 12 16:07 /dev/sdi
brw-r----- 1 root disk 8, 112 Oct 12 16:07 /dev/sdh
brw-r----- 1 root disk 8,  96 Oct 12 16:07 /dev/sdg
brw-r----- 1 root disk 8,  80 Oct 12 16:07 /dev/sdf
brw-r----- 1 root disk 8,  64 Oct 12 16:07 /dev/sde
brw-r----- 1 root disk 8,  48 Oct 12 16:07 /dev/sdd
brw-r----- 1 root disk 8,  32 Oct 12 16:07 /dev/sdc
brw-r----- 1 root disk 8,  16 Oct 12 16:07 /dev/sdb
brw-r----- 1 root disk 8,   3 Oct 12 16:07 /dev/sda3
brw-r----- 1 root disk 8,   2 Oct 12 16:07 /dev/sda2
brw-r----- 1 root disk 8,   0 Oct 12 16:07 /dev/sda
brw-r----- 1 root disk 8,   1 Oct 12 16:07 /dev/sda1
brw-r----- 1 root disk 8,  17 Oct 12 16:08 /dev/sdb1
brw-r----- 1 root disk 8,  33 Oct 12 16:08 /dev/sdc1
brw-r----- 1 root disk 8,  49 Oct 12 16:08 /dev/sdd1
brw-r----- 1 root disk 8,  65 Oct 12 16:08 /dev/sde1
brw-r----- 1 root disk 8,  81 Oct 12 16:08 /dev/sdf1
brw-r----- 1 root disk 8,  97 Oct 12 16:08 /dev/sdg1
brw-r----- 1 root disk 8, 113 Oct 12 16:08 /dev/sdh1
brw-r----- 1 root disk 8, 129 Oct 12 16:08 /dev/sdi1
brw-r----- 1 root disk 8, 145 Oct 12 16:08 /dev/sdj1
brw-r----- 1 root disk 8, 161 Oct 12 16:08 /dev/sdk1

Discos en dtvqaora2:

Disk /dev/sda: 204.0 GB, 204010946560 bytes
Disk /dev/sdb: 536.8 GB, 536870912000 bytes
Disk /dev/sdc: 536.8 GB, 536870912000 bytes
Disk /dev/sdd: 536.8 GB, 536870912000 bytes
Disk /dev/sde: 536.8 GB, 536870912000 bytes
Disk /dev/sdf: 536.8 GB, 536870912000 bytes
Disk /dev/sdg: 536.8 GB, 536870912000 bytes
Disk /dev/sdh: 322.1 GB, 322122547200 bytes
Disk /dev/sdi: 322.1 GB, 322122547200 bytes
Disk /dev/sdj: 536.8 GB, 536870912000 bytes
Disk /dev/sdk: 5368 MB, 5368709120 bytes






[grid@dtvqaora1 ~]$ ls -ltr /dev/sd*
brw-r----- 1 root disk 8, 208 Nov  7 10:25 /dev/sdn
brw-r----- 1 root disk 8, 192 Nov  7 10:25 /dev/sdm
brw-r----- 1 root disk 8, 176 Nov  7 10:25 /dev/sdl
brw-r----- 1 root disk 8, 160 Nov  7 10:25 /dev/sdk
brw-r----- 1 root disk 8, 144 Nov  7 10:25 /dev/sdj
brw-r----- 1 root disk 8, 128 Nov  7 10:25 /dev/sdi
brw-r----- 1 root disk 8, 112 Nov  7 10:25 /dev/sdh
brw-r----- 1 root disk 8,  96 Nov  7 10:25 /dev/sdg
brw-r----- 1 root disk 8,  80 Nov  7 10:25 /dev/sdf
brw-r----- 1 root disk 8,  64 Nov  7 10:25 /dev/sde
brw-r----- 1 root disk 8,  48 Nov  7 10:25 /dev/sdd
brw-r----- 1 root disk 8,  33 Nov  7 10:25 /dev/sdc1
brw-r----- 1 root disk 8,  32 Nov  7 10:25 /dev/sdc
brw-r----- 1 root disk 8,  16 Nov  7 10:25 /dev/sdb
brw-r----- 1 root disk 8,   3 Nov  7 10:25 /dev/sda3
brw-r----- 1 root disk 8,   2 Nov  7 10:25 /dev/sda2
brw-r----- 1 root disk 8,   0 Nov  7 10:25 /dev/sda
brw-r----- 1 root disk 8,   1 Nov  7 10:26 /dev/sda1
brw-r----- 1 root disk 8,  17 Nov  7 10:26 /dev/sdb1
brw-r----- 1 root disk 8,  49 Nov  7 10:26 /dev/sdd1
brw-r----- 1 root disk 8,  65 Nov  7 10:26 /dev/sde1
brw-r----- 1 root disk 8,  97 Nov  7 10:26 /dev/sdg1
brw-r----- 1 root disk 8,  81 Nov  7 10:26 /dev/sdf1
brw-r----- 1 root disk 8, 129 Nov  7 10:26 /dev/sdi1
brw-r----- 1 root disk 8, 161 Nov  7 10:26 /dev/sdk1
brw-r----- 1 root disk 8, 113 Nov  7 10:26 /dev/sdh1
brw-r----- 1 root disk 8, 177 Nov  7 10:26 /dev/sdl1 *
brw-r----- 1 root disk 8, 145 Nov  7 10:26 /dev/sdj1
brw-r----- 1 root disk 8, 209 Nov  7 10:26 /dev/sdn1 *
brw-r----- 1 root disk 8, 193 Nov  7 10:26 /dev/sdm1 *



Discos en dtvqaora1:

Disk /dev/sda: 204.0 GB, 204010946560 bytes
Disk /dev/sdb: 53.6 GB, 53687091200 bytes (QAASMDATA07)
Disk /dev/sdc: 1099.5 GB, 1099511627776 bytes
Disk /dev/sdd: 107.3 GB, 107374182400 bytes (DBSPI01)
Disk /dev/sde: 536.8 GB, 536870912000 bytes
Disk /dev/sdf: 536.8 GB, 536870912000 bytes
Disk /dev/sdg: 536.8 GB, 536870912000 bytes
Disk /dev/sdh: 536.8 GB, 536870912000 bytes
Disk /dev/sdi: 536.8 GB, 536870912000 bytes
Disk /dev/sdj: 536.8 GB, 536870912000 bytes
Disk /dev/sdk: 322.1 GB, 322122547200 bytes
Disk /dev/sdl: 322.1 GB, 322122547200 bytes
Disk /dev/sdm: 536.8 GB, 536870912000 bytes
Disk /dev/sdn: 5368 MB, 5368709120 bytes
