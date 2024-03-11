resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = my vpc-01
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = vpc-0ee43c446833980b4

  tags = {
    Name = vpc-pub-igw
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = vpc-0ee43c446833980b4
  cidr_block              = "10.1.0.0/20"
  availability_zone       = "ap-south-1"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = vpc-0ee43c446833980b4
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = igw-0e7a802eb673b5376
  }

  tags = {
    Name = rou-pub-01
  }
}

resource "aws_route_table_association" "rt-association" {
  route_table_id = rtb-0a33595c0c10bb2bc
  subnet_id      = subnet-0759bbcc5a0e189a4
}

resource "aws_security_group" "security-group" {
  vpc_id      = vpc-0ee43c446833980b4
  description = "Allowing Jenkins, Sonarqube, SSH Access"

  ingress = [
    for port in [22, 8080, 9000, 65535] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      prefix_list_ids  = []
      security_groups  = []
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = launch-wizard-6
  }
}
