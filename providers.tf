terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.41.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = ">= 2.13.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = local.default_tags
  }
}

provider "grafana" {
  url  = "http://${module.grafana.public_ip}:3000"
  auth = format("%s:%s", local.grafana_server_details["admin_username"], local.grafana_server_details["admin_password"])
}
