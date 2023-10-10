recover database from service CDB196 noredo using compressed backupset;
srvctl stop database -d PDCP
srvctl start database -d PDCP -o nomount

rman target /
restore standby controlfile from service CDB196;
sql 'alter database mount';
Catalog start with '+PDCP_DATA';
Catalog start with '+PDCP_FRA';
-- Fixes the location
SWITCH DATABASE TO COPY;