aws --no-verify-ssl rds describe-db-parameter-groups

aws rds describe-db-parameters --query 'Parameters[].{DBParameterGroupFamily: postgres15}' --output json

aws rds describe-db-instances --db-instance-identifier pglab

aws rds describe-db-instances --db-instance-identifier pglab --query 'DBInstances[*].[DBParameterGroups]'

aws rds create-db-parameter-group    --db-parameter-group-name postgres15pglab   --db-parameter-group-family postgres15  --description "My new parameter group"

aws rds modify-db-parameter-group `
   --db-parameter-group-name postgres15pglab `
   --parameters "ParameterName=pgaudit.role,ParameterValue=rds_pgaudit,ApplyMethod=pending-reboot" `
   --region us-east-1
   
   
aws rds modify-db-instance `
    --db-instance-identifier pglab `
    --db-parameter-group-name postgres15pglab `
    --apply-immediately
	
aws rds describe-db-instances --db-instance-identifier pglab --query 'DBInstances[*].[DBInstanceStatus]'


aws rds reboot-db-instance `
    --db-instance-identifier pglab  `
    --region us-east-1
	
	
aws rds describe-db-snapshots --snapshot-type manual  --query "length(*[].{DBSnapshots:SnapshotType})"   --region us-east-1
aws rds describe-db-snapshots --db-instance-identifier pglab --region us-east-1 --query 'DBSnapshots[*].[DBSnapshotIdentifier,SnapshotType,SnapshotCreateTime]'