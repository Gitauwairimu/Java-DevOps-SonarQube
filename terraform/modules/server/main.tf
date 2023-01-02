resource "aws_security_group" "sg" {
    vpc_id = var.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
        Name = "${var.environment}-sg"
    }
}

data "aws_ami" "amazon-ami-latest" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn-ami-hvm-*-x86_64-gp2"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

#optional if using locally generated key
# resource "aws_key_pair" "local-sshkeygen-ssh-key" {
#     key_name = "circleci"
#     #public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCgXj0DFO2n01q0iGOlKizKSrapv49lPTAjW2D8t/UDRTVrsT6JKwsIszpYJsdlTaJp2eoynzOgl8dp0rsS7exDql/2ql87/GjrgpWc0HjIgRObP1NKo3CiChT+RAFpocDr1cNZDdsKCAPsb04vK74cO3U3EpKH2SJ2rftIGwisAMkH3xJih2H79YN7h+BY1RH2FYSHldnOXG2J9pMApjakMSphA3+0IfXWCMjSkXCzFJ0l44QGWcY3o6qpr7yy5Ig4R0GsXfSStlCqdW1iFttg0ACdkh3TUm0CzY74tq+kztisQS2qWI9fGNeSZ9gpCD44ZI38vFi9EC2h+U5+Joso0kaYRdbtOkZLmg2Cy8q+605XPFyJCu4Mk3RzCSIodMorVl8Ump95kYLS6M6YhMtx2cwaAHYnzfqKSXuJ1kYYNLnGcaBT5Arq+ST2cH591AFoXgD1zZJX+4PDQib6P9kbxx5mhk2+I2+VbTY8bmFYxezC2zRL5z9KaGJ8Rnidy4KgRsNUwKvKKY7SkKRtkhQfbH4/y0Oco0BhAC8UDnhIFRhIKFu1m0mt9pttLBVXXcLJfHL+/aslVFBVefy4Gbj4vL/EKdzbYP+3ZeO9zL1ll/kWJ6AE/J2uY+/SEUynNDP6NwMSIocfRwCA8PmFCpjQqi7Apn9HeRFM5rUUdDPvCw== gitauwairimu@gmail.com"
#     # public_key = file(var.public_key_location)
# }

resource "aws_instance" "server-instance" {
    ami = data.aws_ami.amazon-ami-latest.id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.sg.id]
    availability_zone = var.availability_zone
    associate_public_ip_address = true
    
    key_name = "circlecikey"
    # key_name = aws_key_pair.local-sshkeygen-ssh-key.key_name

    user_data = file("startup-script.sh")

    tags = {
        Name = "${var.environment}server-instance"
    }
}
