provider "aws" {
    region = "us-east-1"
}

module "ec2_instance"{
    source = "~/terraform-aws-ec2-instance" # path of secondary file
    ami_id = "ami-0583d8c7a9c35822c"
    instance_type = "t2.micro"  # Ensure this line is included
    instance_name = "Multi_inst"
    instance_count = var.instance_count
}
output "instance_ids" {
    value = module.ec2_isntance.instance_ids 

}
output "instance_public_ips" {
    value = module.ec2_isntance.instance_public_ips
  
}
