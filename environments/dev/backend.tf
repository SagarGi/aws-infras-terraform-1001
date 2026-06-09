# environments/dev/backend.tf

terraform {
  backend "s3" {
    bucket         = "sagar-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}