set lines 300
SELECT name, pdb
FROM   v$services
ORDER BY name;