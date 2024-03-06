aws rds create-db-cluster \
  --region us-east-1 \
  --db-cluster-identifier primary  \
  --master-username rdsadmin1 \
  --master-user-password rdsadmin1 \
  --engine aurora-postgresql \
  --engine-version 15.3

aws rds create-db-instance \
  --db-cluster-identifier primary \
  --db-instance-class db.r5.large \
  --db-instance-identifier instance-1 \
  --engine aurora-postgresql \
  --engine-version 15.3 \
  --region us-east-1

