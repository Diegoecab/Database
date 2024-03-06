aws s3api put-object --bucket dms-dec --key rds-pg-import.json --body /mnt/c/dc/temp/rds-pg-import.json


	$ aws rds describe-db-instances \
	 --db-instance-identifier pgcloudformation \
	 --region us-east-1 --output table \
	--query 'DBInstances[*].[MaxAllocatedStorage,PerformanceInsightsEnabled]' 
	
	---------------------
	|DescribeDBInstances|
	+--------+----------+
	|  None  |  False   |
	+--------+----------+




	{
	  "AWSTemplateFormatVersion": "2010-09-09",
	  "Resources": {
		"MyRDSInstance": {
							  "Type" : "AWS::RDS::DBInstance",
							  "DeletionPolicy": "Retain",
							  "Properties" : {
								  "DBInstanceClass": "db.t3.small",
								  "Engine": "postgres",
								  "EngineVersion": "15.5",
								  "DBInstanceIdentifier": "PGCloudFormation",
								  "AllocatedStorage": "10",
								  "MasterUsername" : "postgres",
								  "MasterUserPassword" : "postgres",
								  "AutoMinorVersionUpgrade": "false",
								  "BackupRetentionPeriod": "0",
								  "MaxAllocatedStorage": "20"
								}
							}
	  }
	}


	aws cloudformation update-stack --stack-name RDSPostgres --template-url https://dms-dec.s3.amazonaws.com/rds-pg-import.json

	$ aws rds describe-db-instances \
	 --db-instance-identifier pgcloudformation \
	 --region us-east-1 \
	--query 'DBInstances[*].MaxAllocatedStorage'
	[
		20
	]




rds-pg-import.json:
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Resources": {
    "MyRDSInstance": {
						  "Type" : "AWS::RDS::DBInstance",
						  "DeletionPolicy": "Retain",
						  "Properties" : {
							  "DBInstanceClass": "db.t3.small",
							  "Engine": "postgres",
							  "EngineVersion": "15.5",
							  "DBInstanceIdentifier": "PGCloudFormation",
							  "AllocatedStorage": "10",
							  "MasterUsername" : "postgres",
							  "MasterUserPassword" : "postgres",
							  "AutoMinorVersionUpgrade": "false",
							  "BackupRetentionPeriod": "0",
							  "MaxAllocatedStorage": "20",
							  "EnablePerformanceInsights": true
							}
						}
  }
}

