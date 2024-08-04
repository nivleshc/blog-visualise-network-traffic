# use this resource to check that the grafana server is accessible, otherwise the grafana provider will fail
resource "null_resource" "check_grafana_server_is_accessible" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "bash -c 'until curl --output /dev/null --silent --head --fail $${URL}; do sleep 10; done'"
    environment = {
      URL = "http://${aws_instance.grafana_server.public_ip}:3000"
    }
  }

  depends_on = [
    aws_instance.grafana_server
  ]
}

# create a cloudwatch data source in Grafana
resource "grafana_data_source" "cloudwatch" {
  type       = var.grafana_server_details["data_source"]["type"]
  name       = var.grafana_server_details["data_source"]["name"]
  is_default = true
  uid        = local.cloudwatch_ds_uid
  org_id     = local.cloudwatch_org_id

  json_data_encoded = jsonencode({
    defaultRegion   = local.region
    authType        = var.grafana_server_details["data_source"]["auth_type"]
    defaultLogGroup = local.loggroup_name
  })

  depends_on = [
    null_resource.check_grafana_server_is_accessible
  ]
}

# create a folder for the traffic analysis dashboard
resource "grafana_folder" "traffic_analysis" {
  title = "Traffic Analysis Folder"
  uid   = "traffic_analysis-uid"

  depends_on = [
    null_resource.check_grafana_server_is_accessible
  ]
}

# create the traffic analysis dashboard
resource "grafana_dashboard" "traffic_analysis" {
  folder = grafana_folder.traffic_analysis.uid
  config_json = templatefile("${path.module}/dashboards/vpc_traffic_analysis.tpl.json", {
    account_id          = local.account_id,
    region              = local.region,
    loggroup_name       = local.loggroup_name,
    cloudwatch-ds-uid   = local.cloudwatch_ds_uid,
    traffic_dest_prefix = local.traffic_dest_prefix
  })

  depends_on = [
    null_resource.check_grafana_server_is_accessible
  ]
}

# set the traffic analysis dashboard as the default. This means that when you
# login to the Grafana console, this dashboard will be automatically displayed
resource "grafana_organization_preferences" "traffic_analysis" {
  org_id             = 1
  home_dashboard_uid = grafana_dashboard.traffic_analysis.uid

  depends_on = [
    null_resource.check_grafana_server_is_accessible
  ]
}
