data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [my vpc-01]
  }
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "tag:Name"
    values = [vpc-pub-iwg]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = [pub-sub-02]
  }
}

data "aws_security_group" "sg-default" {
  filter {
    name   = "tag:Name"
    values = [launch-wizard-6]
  }
}

resource "aws_subnet" "pub-sub-02" {
  vpc_id                  = vpc-0ee43c446833980b4
  cidr_block              = "10.1.16.0/20"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = pub-sub-02
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = vpc-0ee43c446833980b4
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = igw-0e7a802eb673b5376
  }

  tags = {
    Name = rou-pub-01
  }
}

resource "aws_route_table_association" "rt-association2" {
  route_table_id = rtb-0a33595c0c10bb2bc
  subnet_id      = subnet-0f9bf78308d866397
}
