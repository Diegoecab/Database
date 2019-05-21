SELECT 
  decode (px.qcinst_id,
  null,
  username,
  ' - '||lower(substr(s.program,
  length(s.program)-4,
  4) ) ) "Username",
  decode(px.qcinst_id,
  null,
  'QC',
  '(Slave)') "QC/Slave",
  to_char(px.server_set) "Slave Set",
  to_char(s.sid) "SID",
  decode(px.qcinst_id,
  null,
  to_char(s.sid),
  px.qcsid) "QC SID",
  px.req_degree "Requested DOP",
  px.degree "Actual DOP"
FROM 
  v$px_session px,
  v$session s
WHERE 
  px.sid=s.sid(+)  and
  px.serial#=s.serial#   
  order by 5,1 desc;

