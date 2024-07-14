// 1. Create VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ankh-vpc"
  }
}

variable "vpc_availability_zones" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-west-2a", "us-west-2b"]
}

// 2. Create subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  count             = length(var.vpc_availability_zones)
  cidr_block        = cidrsubnet(aws_vpc.custom_vpc.cidr_block, 8, count.index + 1)
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = {
    Name = "Public subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  count             = length(var.vpc_availability_zones)
  cidr_block        = cidrsubnet(aws_vpc.custom_vpc.cidr_block, 8, count.index + 3)
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = {
    Name = "Private subnet ${count.index + 1}"
  }
}

// 3. Internet gateway
resource "aws_internet_gateway" "igw_vpc" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "Ankh Internet Gateway"
  }
}

// 4. Routing table for public subnet
resource "aws_route_table" "ankh_route_table_public_subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc.id
  }
  tags = {
    Name = "Public subnet Routing table"
  }
}

// 5. Association between routing table & internet gateway
resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.ankh_route_table_public_subnet.id
  count          = length(var.vpc_availability_zones)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
}

// 6. Elastic IP
resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw_vpc]
}

// 7. NAT Gateway
resource "aws_nat_gateway" "ankh-nat-gateway" {
  subnet_id     = element(aws_subnet.private_subnet[*].id, 0)
  allocation_id = aws_eip.eip.id
  depends_on    = [aws_internet_gateway.igw_vpc]
  tags = {
    Name = "Ankh Nat Gateway"
  }
}

// 8. Routing table for private subnet
resource "aws_route_table" "ankh_route_table_private_subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc.id
  }
  tags = {
    Name = "Private subnet Routing table"
  }
}

// 9. Association between routing table & internet gateway
resource "aws_route_table_association" "private_subnet_association" {
  route_table_id = aws_route_table.ankh_route_table_private_subnet.id
  count          = length(var.vpc_availability_zones)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
}
