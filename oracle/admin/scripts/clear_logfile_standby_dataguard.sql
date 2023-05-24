select GROUP# from v$logfile where TYPE='STANDBY' group by GROUP#;

ALTER DATABASE CLEAR LOGFILE GROUP   15;