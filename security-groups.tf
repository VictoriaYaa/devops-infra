resource "aws_security_group" "all_worker_mgmt" {
  name = "all_worker_management_NEW"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
      "94.159.136.165/32"
    ]
  }
}



# Create Resource Group for the Application Load Balancer
resource "aws_security_group" "alb-security-group" {
  name = "vic-alb-sg"
  description = "Enable HTTP or HTTPS access on Ports 80/443"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP Access"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "HTTPS Access"
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}