aws rds describe-db-instances \
 --db-instance-identifier rds-pg-labs \
 --region us-east-1 \
  --output table \
--query 'DBInstances[*].DomainMemberships'
# --profile aws-acc-1 \

aws rds describe-db-instances --region us-east-1 --query 'DBInstances[*].[DBInstanceIdentifier,AvailabilityZone]' \
 --filters Name="db-cluster-id",Values="prd-sum-useast1-core-cluster"
