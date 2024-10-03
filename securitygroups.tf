
#creating a security group for web 

resource "aws_security_group" "web" {
  vpc_id      = aws_vpc.Rohith.id
  description = "this is about the aws security group of web "
  tags = {
    Name = " web"
  }
}
#web ingress rule
resource "aws_vpc_security_group_ingress_rule" "web" {
  count             = length(var.web_ingress)
  security_group_id = aws_security_group.web.id
  ip_protocol       = var.web_ingress[count.index].ip_protocol
  cidr_ipv4         = aws_vpc.Rohith.cidr_block
  from_port         = var.web_ingress[count.index].port_range
  to_port           = var.web_ingress[count.index].port_range
  depends_on        = [aws_security_group.web]

  tags = {
    portrange = var.web_ingress[count.index].port_range
    source    = var.web_ingress[count.index].source
    Name      = var.web_ingress[count.index].name

  }
}

#web egrees rules
resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

}

#creating a security group for app
resource "aws_security_group" "app" {
  vpc_id      = aws_vpc.Rohith.id
  description = "this is about the aws security group of app "
  tags = {
    Name = " app"
  }
}

#app ingress rule
resource "aws_vpc_security_group_ingress_rule" "App" {
  count             = length(var.app_ingress)
  security_group_id = aws_security_group.app.id
  ip_protocol       = var.app_ingress[count.index].ip_protocol
  cidr_ipv4         = aws_vpc.Rohith.cidr_block
  from_port         = var.app_ingress[count.index].port_range
  to_port           = var.app_ingress[count.index].port_range
  depends_on        = [aws_security_group.app]

  tags = {
    portrange = var.app_ingress[count.index].port_range
    source    = var.app_ingress[count.index].source
    Name      = var.app_ingress[count.index].name

  }
}

#app egrees rules
resource "aws_vpc_security_group_egress_rule" "app" {
  security_group_id = aws_security_group.app.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

}

#creating a security group for db
resource "aws_security_group" "db" {
  vpc_id      = aws_vpc.Rohith.id
  description = "this is about the aws security group of db "
  tags = {
    Name = " db"
  }
}

#db ingress rule
resource "aws_vpc_security_group_ingress_rule" "db" {
  count             = length(var.db_ingress)
  security_group_id = aws_security_group.db.id
  ip_protocol       = var.db_ingress[count.index].ip_protocol
  cidr_ipv4         = aws_vpc.Rohith.cidr_block
  from_port         = var.db_ingress[count.index].port_range
  to_port           = var.db_ingress[count.index].port_range
  depends_on        = [aws_security_group.db]

  tags = {
    portrange = var.db_ingress[count.index].port_range
    source    = var.db_ingress[count.index].source
    Name      = var.db_ingress[count.index].name

  }
}

#db egrees rules
resource "aws_vpc_security_group_egress_rule" "db" {
  security_group_id = aws_security_group.db.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

}

resource "aws_instance" "web" {
  
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name      = "RohithPublic"
  subnet_id     = aws_subnet.public[0].id
  associate_public_ip_address = true
  tags = {
    Name = "Terraform_Instance"
  }

} 