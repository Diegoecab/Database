asmcmd afd_lsdsk

--------------------------------------------------------------------------------
Label                     Filtering   Path
================================================================================
ORA_DATA_01                 ENABLED   /dev/sdc1
ORA_DATA_02                 ENABLED   /dev/sdd1
ORA_FRA_01                  ENABLED   /dev/sde1


asmcmd afd_unlabel /dev/sdc1
asmcmd afd_unlabel /dev/sdd1
asmcmd afd_unlabel /dev/sde1