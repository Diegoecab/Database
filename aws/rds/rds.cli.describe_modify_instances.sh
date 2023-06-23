aws rds describe-db-instances --db-instance-identifier do-not-delete-training-diegoec --query 'DBInstances[*].[DBInstanceStatus]'
aws rds modify-db-instance --db-instance-identifier do-not-delete-training-diegoec --backup-retention-period 1
