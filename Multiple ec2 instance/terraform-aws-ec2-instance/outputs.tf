output "instance_ids" {
    description = "The ID's of running Instances"
    value = aws_instance.multi-inst[*].id
  
}

output "instance_public_ips" {
    description = "The IP's of EC2 Instances"
    value = aws_instance.multi-inst[*].public_ip
  
}