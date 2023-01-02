output "ec2_public_ip" {
  value = module.server.instance_ip.public_ip
}

