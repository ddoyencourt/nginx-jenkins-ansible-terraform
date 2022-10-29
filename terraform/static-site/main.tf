terraform {
    required_version = "1.3.3"
}

provider "aws" {
    region = var.region
    profile = var.profile
}

resource "aws_instance" "web-site" {
    ami = "ami-09d3b3274b6c5d4aa"
    instance_type = "t2.micro"
    key_name = "sre_test"
    vpc_security_group_ids = [ "sg-0c8422356a36103f2" ]
    tags = {
        Nane = var.name
        group = var.group
        }
}
