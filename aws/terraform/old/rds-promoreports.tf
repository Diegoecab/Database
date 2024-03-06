variable "promoreports_instances_count" {
  type    = number
  default = 3
}

variable "env" {
  type = string
  default = "test"
}


resource "aws_rds_cluster" "postgres_promoreports3" {
  count = var.promoreports_instances_count > 0 ? 1 : 0

  cluster_identifier              = "postgresql-promoreports3-${var.env}test"
  engine                          = "postgres"
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.postgres_promoreports3[0].name
  engine_version                  = "15.5"
  port                            = 5432
  db_subnet_group_name            = "aupg-labs-db-subnet-group2"
 # vpc_security_group_ids          = sg-0d2545482618dda5c
  master_username                 = "postgres_admin"
  master_password                 = "postgres"
 # availability_zones              = data.aws_availability_zones.available.names
  db_cluster_instance_class = "db.m6gd.2xlarge"
  allocated_storage               = 100
  copy_tags_to_snapshot           = true
  storage_type                    = "io1"
  iops                            = 3000
  skip_final_snapshot             = true
  apply_immediately               = true
  publicly_accessible		 = true
  # publicly_accessible             = true
  # enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  #tags = merge(
  #  local.tags,
  #  {
  #    engine = "postgresql"
  #    db     = "promoreports"
  #  }
  #)

  lifecycle {
    ignore_changes = [iops, snapshot_identifier]
  }
}
resource "aws_rds_cluster_parameter_group" "postgres_promoreports3" {
  count  = var.promoreports_instances_count > 0 ? 1 : 0
  name   = "postgres-15-promoreports2-${var.env}test"
  family = "postgres15"

  parameter {
    apply_method = "pending-reboot"
    name         = "idle_in_transaction_session_timeout"
    value        = "300000"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "shared_preload_libraries"
    value        = "pg_cron,pg_stat_statements"
  }

#  tags = merge(
#    local.tags,
#    {
#      engine = "postgresql"
#    }
#  )

  lifecycle {
    create_before_destroy = true
  }
}


