aws rds modify-db-parameter-group \
   --db-parameter-group-name custom-param-group-name \
   --parameters "ParameterName=pgaudit.role,ParameterValue=rds_pgaudit,ApplyMethod=pending-reboot" \
   --region aws-region
   