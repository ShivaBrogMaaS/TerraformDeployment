terraform {
backend "s3" {
bucket = "shiva"
key    = "variables.tfstate"
region = "us-east-1"
}
}
