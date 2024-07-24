# Terraform_repo
TERRAFORM INSTALLATION

Sure, I can help with that! Here's a step-by-step guide to installing Terraform on RHEL 9, along with some key insights about Terraform.

### **Installing Terraform on RHEL 9**

1. **Update Your System:**
   Ensure your system is up to date.
   ```sh
   sudo dnf update -y
   ```

2. **Install the HashiCorp GPG Key:**
   ```sh
   sudo dnf install -y dnf-plugins-core
   sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
   ```

3. **Install Terraform:**
   ```sh
   sudo dnf install -y terraform
   ```

4. **Verify Installation:**
   ```sh
   terraform -v
   ```
____________________________________________________________________________


    1  yum install yum-utils
    2  yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    3  yum install terraform
    4  terraform -v
    5  terraform --version

____________________________________________________________________________






### **Key Insights About Terraform**

1. **Infrastructure as Code (IaC):**
   - Terraform allows you to define infrastructure using a high-level configuration language called HashiCorp Configuration Language (HCL). 
   - Infrastructure is described in plain text files, which can be version-controlled using tools like Git.

2. **Provider Agnostic:**
   - Terraform supports a wide range of cloud providers, such as AWS, Azure, Google Cloud, and more.
   - This makes it easy to manage multi-cloud environments with a single tool.

3. **State Management:**
   - Terraform uses a state file to keep track of the current state of your infrastructure.
   - This state file allows Terraform to understand what resources exist and make informed decisions when updating your infrastructure.

4. **Execution Plan:**
   - Terraform generates an execution plan (also known as a "plan") which shows what actions will be taken before making any changes.
   - This helps you understand the impact of your changes before applying them.

5. **Resource Graph:**
   - Terraform builds a dependency graph of all resources, enabling it to create and modify resources efficiently in the correct order.
   - This helps optimize and parallelize resource creation and updates.

6. **Modules:**
   - Modules are reusable configurations that can be used to encapsulate and share common patterns.
   - They promote code reuse and simplify complex configurations.

7. **Provisioners:**
   - Provisioners can be used to execute scripts or commands on your resources.
   - They are useful for bootstrapping instances, running configuration management tools, and more.

### **Getting Started with Terraform**

1. **Create a Configuration File:**
   - Create a directory for your Terraform configuration files.
   - Inside this directory, create a file with the `.tf` extension (e.g., `main.tf`).

2. **Define Resources:**
   - Use HCL to define the resources you want to create. For example, to create an AWS S3 bucket:
     ```hcl
     provider "aws" {
       region = "us-west-2"
     }

     resource "aws_s3_bucket" "example" {
       bucket = "my-unique-bucket-name"
       acl    = "private"
     }
     ```

3. **Initialize Terraform:**
   - Run the `terraform init` command to initialize your configuration. This command downloads the necessary provider plugins.
     ```sh
     terraform init
     ```

4. **Generate and Review an Execution Plan:**
   - Run `terraform plan` to see what actions Terraform will take to achieve the desired state.
     ```sh
     terraform plan
     ```

5. **Apply the Configuration:**
   - Run `terraform apply` to apply the changes and create your resources.
     ```sh
     terraform apply
     ```

6. **Manage State:**
   - Terraform automatically manages the state file, but you can also use remote state storage to share state among team members.

By following these steps, you should be able to install and start using Terraform on RHEL 9. If you have any specific questions or need further assistance, feel free to ask!



TERRAFORM EC2 INSTANCE: 

After installation of terraform

 mkdir terraform-aws-ec2-instance 


Sure, let's break it down into more detailed steps. We'll start by explaining the concept of a Terraform module and then walk through creating and using one step by step.

### **What is a Terraform Module?**

A Terraform module is a set of Terraform configuration files in a single directory. Modules are used to encapsulate and organize our code to make it reusable and manageable. They can be shared across different projects and teams.

### **Creating a Terraform Module to Launch an EC2 Instance**

Let's create a single module to launch an EC2 instance in AWS.

