@dba_jobs
accept JOB prompt 'Ingrese JOB a eliminar: '
execute DBMS_JOB.REMOVE(&JOB);
commit;