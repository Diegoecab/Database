aws dms create-replication-instance \
    --replication-instance-identifier my-repl-instance-case-test \
    --replication-instance-class dms.t2.micro \
	--engine-version 3.4.6 \
    --allocated-storage 5 \
	--vpc-security-group-ids sg-0d2545482618dda5c \
	--replication-subnet-group-identifier default-vpc-056fbe8fc74b66410
