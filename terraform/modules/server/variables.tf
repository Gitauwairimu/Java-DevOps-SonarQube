variable vpc_id {}

variable "environment" {
    type = string
    default = "dev"
}

# variable "public_key_location" {
#     type = string
#     default = "/home/andes/.ssh/id_rsa.pub"
# }

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable subnet_id {}

variable "availability_zone" {
    type = string
    default = "us-east-2c"
}
