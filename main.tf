#Irá conter os recursos criados no terraform
#Declaração do tipo e maquina de uma EC2 por exemplo.
terraform {
    required_version = ">=1.1.0"
    required_providers {
      aws = ">=4.0"
    }
}
#aws configure
provider "aws" {
    profile = "default"
    shared_credentials_files = "~/.aws/credentials"
    region = "us-east-1"
}
#terraform init 
#inicializa o projeto do terraform