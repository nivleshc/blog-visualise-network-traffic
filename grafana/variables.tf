variable "grafana_server_details" {
  description = "Configuration details for the Grafana Server"
  type = object({
    ami_id         = string
    instance_type  = string
    ec2_key_name   = string
    vpc_id         = string
    subnet_id      = string
    my_ip_address  = string
    admin_username = string
    admin_password = string

    data_source = object({
      type                   = string
      name                   = string
      uid                    = string
      org_id                 = number
      auth_type              = string
      default_log_group_name = string
      traffic_dest_cidr      = string
    })

    tags = map(string)
  })
}
