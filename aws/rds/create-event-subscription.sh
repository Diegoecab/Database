
aws kms create-key
{
    "KeyMetadata": {
        "AWSAccountId": "274146641877",
        "KeyId": "eab4a0b6-4fc9-4d02-a908-4ca926a7c385",
        "Arn": "arn:aws:kms:us-east-1:274146641877:key/eab4a0b6-4fc9-4d02-a908-4ca926a7c385",
        "CreationDate": "2023-12-07T08:26:02.379000-08:00",
        "Enabled": true,
        "Description": "",
        "KeyUsage": "ENCRYPT_DECRYPT",
        "KeyState": "Enabled",
        "Origin": "AWS_KMS",
        "KeyManager": "CUSTOMER",
        "CustomerMasterKeySpec": "SYMMETRIC_DEFAULT",
        "KeySpec": "SYMMETRIC_DEFAULT",
        "EncryptionAlgorithms": [
            "SYMMETRIC_DEFAULT"
        ],
        "MultiRegion": false
    }
}

$ aws kms get-key-policy \
    --policy-name default \
    --key-id bcc3eef2-ba86-47dd-8ed7-1b077e72532b \
    --query Policy \
    --output text
{
  "Version" : "2012-10-17",
  "Id" : "key-default-1",
  "Statement" : [ {
    "Sid" : "Enable IAM User Permissions",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::274146641877:root"
    },
    "Action" : "kms:*",
    "Resource" : "*"
  } ]
}

policy.txt:

{
  "Version" : "2012-10-17",
  "Id" : "key-default-1",
  "Statement" : [ {
    "Sid" : "Enable IAM User Permissions",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::274146641877:root"
    },
    "Action" : "kms:*",
    "Resource" : "*"
  },
  {
      "Sid": "Allow access for Key User (SNS Service Principal)",
      "Effect": "Allow",
      "Principal": {"Service": "sns.amazonaws.com"},
      "Action": [
        "kms:GenerateDataKey*",
        "kms:Decrypt"
      ],
      "Resource": "*"
    }
  ]
}


aws kms put-key-policy \
    --policy-name default \
    --key-id bcc3eef2-ba86-47dd-8ed7-1b077e72532b \
    --policy file://policy.txt
   

aws sns create-topic \
    --name my-topic-dec2023 \
        --attributes KmsMasterKeyId=eab4a0b6-4fc9-4d02-a908-4ca926a7c385
{
    "TopicArn": "arn:aws:sns:us-east-1:274146641877:my-topic-dec2023"
}





{
    "Version": "2012-10-17",
    "Id": "key-consolepolicy-3",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::274146641877:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "events.rds.amazonaws.com"
            },
            "Action": [],
            "Resource": "*"
        }
    ]
}


aws rds create-event-subscription \
    --subscription-name rdsinstance-events \
    --source-type db-instance \
    --event-categories '["backup","recovery"]' \
    --sns-topic-arn arn:aws:sns:us-east-1:274146641877:my-topic-dec2023
	

