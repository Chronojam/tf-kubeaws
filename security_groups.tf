# TLDR We have 3 security groups, each allows all access from the others, and ssh from external sources.
# The controller securit group also allows HTTPS from external sources (So we can access the API)

## Kubernetes internal SG
## This group allows all access between instances inside it
## It also allows all outbound traffic.

resource "aws_security_group" "sg_kubernetes_internal" {
  vpc_id = "${aws_vpc.kubernetes_vpc.id}"
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Debugging SG
## This group allows SSH access from anywhere, useful for debugging purposes.
resource "aws_security_group" "sg_debugging" {
  vpc_id = "${aws_vpc.kubernetes_vpc.id}"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

## Controller SG
## This is the default configuration for the controller nodes, we allow 443 for API access.
resource "aws_security_group" "sg_controller" {
  vpc_id = "${aws_vpc.kubernetes_vpc.id}"
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg_ingress"
    KubernetesCluster = "${var.cluster_name}"
  } 
}

## Worker SG
## We allow nothing specific here, as this should only need to talk to internal resources.
resource "aws_security_group" "sg_worker" {
  vpc_id = "${aws_vpc.kubernetes_vpc.id}"
  tags {
    Name = "sg_worker"
    KubernetesCluster = "${var.cluster_name}"
  } 
}
