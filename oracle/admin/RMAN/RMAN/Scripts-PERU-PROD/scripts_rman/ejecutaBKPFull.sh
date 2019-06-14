export ORACLE_SID=GEMPROD;
rm /gemini/DbBackup/GEMPROD/rman/logs/rman_log.log
rman target / @/home/oragemprod/scripts_rman/full.sql
