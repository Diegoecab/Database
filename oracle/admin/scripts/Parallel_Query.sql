/* Determinar Consultas en paralelo */
SELECT   qcsid,
         sid,
         NVL(server_group,0) server_group,
         server_set,
         degree,
         req_degree
FROM     SYS.V_$PX_SESSION
ORDER BY qcsid,
         NVL(server_group,0),
         server_set;


/* Vistas ...*/

select * from v_$pq_sysstat;
select * from v_$px_process;
select * from v_$px_sesstat;
select * from v_$px_process_sysstat;