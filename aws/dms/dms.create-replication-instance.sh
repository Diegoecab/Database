aws dms create-replication-instance \
    --replication-instance-identifier my-repl-instance-case-test \
    --replication-instance-class dms.t2.micro \
	--engine-version 3.4.6 \
    --allocated-storage 5 \
	--vpc-security-group-ids sg-0d2545482618dda5c \
	--replication-subnet-group-identifier default-vpc-056fbe8fc74b66410


aws dms create-replication-instance --replication-instance-identifier stage-sql-aurora-dns --replication-instance-class dms.r6i.4xlarge --allocated-storage 150 --dns-name-servers "10.219.33.238,10.219.34.135" --region us-east-1 --no-publicly-accessible --replication-subnet-group-identifier default-vpc-0ea4363fc6b2e9f6e --vpc-security-group-ids sg-07d78295cbed1a5f7 sg-0b5932db5ec2a7d18 --engine-version "3.5.2"
