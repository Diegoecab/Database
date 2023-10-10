aws rds modify-db-parameter-group \
   --db-parameter-group-name custom-param-group-name \
   --parameters "ParameterName=pgaudit.role,ParameterValue=rds_pgaudit,ApplyMethod=pending-reboot" \
   --region aws-region


aws rds modify-db-parameter-group \
    --db-parameter-group-name pg11-source-transport-group \
    --parameters "ParameterName=pg_transport.num_workers,ParameterValue=4,ApplyMethod=immediate" \
                 "ParameterName=pg_transport.timing,ParameterValue=1,ApplyMethod=immediate" \
                 "ParameterName=pg_transport.work_mem,ParameterValue=131072,ApplyMethod=immediate" \
                 "ParameterName=shared_preload_libraries,ParameterValue=\"pg_stat_statements,pg_transport\",ApplyMethod=pending-reboot" \
                 "ParameterName=max_worker_processes,ParameterValue=24,ApplyMethod=pending-reboot"
