# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "aurora-cluster-demo2"
resource "aws_rds_cluster" "mdefault" {
  apply_immediately                   = null
  availability_zones                  = ["us-east-1a", "us-east-1c", "us-east-1d"]
  backtrack_window                    = 0
  backup_retention_period             = 1
  cluster_identifier                  = "aurora-cluster-demo2"
  cluster_identifier_prefix           = null
  cluster_members                     = ["aurora-cluster-demo2-0"]
  copy_tags_to_snapshot               = false
  database_name                       = "mydb"
  db_cluster_parameter_group_name     = "aurorclusterpostgres14custom"
  db_subnet_group_name                = "default"
  deletion_protection                 = false
  enable_http_endpoint                = false
  enabled_cloudwatch_logs_exports     = []
  engine                              = "aurora-postgresql"
  engine_mode                         = "provisioned"
  engine_version                      = "14.6"
  final_snapshot_identifier           = null
  global_cluster_identifier           = null
  iam_database_authentication_enabled = false
  iam_roles                           = []
  kms_key_id                          = null
  master_password                     = "test12456"# sensitive
  master_username                     = "foo"
  port                                = 5432
  preferred_backup_window             = "08:32-09:02"
  preferred_maintenance_window        = "tue:07:23-tue:07:53"
  replication_source_identifier       = null
  skip_final_snapshot                 = true
  snapshot_identifier                 = null
  source_region                       = null
  storage_encrypted                   = false
  tags                                = {}
  vpc_security_group_ids              = ["sg-0fa9a4fe44623d644"]
  timeouts {
    create = null
    delete = null
    update = null
  }
}

# __generated__ by Terraform from "aurora-cluster-demo2-0"
resource "aws_rds_cluster_instance" "cluster_instances" {
  apply_immediately               = null
  auto_minor_version_upgrade      = true
  availability_zone               = "us-east-1d"
  ca_cert_identifier              = "rds-ca-rsa2048-g1"
  cluster_identifier              = "aurora-cluster-demo2"
  copy_tags_to_snapshot           = false
  db_parameter_group_name         = "default.aurora-postgresql14"
  db_subnet_group_name            = "default"
  engine                          = "aurora-postgresql"
  engine_version                  = "14.6"
  identifier                      = "aurora-cluster-demo2-0"
  identifier_prefix               = null
  instance_class                  = "db.t3.medium"
  monitoring_interval             = 0
  monitoring_role_arn             = null
  performance_insights_enabled    = false
  performance_insights_kms_key_id = null
  preferred_backup_window         = "08:32-09:02"
  preferred_maintenance_window    = "tue:04:14-tue:04:44"
  promotion_tier                  = 0
  publicly_accessible             = false
  tags                            = {}
  timeouts {
    create = null
    delete = null
    update = null
  }
}