#### **Step 1: Create a Directory for the Module**

Create a directory to store your module's files. This directory will contain all the configuration files for the module.

```sh
mkdir terraform-aws-ec2-instance
cd terraform-aws-ec2-instance
```

#### **Step 2: Create the Configuration Files**

In this directory, create the following three files: `main.tf`, `variables.tf`, and `outputs.tf`.

1. **`main.tf`:** This file contains the actual resource definitions.

   ```hcl
   resource "aws_instance" "example" {
     ami           = var.ami_id
     instance_type = var.instance_type

     tags = {
       Name = var.instance_name
     }
   }
   ```

   - **`resource "aws_instance" "example"`**: This defines an AWS EC2 instance resource named "example".
   - **`ami = var.ami_id`**: This sets the AMI ID for the instance, which will be passed in as a variable.
   - **`instance_type = var.instance_type`**: This sets the instance type, also passed in as a variable.
   - **`tags`**: This assigns a name tag to the instance, passed in as a variable.

2. **`variables.tf`:** This file defines the variables used in the module.

   ```hcl

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the instance"
  type        = string
}

variable "instance_name" {
  description = "The name to assign to the instance"
  type        = string
 }
   ```

   - **`variable "ami_id"`**: Defines a variable for the AMI ID with a description and type.
   - **`variable "instance_type"`**: Defines a variable for the instance type.
   - **`variable "instance_name"`**: Defines a variable for the instance name.

3. **`outputs.tf`:** This file defines the outputs of the module.

   ```hcl
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.example.public_ip
}
   ```

   - **`output "instance_id"`**: Outputs the ID of the EC2 instance.
   - **`output "instance_public_ip"`**: Outputs the public IP of the EC2 instance.

#### **Step 3: Use the Module in Your Main Configuration**

Now that the module is created, you can use it in your main Terraform configuration.

1. **Create a new directory for your main configuration:**

   ```sh
   mkdir my-terraform-project
   cd my-terraform-project
   ```

2. **Create a `main.tf` file in this directory:**

   ```hcl
provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source        = "../terraform-aws-ec2-instance"  # Adjust the path if needed
  ami_id        = "ami-0583d8c7a9c35822c"         # Replace with your desired AMI ID
  instance_type = "t2.micro"                      # Replace with your desired instance type
  instance_name = "example-instance"              # Replace with your desired instance name
}


output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "instance_public_ip" {
  value = module.ec2_instance.instance_public_ip
}
   ```

   - **`provider "aws"`**: Configures the AWS provider with the desired region.
   - **`module "ec2_instance"`**: Uses the module you created, passing in the necessary variables.
   - **`output "instance_id"`**: Outputs the instance ID from the module.
   - **`output "instance_public_ip"`**: Outputs the public IP from the module.

#### **Step 4: Initialize and Apply the Configuration**

1. **Initialize Terraform:**
   This command initializes your working directory, downloading the necessary provider plugins.

   ```sh
   terraform init
   ```

2. **Plan the Infrastructure:**
   This command creates an execution plan, showing what actions Terraform will take.

   ```sh
   terraform plan
   ```

3. **Apply the Configuration:**
   This command applies the changes required to reach the desired state of the configuration.

   ```sh
   terraform apply
   ```

4. **Destroy the Infrastructure (when no longer needed):**
   This command destroys the resources created by Terraform.

   ```sh
   terraform destroy
   ```

### **Summary**

By following these steps, you've created a reusable Terraform module to launch an EC2 instance and used it in your main configuration. The module encapsulates the resource definition, making it easy to reuse and manage in different projects. If you have any further questions or need additional assistance, feel free to ask!

AWS Credentials File: Configure the AWS credentials file located at ~/.aws/credentials.
ini
Copy code
[default]
aws_access_key_id = your-access-key-id
aws_secret_access_key = your-secret-access-key  

Ensure the file has the correct permissions:
sh
Copy code
chmod 600 ~/.aws/credentials





