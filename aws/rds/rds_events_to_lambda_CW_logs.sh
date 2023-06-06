aws iam create-policy  --policy-name rdsstopstart  --policy-document '{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "VisualEditor0",
          "Effect": "Allow",
          "Action": [
              "rds:DescribeDBClusterParameters",
              "rds:StartDBCluster",
              "rds:StopDBCluster",
              "rds:DescribeDBEngineVersions",
              "rds:DescribeGlobalClusters",
              "rds:DescribePendingMaintenanceActions",
              "rds:DescribeDBLogFiles",
              "rds:StopDBInstance",
              "rds:StartDBInstance",
              "rds:DescribeReservedDBInstancesOfferings",
              "rds:DescribeReservedDBInstances",
              "rds:ListTagsForResource",
              "rds:DescribeValidDBInstanceModifications",
              "rds:DescribeDBInstances",
              "rds:DescribeSourceRegions",
              "rds:DescribeDBClusterEndpoints",
              "rds:DescribeDBClusters",
              "rds:DescribeDBClusterParameterGroups",
              "rds:DescribeOptionGroups"
          ],
          "Resource": "*"
      }
  ]
}'


 aws iam create-role  \
    --role-name RDS-Lambda-role  \
    --assume-role-policy-document '{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
            "Service": "lambda.amazonaws.com"
          },
         "Action": "sts:AssumeRole"
       }
     ] 
   }'
   
 aws iam attach-role-policy  --policy-arn 'arn:aws:iam::274146641877:policy/rdsstopstart'  --role-name RDS-Lambda-role
   
  
 aws lambda create-function --function-name rds-rdsLambda-function-Start --zip-file fileb://lambdaFunctionStartRDSInstance.zip --runtime python3.7 --role arn:aws:iam::274146641877:role/RDS-Lambda-role --environment "Variables={KEY=MyLab,REGION=us-east-1,VALUE=Auto-Shutdown}" --handler rds-rdsLambda-function-Start.lambda_handler
 
 
  aws lambda invoke \
    --function-name rds-rdsLambda-function-Stop \
    --invocation-type Event \
    --payload '{ "KEY": "MyLab", "REGION": "us-east-1","VALUE": "Auto-Shutdown"}' \
    response.json
	

 aws lambda invoke \
    --function-name rds-rdsLambda-function-Start \
    --invocation-type Event \
    --payload '{ "KEY": "MyLab", "REGION": "us-east-1","VALUE": "Auto-Shutdown"}' \
    response.json
	


aws events put-rule --name "RDSInstanceStateChangeStop" --event-pattern "{\"source\":[\"aws.rds\"],\"detail-type\":[\"RDS DB Instance Event\"],\"EventID\":{\"state\":[\"RDS-EVENT-0004\"]}}" 

aws events put-rule --name "RDSInstanceStateChgStop" --event-pattern "{\"source\":[\"aws.rds\"],\"detail-type\":[\"RDS DB Instance Event\"],\"detail\":{\"EventID\":[\"RDS-EVENT-0004\"]}}" 

"detail":{"Message":"DB instance shutdown",
	"EventID":"RDS-EVENT-0004"}

aws events put-targets --rule RDSInstanceStateChgStop --targets "Id"="1","Arn"="arn:aws:lambda:us-east-1:274146641877:function:rds-rdsLambda-function-Start"
aws events put-targets --rule RDSInstanceStateChgStop --targets "Id"="2","Arn"="arn:aws:logs:us-east-1:274146641877:log-group:/aws/events/stoppedInstance"



aws rds stop-db-instance \
    --db-instance-identifier rds-pg-labs



aws rds describe-events \
    --source-identifier rds-pg-labs \
    --source-type db-instance


	
--Additional permission in case the lambda execution is not working
	aws lambda add-permission \
		--function-name rds-rdsLambda-function-Start \
		--statement-id startdbstatement \
		--action 'lambda:InvokeFunction' \
		--principal events.amazonaws.com \
		--source-arn arn:aws:events:us-east-1:274146641877:rule/RDSInstanceStateChgStop