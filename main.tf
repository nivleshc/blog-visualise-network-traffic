# create a resource group. This will allow us to easily see all resources
# provisioned by this project using the AWS Management Console
resource "aws_resourcegroups_group" "project_resources" {
  name        = "${local.default_tags["Project"]}-resources"
  description = format("%s %s %s", "All resources provisioned by the", local.default_tags["Project"], "project")

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported" 
  ],
  "TagFilters": [
    {
      "Key": "Project",
      "Values": ["${local.default_tags["Project"]}"]
    }
  ]
}
JSON
  }

  tags = {
    Name = "${local.default_tags["Project"]}-resources"
  }
}

# create the vpc 
module "vpc" {
  source = "./vpc"

  vpc            = local.vpc
  private_subnet = local.subnets["private"]
  public_subnet  = local.subnets["public"]
}
