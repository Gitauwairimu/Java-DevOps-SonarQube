variable "vpc_id" {}

variable "public_subnet_cidr_block" {
    type = string
    default = "10.0.20.0/24"
}


variable "availability_zone" {
    type = string
    default = "us-east-2c"
}

variable "environment" {
    type = string
    default = "dev"
}


