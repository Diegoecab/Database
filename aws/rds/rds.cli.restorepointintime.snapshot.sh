aws rds describe-db-instances \
  --db-instance-identifier rds-pg-labs \
  --region $AWSREGION \
  --query 'DBInstances[0].LatestRestorableTime' \
  --output text

aws rds restore-db-instance-to-point-in-time \
  --source-db-instance-identifier rds-pg-labs \
  --target-db-instance-identifier rds-pg-labs-restore-apr30 \
  --restore-time 2023-04-30T23:23:00+00:00


aws rds restore-db-instance-to-point-in-time \
  --source-db-instance-identifier db1-13474095581 \
  --target-db-instance-identifier db1-13-13474095581 \
  --db-subnet-group-name apg-labstack-aupglabsrdsstack-1vp537traavq6-dbsubnets-nool4qqn5klb \
  --vpc-security-group-ids sg-0d2545482618dda5c \
  --publicly-accessible \
  --db-parameter-group-name postgres-13-logicalrep \
  --restore-time 2023-08-07T13:00:00-07:00

# Revisar esto al parecer viene por default:       "PubliclyAccessible": true,
      
