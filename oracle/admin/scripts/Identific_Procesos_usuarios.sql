/*Select para determinar el usuario que consume mas recursos. Hay que filtrar la busqueda por el numero de A.SPID*/
SELECT a.spid PROCESO_EN_SERVER, b.username USUARIO, b.SID, b.status ESTADO, b.machine, b.terminal, b.osuser
  FROM v$session b RIGHT JOIN v$process a ON a.addr = b.paddr


/*Procesos sin identificador de usuarios */
SELECT spid FROM v$process WHERE NOT EXISTS ( SELECT 1 FROM v$session WHERE paddr = addr); 
