resource "aws_vpc" "terraformvpc" {
cidr_block = "192.168.0.0/24"
tags = {
Name = "MaaS_RND_VPC"
}
}

resource "aws_subnet" "terraformsubnet" {
vpc_id            = aws_vpc.terraformvpc.id
cidr_block        = "192.168.0.0/24"
availability_zone = "us-east-1a"
map_public_ip_on_launch=true
tags = {
Name = "MaaS_RND_SUBNET1"
}
}

resource "aws_internet_gateway" "igw" { 
vpc_id = aws_vpc.terraformvpc.id
tags = { 
Name = "MaaS_RND_GATEWAY" 
} 
}

resource "aws_default_route_table" "terraformrtb" {
default_route_table_id = aws_vpc.terraformvpc.default_route_table_id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw.id
}
tags = {
Name = "MaaS_RND_RTB"
}
}
resource "aws_default_security_group" "default" {
vpc_id = aws_vpc.terraformvpc.id
ingress {
protocol  = "tcp"
self      = true
from_port = 22
to_port   = 22
cidr_blocks = ["49.205.76.104/30","182.72.136.80/30"]
}
ingress {
protocol  = "tcp"
self      = true
from_port = 3389
to_port   = 3389
cidr_blocks = ["49.205.76.104/30","182.72.136.80/30"]
}
ingress {
protocol  = "tcp"
self      = true
from_port = 3389
to_port   = 3389
cidr_blocks = ["49.205.76.104/30","182.72.136.80/30"]
}
egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "RND_SECGRP"
}
}
#Loading CSV file as input
locals {
instances = csvdecode(file(var.filename))
}

resource "aws_instance" "terraforminstance" {
for_each = { for inst in local.instances : inst.local_id => inst }
ami           = each.value.ami
availability_zone = each.value.availability_zone
instance_type = each.value.instance_type
subnet_id = aws_subnet.terraformsubnet.id
user_data = file(each.value.user_data)
key_name   = "${var.key_name}"
tags = {
Name = "MaaS_Linux_VM"	
}
}







# resource "aws_ebs_volume" "example" {
# for_each = { for inst in local.instances : inst.local_id => inst }
# availability_zone = each.value.availability_zone
# size              = each.value.size
# type    = each.value.type
# }