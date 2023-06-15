provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}


resource "aws_instance" "instance1" {
  ami           = "ami-002843b0a9e09324a"  # Ubuntu 20.04 LTS AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = "singaporekey"

  # Other configuration options for instance1
}

resource "aws_instance" "instance2" {
  ami           = "ami-002843b0a9e09324a"  # Ubuntu 20.04 LTS AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = "singaporekey"
  
  # Other configuration options for instance2
}

resource "aws_instance" "instance3" {
  ami           = "ami-002843b0a9e09324a"  # Ubuntu 20.04 LTS AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_2.id
  key_name      = "singaporekey"

  # Other configuration options for instance3
}

resource "aws_instance" "instance4" {
  ami           = "ami-002843b0a9e09324a"  # Ubuntu 20.04 LTS AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_2.id
  key_name      = "singaporekey"

  # Other configuration options for instance4
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}


#https://www.coachdevops.com/2020/05/automate-docker-builds-using-jenkins.html