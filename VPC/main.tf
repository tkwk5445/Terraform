resource "aws_vpc" "project03_vpc" {
	cidr_block = var.vpc_cidr
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"

	tags = {
		Name = "project03_vpc"
	}
}

resource "aws_subnet" "project03_subnet_public1_ap_northeast_2a" {
	vpc_id = aws_vpc.project03_vpc.id
	cidr_block = var.public_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "project03_subnet_public1_ap_northeast_2a"
	}
}

resource "aws_subnet" "project03_subnet_public1_ap_northeast_2c" {
	vpc_id = aws_vpc.project03_vpc.id
	cidr_block = var.public_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "project03_subnet_public1_ap_northeast_2c"
	}
}

resource "aws_subnet" "project03_subnet_private1_ap_northeast_2a" {
	vpc_id = aws_vpc.project03_vpc.id
	cidr_block = var.private_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "project03_subnet_private1_ap_northeast_2a"
	}
}

resource "aws_subnet" "project03_subnet_private1_ap_northeast_2c" {
	vpc_id = aws_vpc.project03_vpc.id
	cidr_block = var.private_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "project03_subnet_private1_ap_northeast_2c"
	}
}

resource "aws_internet_gateway" "project03_igw" {
	vpc_id = aws_vpc.project03_vpc.id

	tags = {
		Name = "project03_igw"
	}
}

resource "aws_eip" "project03_eip" { 
	vpc = true
	depends_on = ["aws_internet_gateway.project03_igw"]
	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_nat_gateway" "project03_nat_public1_ap_northeast_2a" {
	allocation_id = aws_eip.project03_eip.id
	subnet_id = aws_subnet.project03_subnet_public1_ap_northeast_2a.id
	depends_on = ["aws_internet_gateway.project03_igw"]
	tags = {
		Name = "project03_nat_public1_ap_northeast_2a"
	}
}

resource "aws_default_route_table" "project03_public_rt" {
  default_route_table_id = aws_vpc.project03_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project03_igw.id
  }
  tags = {
    Name = "project03 public route table"
  }
}

resource "aws_route_table_association" "project03_public_rta_2a" {
  subnet_id      = aws_subnet.project03_subnet_public1_ap_northeast_2a.id
  route_table_id = aws_default_route_table.project03_public_rt.id
}

resource "aws_route_table_association" "project03-public_rta_2c" {
  subnet_id      = aws_subnet.project03_subnet_public1_ap_northeast_2c.id
  route_table_id = aws_default_route_table.project03_public_rt.id
}

resource "aws_route_table" "project03_private_rt" {
	vpc_id = aws_vpc.project03_vpc.id
	tags = {
		Name = "project03 private route table"
	}
}

resource "aws_route_table_association" "project03_private_rta_2a" {
  subnet_id      = aws_subnet.project03_subnet_private1_ap_northeast_2a.id
  route_table_id = aws_route_table.project03_private_rt.id
}

resource "aws_route_table_association" "project03_private_rta_2c" {
  subnet_id      = aws_subnet.project03_subnet_private1_ap_northeast_2c.id
  route_table_id = aws_route_table.project03_private_rt.id
}

resource "aws_route" "project03_private_rt_table" {
	route_table_id = aws_route_table.project03_private_rt.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = aws_nat_gateway.project03_nat_public1_ap_northeast_2a.id
}