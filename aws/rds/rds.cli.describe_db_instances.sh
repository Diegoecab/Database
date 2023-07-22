aws rds describe-db-instances \
 --db-instance-identifier rds-pg-labs \
 --region us-east-1 \
  --output table \
--query 'DBInstances[*].DomainMemberships'
# --profile aws-acc-1 \
