

alter system set undo_tablespace='UNDOTBS1' sid='d1cn1' scope=spfile;
alter system set undo_tablespace='UNDOTBS2' sid='d1cn2' scope=spfile;
alter system set thread=1 scope=spfile sid='d1cn1';
alter system set thread=2 scope=spfile sid='d1cn2';
alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.163.120)(PORT=1521))' sid='d1cn1' scope=spfile;
alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.163.121)(PORT=1521))' sid='d1cn2' scope=spfile;

alter system set cluster_database=true scope=spfile sid='*';
alter system set instance_number=1 scope=spfile sid='d1cn1';
alter system set instance_number=2 scope=spfile sid='d1cn2';



srvctl add database -d PROD -o /u01/app/oracle/product/11.2.0/db_1 -c RAC -a "DATA,FRA" -p +DATA/PROD/spfilePROD.ora

srvctl add instance -d PROD -i PROD1 -n kiwi21

srvctl add instance -d PROD -i PROD2 -n kiwi22

srvctl config database -d PROD

The standby cluster can now for example be started with:

srvctl start database -d PROD -o mount