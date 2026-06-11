resource "aws_instance" "roboshop" {
  count = 4
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.roboshop[count.index].id,
    aws_security_group.common.id
    ] #list
  # labels, metadata, info, etc
  tags = {
    Name = "${var.project}-${var.environment}-${var.instances[count.index]}"  #interpolation
  }
}

# it creates in default VPC
resource "aws_security_group" "roboshop" {
  count = 4
  name        = "${var.project}-${var.environment}-${var.instances[count.index]}"
  description = "Allow TLS inbound traffic and all outbound traffic"

  # outbound traffic
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "-1" #All traffic
    cidr_blocks = var.cidr
  }


  tags = {
    Name = "${var.project}-${var.environment}-${var.instances[count.index]}"
  }
}

resource "aws_security_group" "common" {
  name        = "${var.project}-${var.environment}-common"
  description = "Allow TLS inbound traffic and all outbound traffic"

  # outbound traffic
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "-1" #All traffic
    cidr_blocks = var.cidr
  }


  tags = {
    Name = "${var.project}-${var.environment}-common"
  }
}