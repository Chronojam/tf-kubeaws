# The name of our cluster
variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "coreos_ami" {}
variable "instance_type" {}

# Private key name
variable "keyname" {}

# Global security groups.
variable "debugging_sg_id" {}
variable "kubernetes_sg_id" {}

# Domain name we should use for discovery.
variable "etcd_domain_name" {
  default = "etcd-cluster.local"
}

resource "aws_route53_zone" "private" {
  name = "${var.etcd_domain_name}"
  vpc_id = "${var.vpc_id}"
}
