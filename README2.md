#Terraform 
Terraform- Multi_Instance 

My-terraform-project

main.tf 

provider "aws" {
    region = "us-east-1"
}

module "ec2_instance"{
    source = "/root/multiple_instance/terraform-aws-ec2-instance" # path of secondary file
    ami_id = "ami-0583d8c7a9c35822c"
    instance_type = "t2.micro"
    instance_name = "Multi_inst"
    instance_count = var.instance_count
}
output "instance_ids" {
    value = module.ec2_instance.instance_ids

}
output "instance_public_ips" {
    value = module.ec2_instance.instance_public_ips

}

variables.tf

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

 terraform.tfvars
ami_id        = "ami-0583d8c7a9c35822c"
instance_name = "Multi_inst"
instance_type = "t2.micro"
instance_count = 3






Terraform-aws-ec2-instance

main.tf
resource "aws_instance" "multi-inst" {
    count = var.instance_count
    ami   = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "${var.instance_name}-${count.index}"
    }
}

variables.tf
variable "ami_id" {
    description = "The AMI ID to use which instance"
    type = string

}

variable "instance_type" {
    description = "The Instance type specifies which instance"
    type = string

}

variable "instance_name" {
    description = "Multiple Instance"
    type = string

}

variable "instance_count" {
    description = "Multiple-Instance"
    type = string
    default = 1

}





outputs.tf

output "instance_ids" {
    description = "The ID's of running Instances"
    value = aws_instance.multi-inst[*].id

}

output "instance_public_ips" {
    description = "The IP's of EC2 Instances"
    value = aws_instance.multi-inst[*].public_ip

}




# terraform destroy








