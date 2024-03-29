variable "vpc" {
  description = "Configuration values for the VPC"
  type = object({
    cidr_block       = string
    instance_tenancy = string

    vpc_flow_logs = object({
      cloudwatch_log_group_name              = string
      cloudwatch_log_group_retention_in_days = number
      traffic_to_capture                     = string
    })

    tags = map(string)
  })
}

variable "private_subnet" {
  description = "Configuration values for the private subnet"
  type = object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  })
}

variable "public_subnet" {
  description = "Configuration values for the public subnet"
  type = object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  })
}