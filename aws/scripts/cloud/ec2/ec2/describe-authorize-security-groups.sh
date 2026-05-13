# ------------------------------------------------------------------------------
# File       : describe-authorize-security-groups.sh
# Purpose    : aws cloud/ec2 helper: describe authorize security groups.
# Engine     : aws
# Category   : cloud/ec2
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./describe-authorize-security-groups.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
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