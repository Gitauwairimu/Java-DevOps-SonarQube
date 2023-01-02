variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.20.0/24"
}

variable "availability_zone" {
  type    = string
  default = "us-east-2c"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# variable "public_key_location" {
#   type    = string
#   default = "/home/andes/.ssh/id_rsa.pub"
# }
