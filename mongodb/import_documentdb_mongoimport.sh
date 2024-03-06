
mongoimport --ssl \
    --host="docdb-1.cluster-cdus3jhjlk3a.us-east-1.docdb.amazonaws.com:27017" \
    --collection=order \
    --db=test \
    --file=order.json \
    --numInsertionWorkers 4 \
    --username=docdb \
    --password=docdb123 \
    --sslCAFile global-bundle.pem
	
