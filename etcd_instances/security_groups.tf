resource "aws_security_group" "sg_etcd" {
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "sg_etcd"
    KubernetesCluster = "${var.cluster_name}"
}

