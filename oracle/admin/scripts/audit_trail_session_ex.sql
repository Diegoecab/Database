Detectar accesos fallidos a la Base de Datos:

SELECT
 username "USER",
 os_username "OS_USER",
 terminal "TERMINAL",
 action_name "ACTION",
 to_char(timestamp,'DD-Mon-YYYY HH24:MI:SS') "DATE",
 to_char(logoff_time,'DD-Mon-YYYY HH24:MI:SS') "LOGOFF_TIME",
 returncode "RETURN_CODE"
FROM dba_audit_session
WHERE terminal IS NOT NULL
AND returncode <> 0
ORDER BY username, timestamp;

Detectar accesos con usuarios inexistentes:
SELECT
 username "USER",
 os_username "OS_USER",
 terminal "TERMINAL",
 to_char(timestamp,'DD-Mon-YYYY HH24:MI:SS') "DATE"
FROM dba_audit_session
WHERE terminal IS NOT NULL
AND returncode <> 0
AND NOT EXISTS (SELECT 'x' FROM dba_users WHERE dba_users.username=dba_audit_session.username);

Detectar accesos fuera de horario de oficina:
SELECT
 username "USER",
 os_username "OS_USER",
 terminal "TERMINAL",
 action_name "ACTION",
 to_char(timestamp,'DD-Mon-YYYY HH24:MI:SS') "DATE",
 to_char(logoff_time,'DD-Mon-YYYY HH24:MI:SS') "LOGOFF_TIME",
 returncode "RETURN_CODE"
FROM dba_audit_session
WHERE terminal IS NOT NULL
AND action_name = 'LOGON'
AND (to_date(to_char(timestamp,'HH24:MI:SS'),'HH24:MI:SS') < to_date(&start_date,'HH24:MI:SS') or to_date(to_char(timestamp,'HH24:MI:SS'),'HH24:MI:SS') > to_date(&end_date,'HH24:MI:SS'));

Detectar Usuarios que Comparten Cuentas:
SELECT
 count(distinct(terminal)) "TERMINALS",
 username "USER"
FROM dba_audit_session
HAVING count(distinct(terminal))>1
GROUP BY username;

Detectar Usuarios que Comparten Terminales:
SELECT
 count(distinct(username)) "USERS",
 terminal "TERMINAL"
FROM dba_audit_session
WHERE terminal IS NOT NULL
HAVING count(distinct(username))>1
GROUP BY terminal;

Contabilizar Accesos por Usuario:
SELECT
 username "DB_USER",
 count(*) "ACCESSES"
FROM dba_audit_session
WHERE action_name = 'LOGON'
GROUP BY username
ORDER BY 1;