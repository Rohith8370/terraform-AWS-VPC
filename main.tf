#creating aws vpc resource

resource "aws_vpc" "Rohith" {
  cidr_block           = var.vpc_info.cidr_block
  enable_dns_hostnames = var.vpc_info.enable_dns_hostnames
  tags = {
    Name = var.vpc_info.name
  }
}

#creating aws public subnet resource

resource "aws_subnet" "public" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.Rohith.id
  availability_zone = var.public_subnet[count.index].availability_zone
  cidr_block        = var.public_subnet[count.index].cidr_block
  depends_on        = [var.public_subnet]
  tags = {
    Name      = var.public_subnet[count.index].name
    describes = "this resource describes about the public subnet"

  }

}

#creating aws private subnet resource

resource "aws_subnet" "private" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.Rohith.id
  availability_zone = var.private_subnet[count.index].availability_zone
  cidr_block        = var.private_subnet[count.index].cidr_block
  depends_on        = [var.private_subnet]
  tags = {
    Name      = var.private_subnet[count.index].name
    describes = "this resource describes about the private subnet"
  }

}

#creating aws public internet gateway resource

resource "aws_internet_gateway" "gateways" {
  vpc_id = aws_vpc.Rohith.id
  tags = {
    Name = "main"
  }
}

#creating aws public route_table resource

resource "aws_route_table" "public" {
  count  = length(var.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.Rohith.id
  tags = {

    Name = "public"
  }
}

#creating aws private route_table resource

resource "aws_route_table" "private" {
  count      = length(var.private_subnet) > 0 ? 1 : 0
  vpc_id     = aws_vpc.Rohith.id
  depends_on = [aws_vpc.Rohith]
  tags = {
    Name = "private"
  }
}

#creating aws public route table association resource

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
  depends_on     = [aws_route_table.public, aws_subnet.public]
}

#creating aws private route table association resource

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet)
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private[count.index].id
  depends_on     = [aws_route_table.private, aws_subnet.private]
}

# creating for aws route table connecting for the network connections

resource "aws_route" "main" {
  count                  = length(aws_route_table.public) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateways.id
  depends_on             = [aws_vpc.Rohith]

}

