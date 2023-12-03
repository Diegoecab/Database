aws rds describe-orderable-db-instance-options --engine oracle-se2 --engine-version 19.0.0.0.ru-2023-04.rur-2023-04.r1 --db-instance-class db.t3.large \
 --license-model license-included --region us-east-1 --query 'OrderableDBInstanceOptions[].AvailabilityZones' --output text | sed -e 'y/\t/\n/' | uniq


 aws rds describe-orderable-db-instance-options --engine oracle-se2 \
 --engine-version 19.0.0.0.ru-2023-04.rur-2023-04.r1 --db-instance-class db.t3.large \
 --license-model license-included --region us-east-1 \
 --query 'OrderableDBInstanceOptions[].AvailabilityZones' --output text | sed -e 'y/\t/\n/' | uniq


 aws rds describe-orderable-db-instance-options --engine oracle-se2 \
 --engine-version 19.0.0.0.ru-2023-04.rur-2023-04.r1 --db-instance-class db.t3.large \
 --license-model license-included --region us-east-1 --output table

  aws rds describe-orderable-db-instance-options --engine oracle-se2 \
 --engine-version 19.0.0.0.ru-2023-04.rur-2023-04.r1 --db-instance-class db.t3.large \
 --region       us-east-1 --output text --license-model license-included --query 'OrderableDBInstanceOptions[].AvailabilityZones' | sort| uniq


