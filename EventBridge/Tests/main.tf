provider "aws" {
  region = "eu-west-1"

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  default_tags {
    tags = {
      Team               = "Infrastructure"
      Application        = "Test"
      ManagedByTerraform = "True"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "eventbridge/tests/terraform.tfstate"
    dynamodb_table = "terraform-statelock-table"
    region         = "eu-west-1"
  }
}
