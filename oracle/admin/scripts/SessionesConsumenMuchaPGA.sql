SELECT username usuario,
name,
value
FROM v$statname sn,
v$session s,
v$sesstat st
WHERE sn.statistic# = st.statistic#
AND s.sid = st.sid
AND sn.name like '%session%pga%mem%'
AND st.value > 40000
AND s.type = 'USER';