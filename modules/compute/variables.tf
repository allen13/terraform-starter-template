variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the instances"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Example AMI ID, should be updated
}

variable "subnet_ids" {
  description = "The subnet IDs to deploy the instances into"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The security group IDs to attach to the instances"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# Variables for Auto Scaling Group (commented out by default)
# variable "min_size" {
#   description = "Minimum number of instances in the ASG"
#   type        = number
#   default     = 2
# }
# 
# variable "max_size" {
#   description = "Maximum number of instances in the ASG"
#   type        = number
#   default     = 6
# }
# 
# variable "desired_capacity" {
#   description = "Desired number of instances in the ASG"
#   type        = number
#   default     = 2
# }