define serv_name='srv_RIO57_ap'
COLUMN name FORMAT A30
COLUMN network_name FORMAT A30

SELECT name,
       network_name
FROM   dba_services where name='&serv_name'
ORDER BY 1;

BEGIN
  DBMS_SERVICE.create_service(
    service_name => '&serv_name',
    network_name => '&serv_name'
  );
END;
/


SELECT name,
       network_name
FROM   dba_services
ORDER BY 1;

SELECT name,
       network_name
FROM   v$active_services
ORDER BY 1;

BEGIN
  DBMS_SERVICE.start_service(
    service_name => '&serv_name'
  );
END;
/


SELECT name,
       network_name
FROM   v$active_services
ORDER BY 1;