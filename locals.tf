locals {
  vpc = {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    vpc_flow_logs = {
      cloudwatch_log_group_name              = "/aws/vpc/flowlogs"
      cloudwatch_log_group_retention_in_days = 7
      traffic_to_capture                     = "ALL"
    }
    tags = {
      Name = "traffic-analysis"
    }
  }

  subnets = {
    private = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-southeast-2a"
      tags = {
        Name = "private-subnet"
      }
    }

    public = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-southeast-2b"
      tags = {
        Name = "public-subnet"
      }
    }
  }

  grafana_server_details = {
    ami_id         = <"ami id to use, for example, ami-0adb7876d1f03a8ac">
    instance_type  = <"the instance type to use, for example, t3.small">
    ec2_key_name   = <"the name of the EC2 key pair that will be used to create the Grafana Server EC2 instance">
    vpc_id         = module.vpc.vpc_id
    subnet_id      = module.vpc.public_subnet_id
    my_ip_address  = <"Your current IP address in CIDR format, for example 1.2.3.4/32. This will be used to configure the security groups, so that only you can connect to the Grafana Console, or can ssh to the EC2 server">
    admin_username = "admin"
    admin_password = <"the default password that would be set for the Grafana admin user account">
    data_source = {
      type                   = "cloudwatch"
      name                   = "cloudwatch"
      org_id                 = 1
      uid                    = "cloudwatch-ds-uid"
      auth_type              = "sdk"
      default_log_group_name = local.vpc.vpc_flow_logs.cloudwatch_log_group_name
      traffic_dest_cidr      = local.subnets.public.cidr_block
    }
    tags = {
      Name = "GrafanaServer"
    }
  }

  default_tags = {
    Project = "traffic-analysis"
  }
}
