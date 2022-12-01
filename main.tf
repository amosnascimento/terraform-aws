#Irá conter os recursos criados no terraform
#Declaração do tipo e maquina de uma EC2 por exemplo.
terraform {
  required_version = ">=1.1.0"
  required_providers {
    aws = ">=4.0"
  }
}
#aws configure
#http://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  profile                  = "default"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = "us-east-1"
}
#terraform init 
#inicializa o projeto do terraform

#data filtra a AMI na aws para retornar o ID da imagem
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  #passa o owner da AMI a ser buscada
  owners = ["099720109477"] # Canonical
}

#cria a instancia do EC2 baseado na imagem do id da AMI retornada na busca acima
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
#terraform validate -> para validar o codigo
#terraform plan -> exibe o que sera criado retornando os parametros que serão populados na instancia EC2, tudo com sinal de + é o que será adicionado
#terraform apply -> aplica o script criando a instancia dos recursos listados acima
#aws ec2 create-default-vpc -> caso tenha perdido a vpc padrao só criar uma nova usando esse comando
#terra form destroy -> exclui a infraestrutura atual

