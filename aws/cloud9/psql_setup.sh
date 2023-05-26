# run these commands after the DBendpoint is known and the SecretManager steps
# Update the AWS CLI v2
sudo rm -rf /usr/local/aws
sudo rm /usr/bin/aws
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

# Resize Cloud9 Volume to 50G
source <(curl -s https://raw.githubusercontent.com/aws-samples/aws-swb-cloud9-init/mainline/cloud9-resize.sh)

sudo yum install -y jq
sudo amazon-linux-extras install -y postgresql11
sudo yum install -y postgresql-contrib sysbench
AWSREGION=`aws configure get region`

DBENDP=`aws rds describe-db-instances \
    --db-instance-identifier rds-pg-labs \
    --region $AWSREGION \
    --query 'DBInstances[*].Endpoint.Address' \
    --output text`

DB14ENDP=`aws rds describe-db-instances \
    --db-instance-identifier rds-pg-145 \
    --region $AWSREGION \
    --query 'DBInstances[*].Endpoint.Address' \
    --output text`

# This assumes you named the secret to be secretPostgresqlMasterUser
# There may be more than one secret that has a name like secretPostgresqlMasterUser, 
# so pick the most recently created one
# If error, you should manually set the SECRETARN variable
SECRETARN=`aws secretsmanager list-secrets \
    --query 'sort_by(SecretList[?contains(Name, \`secretPostgresqlMasterUser\`) == \`true\`],&CreatedDate)[-1].ARN' \
    --output text`

CREDS=`aws secretsmanager get-secret-value \
    --secret-id $SECRETARN \
    --region $AWSREGION | jq -r '.SecretString'`

export DBUSER="`echo $CREDS | jq -r '.username'`"
export DBPASS="`echo $CREDS | jq -r '.password'`"
export DBENDP DB14ENDP

echo DB14ENDP: $DB14ENDP
echo DBENDP: $DBENDP
echo DBUSER: $DBUSER


export PGHOST=$DBENDP
export PGUSER=$DBUSER
export PGPASSWORD="$DBPASS"

echo "export DBPASS=\"$DBPASS\"" >> /home/ec2-user/.bashrc
echo "export DBUSER=$DBUSER" >> /home/ec2-user/.bashrc
echo "export DBENDP=$DBENDP" >> /home/ec2-user/.bashrc
echo "export AWSREGION=$AWSREGION" >> /home/ec2-user/.bashrc
echo "export PGUSER=$DBUSER" >> /home/ec2-user/.bashrc
echo "export PGPASSWORD=\"$DBPASS\"" >> /home/ec2-user/.bashrc
echo "export PGHOST=$DBENDP" >> /home/ec2-user/.bashrc
echo "export PG14HOST=$DB14ENDP" >> /home/ec2-user/.bashrc


