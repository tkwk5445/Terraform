# VPC 리소스 정의
resource "aws_vpc" "project03_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "project03_vpc"
  }
}

# Public 서브넷 정의
resource "aws_subnet" "public" {
  count = length(var.public_subnet)

  vpc_id            = aws_vpc.project03_vpc.id
  cidr_block        = var.public_subnet[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "project03_subnet_public${count.index + 1}_${var.azs[count.index]}"
  }
}

# Private 서브넷 정의
resource "aws_subnet" "private" {
  count = length(var.private_subnet)

  vpc_id            = aws_vpc.project03_vpc.id
  cidr_block        = var.private_subnet[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "project03_subnet_private${count.index + 1}_${var.azs[count.index]}"
  }
}

# Internet Gateway 리소스 정의
resource "aws_internet_gateway" "project03_igw" {
  vpc_id = aws_vpc.project03_vpc.id

  tags = {
    Name = "project03_igw"
  }
}

# Elastic IP 리소스 정의
resource "aws_eip" "project03_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.project03_igw]

  tags = {
    Name = "project03_eip"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# NAT Gateway 리소스 정의
resource "aws_nat_gateway" "public_nat" {
  count = length(var.azs)

  allocation_id = aws_eip.project03_eip.id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.project03_igw]

  tags = {
    Name = "project03_nat_public${count.index + 1}_${var.azs[count.index]}"
  }
}

# Public 서브넷에 대한 기본 라우팅 테이블 정의
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.project03_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project03_igw.id
  }

  tags = {
    Name = "project03_public_route_table"
  }
}

# Public 서브넷과 기본 라우팅 테이블의 연결 정의
resource "aws_route_table_association" "public_rta" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_default_route_table.public_rt.id
}

# Private 서브넷에 대한 라우팅 테이블 정의
resource "aws_route_table" "private_rt" {
  count = length(var.azs)

  vpc_id = aws_vpc.project03_vpc.id

  tags = {
    Name = "project03_private_route_table${count.index + 1}"
  }
}

# Private 서브넷과 라우팅 테이블의 연결 정의
resource "aws_route_table_association" "private_rta" {
  count = length(var.azs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

# Private 서브넷에 대한 NAT Gateway에 대한 라우팅 정의
resource "aws_route" "private_nat" {
  count = length(var.azs)

  route_table_id         = aws_route_table.private_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.public_nat[count.index].id
}
