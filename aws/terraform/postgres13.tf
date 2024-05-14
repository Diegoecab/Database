resource "aws_db_instance" "testupgrade" {
  identifier             = "testupgrade"
  instance_class         = "db.t3.micro"
  engine                 = "postgres"
  allocated_storage	 = 20
  backup_retention_period = 7
 allow_major_version_upgrade           = true
 apply_immediately                     = true
 # multi_az		= true
  engine_version         = "13.9"
  auto_minor_version_upgrade = false
  username               = "edu"
  password               = "testpass"
  publicly_accessible    = false
  skip_final_snapshot    = true
}

resource "aws_db_instance" "testupgrade-replica" {
   identifier             = "testupgrade-replica"
   replicate_source_db    = aws_db_instance.testupgrade.identifier
   instance_class         = "db.t3.micro"
   auto_minor_version_upgrade = true
 #  multi_az		= true
   apply_immediately      = true
   publicly_accessible    = false
   skip_final_snapshot    = true
}

