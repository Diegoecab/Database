resource "aws_db_instance" "pg15-upgradetest" {
  identifier             = "pg15-upgradetest"
  instance_class         = "db.t3.micro"
  engine                 = "postgres"
  allocated_storage	 = 20
  backup_retention_period = 7
 allow_major_version_upgrade           = true
 apply_immediately                     = true
 # multi_az		= true
  engine_version         = "15.5"
  auto_minor_version_upgrade = false
  username               = "edu"
  password               = "testpass"
  publicly_accessible    = false
  skip_final_snapshot    = true
}

resource "aws_db_instance" "pg15-upgradetest-readreplica" {
   identifier             = "pg15-upgradetest-readreplica"
   replicate_source_db    = aws_db_instance.pg15-upgradetest.identifier
   instance_class         = "db.t3.micro"
   auto_minor_version_upgrade = true
 #  multi_az		= true
   apply_immediately      = true
   publicly_accessible    = false
   skip_final_snapshot    = true
}

