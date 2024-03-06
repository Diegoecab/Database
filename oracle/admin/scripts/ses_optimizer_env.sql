--v$ses_optimizer_env.sql
--Ver configuracion de parameteros de session de otras sesiones
select * from v$ses_optimizer_env where sid=&sid order by name;