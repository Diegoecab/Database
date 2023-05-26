aws rds describe-db-instances \
  --db-instance-identifier rds-pg-labs \
  --region $AWSREGION \
  --query 'DBInstances[0].LatestRestorableTime' \
  --output text

aws rds restore-db-instance-to-point-in-time \
  --source-db-instance-identifier rds-pg-labs \
  --target-db-instance-identifier rds-pg-labs-restore-apr30 \
  --restore-time 2023-04-30T23:23:00+00:00


# Revisar esto al parecer viene por default:       "PubliclyAccessible": true,
      