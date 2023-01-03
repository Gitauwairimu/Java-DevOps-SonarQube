resource "aws_subnet" "subnet" {
    vpc_id = var.vpc_id
    cidr_block = var.public_subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
        Name = "${var.environment}-PublicSubnet"
    }
}

resource "aws_route_table" "rt-table" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
        
    }
    tags = {
            Name = "${var.environment}-rt-table"
        }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = var.vpc_id
    tags = {
            Name = "${var.environment}-igw"
        }
}

resource "aws_route_table_association" "rta" {
    route_table_id = aws_route_table.rt-table.id
    subnet_id = aws_subnet.subnet.id
}
