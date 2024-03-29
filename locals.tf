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

  default_tags = {
    Project = "traffic-analysis"
  }
}