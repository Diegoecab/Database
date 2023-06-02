## S3

aws s3api create-bucket \
	    --bucket diegoec \
	        --region us-east-1

 aws s3 ls diegoec-nht-bucket-1
 
aws s3api list-object-versions --bucket diegoec-nht-bucket-1 --prefix test.txt.txt

# Enabling  bucket versioning
aws s3api put-bucket-versioning --bucket diegoec-nht-bucket-1 --versioning-configuration Status=Enabled


aws s3 ls \pglab-exports/pglab/

# Copying objects

aws s3 cp s3://pglab-exports/pglab/sample_table.txt ./
