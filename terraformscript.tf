

TERRAFORM SCIPTS


provider "aws" {
  region     = "us-east-1"
  access_key = "aws-access key"
  secret_key = "aws-secrets key"
}

# Create a VPC
resource "aws_vpc" "halimatterraform" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "halimatsubnet1" {
  vpc_id     = "${aws_vpc.halimatterraform.id}"
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "hallypublic1terra"
  }
}

resource "aws_subnet" "halimatsubnet2" {
  vpc_id     = "${aws_vpc.halimatterraform.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "hallyprivate1terra"
  }
}

resource "aws_internet_gateway" "haligw" {
  vpc_id = "${aws_vpc.halimatterraform.id}"

  tags = {
    Name = "haligw"
  }
}

resource "aws_route_table" "haliroute" {
  vpc_id = "${aws_vpc.halimatterraform.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.haligw.id}"
  }

  tags = {
    Name = "haliroute"
  }
}

resource "aws_route_table_association" "association1" {
  subnet_id      = aws_subnet.halimatsubnet1.id
  route_table_id = aws_route_table.haliroute.id
}

resource "aws_route_table_association" "association2" {
  subnet_id      = aws_subnet.halimatsubnet2.id
  route_table_id = aws_route_table.haliroute.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.halimatterraform.id}"

  resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.halimatterraform.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
