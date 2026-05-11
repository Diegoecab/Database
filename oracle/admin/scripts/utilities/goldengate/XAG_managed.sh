# ------------------------------------------------------------------------------
# File       : XAG_managed.sh
# Purpose    : Oracle administration helper: XAG managed.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./XAG_managed.sh
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
[grid@rgmadbp1752 ~]$ agctl status goldengate
Goldengate  instance 'GG_CS' is running on rgmadbp1752
Goldengate  instance 'GG_RGSBP1X' is running on rgmadbp1752
[grid@rgmadbp1752 ~]$


To start Oracle GoldenGate manager, and all processes that have autostart enabled:
% agctl start goldengate GG_Target --node nshb01gg06

[grid@rgmadbp1752 ~]$  agctl config goldengate GG_RGSBP1X
GoldenGate location is: /u01/app/oracle/product/gg_12201
GoldenGate instance type is: target
Configured to run on Nodes: rgmadbp1751 rgmadbp1752
ORACLE_HOME location is: /u01/app/oracle/product/11.2.0.4/dbhome_1
Databases needed: ora.rgsbp1xs.db
File System resources needed: ora.fra.advm_ggate.acfs
Extracts to monitor:
Replicats to monitor:
Critical extracts:
Critical replicats:
Autostart on DataGuard role transition to PRIMARY: no
Autostart JAgent: no
[grid@rgmadbp1752 ~]$
