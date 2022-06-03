variable "region" {
  default   = "us-east-1"
  description   = "AWS region"
}


variable "cluster_name" {
  default = "vic-terraform-eks-NEW"
}


variable "security_groups" {
  type = list(object({
    name        = string
    description = string
    ingress = object({
      description      = string
      protocol         = string
      from_port        = number
      to_port          = number
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    })
  }))

  default = [{
    name        = "ssh"
    description = "Port 22"
    ingress = {
      description      = "Allow SSH access"
      protocol         = "tcp"
      from_port        = 22
      to_port          = 22
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
    }
  }]
}