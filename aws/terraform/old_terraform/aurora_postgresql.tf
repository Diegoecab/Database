resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo2-${count.index}"
  cluster_identifier = aws_rds_cluster.default.cluster_identifier
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "aurora-cluster-demo2"
 availability_zones = ["us-east-1a", "us-east-1b"]
#  db_subnet_group_name = "subnet-group-2-az"
  database_name      = "mydb"
  master_username    = "foo"
  master_password    = "barbut8chars"
  engine_version   = "15.5"
  engine = "aurora-postgresql"
  skip_final_snapshot = true
  lifecycle {
    ignore_changes = [availability_zones]
  }
}
