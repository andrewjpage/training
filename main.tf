#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-fcc4db98
#
# Your subnet ID is:
#
#     subnet-092c0d72
#
# Your security group ID is:
#
#     sg-a2c975ca
#
# Your Identity is:
#
#     terraform-training-bat
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "num_webs" {
  default = "3"
}

variable "aws_region" {
  type    = "string"
  default = "eu-west-2"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  ami                    = "ami-fcc4db98"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-092c0d72"
  vpc_security_group_ids = ["sg-a2c975ca"]

  tags {
    name     = "web ${count.index +1 }/ ${var.num_webs}"
    dept     = "pathogens"
    me       = "abc"
    Identity = "terraform-training-bat"
  }
}

terraform {
  backend "atlas" {
    name = "andrewjpage/training"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
