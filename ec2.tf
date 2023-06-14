data "aws_ami" "amazon-linux-2" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# data "aws_key_pair" "main-key" {
#   include_public_key = true

#   filter {
#     name   = "tag:Name"
#     values = ["main-key"]
#   }
# }


resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  # key_name      = data.aws_key_pair.main-key.key_name

  # network_interface {
  #   network_interface_id = aws_network_interface.primary_network_interface.id
  #   device_index         = 0
  # }

  user_data              = file("setup_jenkins.sh")
  iam_instance_profile   = aws_iam_instance_profile.access_ec2_terminal.name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "Jenkins Master"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["14.237.3.65/32"]
    # ipv6_cidr_blocks = [aws_vpc.main_vpc.ipv6_cidr_block]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main_vpc.ipv6_cidr_block]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["14.237.3.65/32"]
    # ipv6_cidr_blocks = [aws_vpc.main_vpc.ipv6_cidr_block]
  }

  # ingress {
  #   description = "Allow SSH"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["14.237.3.65/32"]
  #   # ipv6_cidr_blocks = [aws_vpc.main_vpc.ipv6_cidr_block]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# resource "aws_internet_gateway" "gw" {
#   vpc_id = module.aws_vpc.vpc_id

#   tags = {
#     Name = "main"
#   }
# }

# resource "aws_network_interface" "primary_network_interface" {
#   subnet_id       = module.aws_vpc.public_subnet
#   private_ips     = ["173.16.12.140"]
#   security_groups = [aws_security_group.allow_tls.id]

#   tags = {
#     Name = "primary_network_interface"
#   }
# }

# module "aws_vpc" {
#   source   = "./modules/vpc"
#   vpc_cidr = "173.16.12.0/24"
# }