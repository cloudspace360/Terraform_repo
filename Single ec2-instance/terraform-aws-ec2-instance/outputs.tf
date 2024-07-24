output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.test_ec2.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.test_ec2.public_ip
}