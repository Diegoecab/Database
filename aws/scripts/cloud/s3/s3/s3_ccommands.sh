# ------------------------------------------------------------------------------
# File       : s3_ccommands.sh
# Purpose    : aws cloud/s3 helper: s3 ccommands.
# Engine     : aws
# Category   : cloud/s3
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./s3_ccommands.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
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
