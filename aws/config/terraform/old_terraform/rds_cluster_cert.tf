resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "aupg147-instance-${count.index}"
  cluster_identifier = "aupg147"
  instance_class     = "db.t3.medium"
  engine             = "aurora-postgresql"
  engine_version     = "14.7"
  apply_immediately  = "true"
  ca_cert_identifier = "rds-ca-rsa2048-g1"
}

