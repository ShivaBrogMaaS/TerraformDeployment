terraform {
backend "s3" {
bucket = "shivacorent"
key    = "variables.tfstate"
region = "us-east-1"
}
}