variable "environment" {
  default = "dev"
  type = string
}

variable "project" {
  default = "roboshop"
  type =string
}

variable "ami_id" {
  type        = string
  default     = "ami-0220d79f3f480ecf5"
  description = "RHEL9 joindevops image"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small","t3.medium","t3.large"], var.instance_type)
    error_message = "Imstance type should be either t3.micro or t3.small"
  }
}

variable "sg_name" {
  type    = string
  default = "allow_terraform_vars"
}

variable "port" {
  default = 0
  type    = number
}

variable "cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "instances" {
  default = ["mongodb","redis","mysql","rabbitmq"]
  type = list
  
}

    