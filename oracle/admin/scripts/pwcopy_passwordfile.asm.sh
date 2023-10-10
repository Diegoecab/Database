su – grid
grid@prod02:~$ asmcmd
ASMCMD> cd +DATA_DG/PROD/PASSWORD
ASMCMD> ls -l
Type Redund Striped Time Sys Name
PASSWORD HIGH COARSE JAN 15 2017 N pwdPROD => +DATA_DG/PROD/PASSWORD/pwdPROD.872.933349975
PASSWORD HIGH COARSE JAN 15 2017 Y pwdPROD.872.933349975
ASMCMD> pwcopy pwdPROD.872.933349975 /tmp/orapwPRODdr1
copying +DATA_USG/PROD/PASSWORD/pwdPROD.872.933349975 -> /tmp/orapwPRODdr1

grid@monetadb02:~$ ls -l /tmp/orapwPRODdr1
-rw-r—– 1 grid oinstall 7680 Aug 30 12:30 /tmp/orapwPRODdr1