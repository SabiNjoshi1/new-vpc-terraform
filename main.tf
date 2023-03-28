# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "sabin" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Sabin VPC"
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "sabin-public" {
  vpc_id                  = aws_vpc.sabin.id
  cidr_block              = "${var.public-subnet}"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-1a"

  tags = {
    Name = "Sabin Public Subnet"
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "sabin-gw" {
  vpc_id = aws_vpc.sabin.id

  tags = {
    Name = "Sabin IGW"
  }
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.sabin.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sabin-gw.id
  }

  tags = {
    Name = "Sabin Public Route Table"
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "sabin-public-route-table-association" {
  subnet_id      = aws_subnet.sabin-public.id
  route_table_id = aws_route_table.public-route-table.id
}

# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "sabin-private" {
  vpc_id                   = aws_vpc.sabin.id
  cidr_block               = "${var.private-subnet}"
  availability_zone        = "us-west-1a"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Sabin Private Subnet"
  }
}

resource "aws_eip" "sabin-ebl" {
  vpc      = true
}

resource "aws_nat_gateway" "sabin-gateway" {
  allocation_id = aws_eip.sabin-ebl.id
  subnet_id     = aws_subnet.sabin-public.id

  tags = {
    Name = "Sabin NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.sabin-gw]
}



