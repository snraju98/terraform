resource "aws_instance" "terraform_demo" {
    ami = data.aws_ami.joindevops.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_terraform.id] #list
    # labels, metadata, info, etc
    tags = {
        Name = "terraform-demo-1"
        project = "roboshop"
        Environment = "dev"
    }
}

# it creates in default VPC
resource "aws_security_group" "allow_terraform" {
  name        = "allow_terraform_data_source"
  description = "Allow TLS inbound traffic and all outbound traffic"

# outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  #All traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_terraform"
    project = "roboshop"
        Environment = "dev"
  }
}