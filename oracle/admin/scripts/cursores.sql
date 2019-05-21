/*Para ver la cantidad de cursores abiertos de cada usuario*/
SELECT s.*, n.name
FROM v$sesstat s, v$statname n
WHERE s.statistic# = n.statistic#
and name = 'opened cursors current'
and sid = &sid ; 


/*Ver los cursores abiertos de todos los usuarios con el texto sql*/

SELECT /*+ RULE */
       a.VALUE cantidad_cursores_cache, a.username usuario, a.SID,
       c.hash_value, c.sql_text
  FROM (SELECT   a.VALUE, s.username, s.SID, s.serial#
            FROM v$sesstat a, v$statname b, v$session s
           WHERE a.statistic# = b.statistic#
             AND s.SID = a.SID
             AND b.NAME = 'opened cursors current'
        ORDER BY VALUE DESC) a
       JOIN
       (SELECT   o.SID, o.sql_text, o.address, o.hash_value,
                 s.schemaname esquema, s.sql_hash_value
            FROM v$open_cursor o, v$session s
           WHERE o.saddr = s.saddr AND o.SID = s.SID
        ORDER BY o.SID, s.schemaname, o.hash_value) b ON b.SID = a.SID
       JOIN
       (SELECT   sql_text, hash_value
            FROM v$sqltext_with_newlines
        ORDER BY hash_value, piece) c
       ON c.hash_value = b.hash_value AND a.username IS NOT NULL


/*Ver los cursores abiertos de todos los usuarios con la cab del texto sql*/


SELECT a.VALUE cantidad_cursores_cache, a.username usuario, a.SID, b.sql_text
  FROM (SELECT   a.VALUE, s.username, s.SID, s.serial#
            FROM v$sesstat a, v$statname b, v$session s
           WHERE a.statistic# = b.statistic#
             AND s.SID = a.SID
             AND b.NAME = 'opened cursors current'
        ORDER BY VALUE DESC) a
       JOIN
       (SELECT o.SID, o.sql_text, o.address, o.hash_value,
               s.schemaname esquema, s.sql_hash_value
          FROM v$open_cursor o, v$session s
         WHERE o.saddr = s.saddr AND o.SID = s.SID) b
       ON a.SID = b.SID AND a.username IS NOT NULL