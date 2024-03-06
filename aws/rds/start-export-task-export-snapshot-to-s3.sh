aws rds start-export-task \
    --export-task-identifier my-snapshot-export \
    --source-arn arn:aws:rds:AWS_Region:123456789012:snapshot:snapshot-name \
    --s3-bucket-name my-export-bucket \
    --iam-role-arn iam-role \
    --kms-key-id my-key

aws rds start-export-task \
    --export-task-identifier my-snapshot-pg15-export-dec11-23 \
    --source-arn arn:aws:rds:us-east-1:274146641877:snapshot:manualbkp120723  \
    --s3-bucket-name rds-dec \
    --iam-role-arn arn:aws:iam::274146641877:role/rds-s3-export-role \
    --kms-key-id arn:aws:kms:us-east-1:274146641877:key/01ed21db-5eac-401c-b30b-a7699d44404c


#You can't restore exported snapshot data from S3 to a new DB instance.

#https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ExportSnapshot.html#USER_ExportSnapshot.Limits
