## Worker SG
## We allow nothing specific here, as this should only need to talk to internal resources.
resource "aws_security_group" "sg_worker" {
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "sg_etcd"
    KubernetesCluster = "${var.cluster_name}"
}
