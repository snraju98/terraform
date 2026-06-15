resource "aws_instance" "terraform_demo" {
    ami = "ami-0220d79f3f480ecf5"
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
  name        = "allow_terraform_dynamic"
  description = "Allow TLS inbound traffic and all outbound traffic"

# outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  #All traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }
 # ingress block
 # this gives us a special varaible ingress 
  dynamic "ingress" {
    for_each = var.ingress_rules
    content{
        from_port        = ingress.value.port
        to_port          = ingress.value.port
        protocol         = "tcp"  #All traffic
        cidr_blocks      = ingress.value.cidr_blocks

    }
  }

  tags = {
    Name = "allow_terraform"
    project = "roboshop"
        Environment = "dev"
  }
}