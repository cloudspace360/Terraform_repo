provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source        = "/root/terraform-aws-ec2-isntance"  # Adjust the path if needed
  ami_id        = "ami-0583d8c7a9c35822c"         # Replace with your desired AMI ID
  instance_type = "t2.micro"                      # Replace with your desired instance type
  instance_name = "test_ec2"              # Replace with your desired instance name
}
output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "instance_public_ip" {
  value = module.ec2_instance.instance_public_ip
}