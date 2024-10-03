vpc_info = {
  cidr_block           = "192.168.0.0/16"
  name                 = "Rohith"
  enable_dns_hostnames = true
}

public_subnet = [{
  cidr_block        = "192.168.1.0/24"
  availability_zone = "ap-south-1a"
  name              = "web-1"
  },
  {
    cidr_block        = "192.168.2.0/24"
    availability_zone = "ap-south-1a"
    name              = "web-2"
}]

private_subnet = [
  {
    cidr_block        = "192.168.3.0/24"
    availability_zone = "ap-south-1a"
    name              = "app-1"
  },
  {
    cidr_block        = "192.168.4.0/24"
    availability_zone = "ap-south-1a"
    name              = "app-2"
  },
  {
    cidr_block        = "192.168.5.0/24"
    availability_zone = "ap-south-1a"
    name              = "db-1"
  },
  {
    cidr_block        = "192.168.6.0/24"
    availability_zone = "ap-south-1a"
    name              = "db-2"
  }
]

security_group = {
  name = "web"
}

web_ingress = [{
  name        = "web"
  ip_protocol = "Tcp"
  port_range  = 80
  source      = "0.0.0.0/0"
  }, {
  name        = "web"
  ip_protocol = "Tcp"
  port_range  = 22
  source      = "0.0.0.0/0"
  },
]

app_ingress = [{

  name        = "app"
  ip_protocol = "Tcp"
  port_range  = 8000
  source      = "10.100.0.0/16"
  }
]

db_ingress = [{

  name        = "db"
  ip_protocol = "Tcp"
  port_range  = 3306
  source      = "10.100.0.0/16"
  }
]