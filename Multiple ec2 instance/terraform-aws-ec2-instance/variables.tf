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