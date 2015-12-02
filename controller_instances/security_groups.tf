## Controller SG
## This is the default configuration for the controller nodes, we allow 443 for API access.
resource "aws_security_group" "sg_controller" {
  vpc_id = "${var.vpc_id}"
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
