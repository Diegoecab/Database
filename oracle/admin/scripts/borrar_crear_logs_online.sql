
ALTER DATABASE DROP LOGFILE GROUP 1
commit;

--Borrar archivo LOG del SO

ALTER DATABASE ADD LOGFILE GROUP 1
 ('/u01/app/oracle/oradata/oratest/redo01.log','/u01/app/oracle/oradata/oratest/redo01_2.log')
 SIZE 100M;


ALTER DATABASE ADD LOGFILE MEMBER '/oracle/dbs/log2b.rdo' TO GROUP 2;