aws s3api create-bucket \
    --bucket pglab-exports \
    --region us-east-1

aws iam create-policy  --policy-name rds-s3-export-policy  --policy-document '{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Sid": "s3export",
         "Action": [
           "s3:PutObject",
           "s3:AbortMultipartUpload"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::pglab-exports/*"
         ] 
       }
     ] 
   }'
   
   
 aws iam create-role  \
    --role-name rds-s3-export-role  \
    --assume-role-policy-document '{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
            "Service": "rds.amazonaws.com"
          },
         "Action": "sts:AssumeRole",
         "Condition": {
             "StringEquals": {
                "aws:SourceAccount": "274146641877",
                "aws:SourceArn": "arn:aws:rds:us-east-1:274146641877:db:pglab"
                }
             }
       }
     ] 
   }'
   

aws iam attach-role-policy  --policy-arn 'arn:aws:iam::274146641877:policy/rds-s3-export-policy'  --role-name rds-s3-export-role 

aws rds add-role-to-db-instance \
 --db-instance-identifier pglab \
 --feature-name s3Export \
 --role-arn 'arn:aws:iam::274146641877:role/rds-s3-export-role'   \
 --region us-east-1
   
   psql=> 
SELECT aws_commons.create_s3_uri(
   'pglab-exports',
   'pglab',
   'us-east-1'
) AS s3_uri_1;

###Within psql

CREATE TABLE sample_table (bid bigint PRIMARY KEY, name varchar(80));
INSERT INTO sample_table (bid,name) VALUES (1, 'Monday'), (2,'Tuesday'), (3, 'Wednesday');


SELECT * from aws_s3.query_export_to_s3('select * from sample_table', 'pglab-exports', 'pglab/sample_table.txt');




##### Import


aws iam create-policy  --policy-name rds-s3-import-policy  --policy-document '{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Sid": "s3import",
         "Action": [
           "s3:GetObject",
           "s3:ListBucket"
         ],
         "Effect": "Allow",
         "Resource": [
		   "arn:aws:s3:::pglab-exports",
           "arn:aws:s3:::pglab-exports/*"
         ] 
       }
     ] 
   }'
   
   "Arn": "arn:aws:iam::274146641877:policy/rds-s3-import-policy"
   
   
 aws iam create-role  \
    --role-name rds-s3-import-role  \
    --assume-role-policy-document '{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
            "Service": "rds.amazonaws.com"
          },
         "Action": "sts:AssumeRole",
         "Condition": {
             "StringEquals": {
                "aws:SourceAccount": "274146641877",
                "aws:SourceArn": "arn:aws:rds:us-east-1:274146641877:db:pglab"
                }
             }
       }
     ] 
   }'
   

aws iam attach-role-policy  --policy-arn 'arn:aws:iam::274146641877:policy/rds-s3-import-policy'  --role-name rds-s3-import-role 

aws rds add-role-to-db-instance \
 --db-instance-identifier pglab \
 --feature-name s3Import \
 --role-arn 'arn:aws:iam::274146641877:role/rds-s3-import-role'   \
 --region us-east-1

#https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PostgreSQL.S3Import.html

#https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PostgreSQL.S3Import.html#aws_s3.table_import_from_s3

postgres=> 
postgres=> create table newtable as select * from sample_table;
SELECT 3

SELECT aws_commons.create_s3_uri(
   'pglab-exports',
   'pglab/sample_table.txt',
   'us-east-1'
) AS s3_uri_1;


SELECT aws_s3.table_import_from_s3(
   'newtable', '', '',
   '(pglab-exports,pglab/sample_table.txt,us-east-1)'
);