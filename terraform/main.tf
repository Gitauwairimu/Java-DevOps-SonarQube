terraform {
  backend "s3" {
    bucket = "gitlab-terrafrom-state"
    key    = "terrafrom-state.tfstate"
    region = "us-east-2"
  }
}


provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name        = "${var.environment}-vpcTerraform"
    Environment = var.environment
  }
}




module "subnet" {
  source                   = "./modules/subnet"
  vpc_id                   = aws_vpc.myvpc.id
  public_subnet_cidr_block = var.public_subnet_cidr_block
  availability_zone        = var.availability_zone
  environment              = var.environment

}

module "server" {
  source              = "./modules/server"
  vpc_id              = aws_vpc.myvpc.id
  availability_zone   = var.availability_zone
  environment         = var.environment
  instance_type       = var.instance_type
  # public_key_location = var.public_key_location
  subnet_id           = module.subnet.subnet.id

}


resource "aws_s3_bucket_website_configuration" "devopsterraform" {
  bucket = aws_s3_bucket.xdevopsterraformx.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.xdevopsterraformx.id
  acl    = "public-read"
}


resource "aws_s3_bucket" "xdevopsterraformx" {
  bucket = "xdevopsterraformx"
  # aws_s3_bucket_website_configuration {
  #   index_document = "index.html"
  #   error_document = "404.html"
  # }

  # tags = {
  #   Name  = "${var.environment}-devopsterraform-${CI_PIPELINE_IID}.name"
  # }
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
        "Sid":"PublicReadForGetBucketObjects",
        "Effect":"Allow",
          "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::aws_s3_bucket.xdevopsterraformx/*"]
    }
  ]
}
EOF
}