variable "vpc_info" {
  type = object({
    name                 = string
    cidr_block           = string
    enable_dns_hostnames = bool
  })
}

variable "public_subnet" {
  type = list(object({
    name              = string
    availability_zone = string
    cidr_block        = string
  }))
}

variable "private_subnet" {
  type = list(object({
    name              = string
    availability_zone = string
    cidr_block        = string
  }))
}

variable "security_group" {
  type = object({
    name = string
  })

}

variable "web_ingress" {
  type = list(object({
    name        = string
    ip_protocol = string
    port_range  = number
    source      = string
  }))

}

variable "app_ingress" {
  type = list(object({
    name        = string
    ip_protocol = string
    port_range  = number
    source      = string
  }))

}

variable "db_ingress" {
  type = list(object({
    name        = string
    ip_protocol = string
    port_range  = number
    source      = string
  }))

}
