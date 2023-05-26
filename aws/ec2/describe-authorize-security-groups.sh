aws rds describe-db-instances --db-instance-identifier aupg

aws ec2 describe-security-groups

aws ec2 describe-security-groups `
    --filters Name=group-name,Values=*au*
	
aws ec2 authorize-security-group-ingress `
    --description "AmznInternalCIDR" `
    --group-id sg-0d2545482618dda5c `
    --protocol tcp `
    --port 5432 `
    --cidr 54.239.116.0/23

aws ec2 authorize-security-group-ingress --group-id sg-0d2545482618dda5c --ip-permissions IpProtocol=tcp,FromPort=5432,ToPort=5432,IpRanges="[{CidrIp=54.239.116.0/23,Description='RDP access from Amazon VPN'}]"