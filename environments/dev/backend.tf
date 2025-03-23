terraform {
  # Example S3 backend configuration - uncomment and modify as needed
  # backend "s3" {
  #   bucket         = "terraform-states-dev"
  #   key            = "terraform.tfstate"
  #   region         = "us-west-2"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks-dev"
  # }
  
  # Example Azure backend configuration - uncomment and modify as needed
  # backend "azurerm" {
  #   resource_group_name  = "terraform-rg"
  #   storage_account_name = "terraformstatedev"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
  
  # Example GCS backend configuration - uncomment and modify as needed
  # backend "gcs" {
  #   bucket = "terraform-states-dev"
  #   prefix = "terraform/state"
  # }
}