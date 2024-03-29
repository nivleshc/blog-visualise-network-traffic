# create the VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc["cidr_block"]
  instance_tenancy = var.vpc["instance_tenancy"]

  tags = var.vpc["tags"]
}

# create the private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet["cidr_block"]
  availability_zone = var.private_subnet["availability_zone"]

  tags = var.private_subnet["tags"]
}

# create the public subnet. This is where the Grafana Server will be installed
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet["cidr_block"]
  availability_zone = var.public_subnet["availability_zone"]

  map_public_ip_on_launch = true

  tags = var.public_subnet["tags"]
}

# create the internet gateway so that we can connect to the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}

# create a private route table. This will be associated with the private subnet
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private route table"
  }
}

# create a public route table. This will be associated with the public subnet
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public route table"
  }
}

# associate the private route table with the private subnet
resource "aws_route_table_association" "private-rt" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private-rt.id
}

# associate the public route table with the public subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id
}
