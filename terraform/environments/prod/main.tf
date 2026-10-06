terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Optional remote state (create the bucket first, then uncomment):
  # backend "s3" {
  #   bucket = "your-tf-state-bucket"
  #   key    = "prod/terraform.tfstate"
  #   region = "ap-south-1"
  # }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = { Project = "devops-project", Environment = "prod", ManagedBy = "terraform" }
  }
}

module "vpc" {
  source              = "../../modules/vpc"
  name                = "devops-prod"
  cidr                = "10.1.0.0/16"
  public_subnet_cidrs = ["10.1.1.0/24","10.1.2.0/24"]
}

module "web" {
  source         = "../../modules/ec2"
  name           = "devops-prod"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_ids[0]
  instance_type  = "t3.small"
  key_name       = var.key_name
  ssh_cidr       = var.ssh_cidr
  docker_image   = var.docker_image
  container_port = var.container_port
}
