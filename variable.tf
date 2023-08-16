variable "bucketname" {
type = string
description="It is used for S3 service"
}
variable "key_name" {
type = string
description="It is used for Accessing the VM's"
}
variable "ami_id" {
type = string
description="It is used for AMI_ID in EC2 service"
}


variable "instance_type" {
type = string
default = "t3a.medium"
description="It is used for Instance type in EC2 service"
}
variable "user_data" {
description = "The user data to provide when launching the instance. "
type        = string
default     = "user-data.sh"
}

variable filename {
default = "inputs.csv"
}
variable "region" {
type = string
default = "us-east-1"
description="It is used to specify region"
}