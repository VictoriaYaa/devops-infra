resource "aws_security_group" "worker_group_mgmt_one" {
  name = "worker_group_mgmt_one_MEW"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "94.159.136.165/32"
    ]
  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name = "worker_group_mgmt_two_NEW"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
      "94.159.136.165/32"
    ]
  }
}

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