output "instance_id" {
  description = "ID of the EC2 instance"
  value = [
    for instance in aws_instance.terraforminstance:
    instance.id
    
  ]
}
output "public_ip" {
  description = "public_ip of the EC2 instance"
  value = [
    for instance in aws_instance.terraforminstance:
    instance.public_ip
  ]
}