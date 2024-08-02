resource "aws_rds_cluster_endpoint" "massdriver_readonly" {
  cluster_identifier          = "aupg149"
  cluster_endpoint_identifier = "aupg149-custom-reader3"
  custom_endpoint_type        = "READER"
}



