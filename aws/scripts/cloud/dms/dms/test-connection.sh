# ------------------------------------------------------------------------------
# File       : test-connection.sh
# Purpose    : aws cloud/dms helper: test connection.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./test-connection.sh
# Parameters : LUI5N3XRZ5JJ6RZ2HHR4NOGAYTZWFORAVNJK3NA, T3OM7OUB5NM2LCVZF7JPGJRNUE, aws, dms, endpoint, rep, us
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws dms test-connection \
    --replication-instance-arn arn:aws:dms:us-east-1:123456789012:rep:T3OM7OUB5NM2LCVZF7JPGJRNUE \
    --endpoint-arn arn:aws:dms:us-east-1:123456789012:endpoint:6GGI6YPWWGAYUVLKIB732KEVWA
	 

for r in $(aws dms describe-endpoints --output json | jq '.Endpoints | .[] | .EndpointArn' | sed -e 's/\"//g' )
do
	aws dms test-connection \
    --replication-instance-arn arn:aws:dms:us-east-1:274146641877:rep:LUI5N3XRZ5JJ6RZ2HHR4NOGAYTZWFORAVNJK3NA \
	--endpoint-arn $r
done
