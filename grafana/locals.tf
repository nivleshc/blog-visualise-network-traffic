locals {
  account_id          = data.aws_caller_identity.current.account_id
  region              = data.aws_region.current.name
  loggroup_name       = var.grafana_server_details["data_source"]["default_log_group_name"]
  cloudwatch_ds_uid   = var.grafana_server_details["data_source"]["uid"]
  cloudwatch_org_id   = var.grafana_server_details["data_source"]["org_id"]
  traffic_dest_cidr   = var.grafana_server_details["data_source"]["traffic_dest_cidr"]
  traffic_dest_prefix = join(".", [split(".", local.traffic_dest_cidr)[0], split(".", local.traffic_dest_cidr)[1], split(".", local.traffic_dest_cidr)[2]])
}
