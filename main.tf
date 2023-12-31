
provider "aws" {
region = "us-east-2"
}

resource "aws_instance" "one" {
  ami             = "ami-09f85f3aaae282910"
  instance_type   = "t2.micro"
  key_name        = "fayazabc"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by fayaz sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-09f85f3aaae282910"
  instance_type   = "t2.micro"
  key_name        = "fayazabc"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by fayaz sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-09f85f3aaae282910"
  instance_type   = "t2.micro"
  key_name        = "fayazabc"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-09f85f3aaae282910"
  instance_type   = "t2.micro"
  key_name        = "fayazabc"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2b"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg"
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "devopsbyfayazterraserverbucket9988oo9988"
}

resource "aws_iam_user" "seven" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "us-east-2a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
