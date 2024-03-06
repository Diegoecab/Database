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
    "Effect": "Allow",
    "Principal": {
      "Service": ["events.rds.amazonaws.com","rds.amazonaws.com","events.amazonaws.com"]
    },
    "Action": [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ],
    "Resource": "*"
  },
  {
      "Sid": "Allow access for Key User (SNS IAM User)",
      "Effect": "Allow",
      "Principal": {"AWS": "arn:aws:iam::274146641877:user/Admin"},
      "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ],
      "Resource": "*"
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
