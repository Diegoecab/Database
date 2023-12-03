aws dms test-connection \
    --replication-instance-arn arn:aws:dms:us-east-1:123456789012:rep:T3OM7OUB5NM2LCVZF7JPGJRNUE \
    --endpoint-arn arn:aws:dms:us-east-1:123456789012:endpoint:6GGI6YPWWGAYUVLKIB732KEVWA
	 

for r in $(aws dms describe-endpoints --output json | jq '.Endpoints | .[] | .EndpointArn' | sed -e 's/\"//g' )
do
	aws dms test-connection \
    --replication-instance-arn arn:aws:dms:us-east-1:274146641877:rep:LUI5N3XRZ5JJ6RZ2HHR4NOGAYTZWFORAVNJK3NA \
	--endpoint-arn $r
done
