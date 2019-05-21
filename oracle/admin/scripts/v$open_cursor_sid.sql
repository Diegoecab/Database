rem v$open_cursor_sid.sql
col sql_text for a60
col user_name for a10

accept SID prompt 'Ingrese SID:  '

SELECT o.sql_text, o.address, o.sql_id, o.hash_value, o.user_name, s.schemaname
  FROM v$open_cursor o, v$session s
 WHERE o.saddr = s.saddr AND o.SID = s.SID AND (o.SID = '&SID')
 /