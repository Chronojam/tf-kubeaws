resource "aws_instance" "etcd0" {
  ami = "${var.coreos_ami}"
  instance_type = "${var.etcd_instance_type}"
  user_data = "${var.etcd_cloud_config}"
  tags = {
    role = "etcd_node"
    Name = "etcd0.chronojam.local"
    KubernetesCluster = "${var.cluster_name}"
  }
  key_name = "${var.key_name}"
  security_groups = [
    "${aws_security_group.sg_etcd.id}",
    "${aws_security_group.sg_kubernetes_internal.id}",
    "${aws_security_group.sg_debugging.id}"
  ]
  associate_public_ip_address = false
  private_ip = "10.0.0.20"
  subnet_id = "${aws_subnet.kubernetes_subnet.id}"
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_instance" "etcd1" {
  ami = "${var.coreos_ami}"
  instance_type = "${var.etcd_instance_type}"
  user_data = "${var.etcd_cloud_config}"
  tags = {
    role = "etcd_node"
    Name = "etcd1.chronojam.local"
    KubernetesCluster = "${var.cluster_name}"
  }
  key_name = "${var.key_name}"
  security_groups = [
    "${aws_security_group.sg_etcd.id}",
    "${aws_security_group.sg_kubernetes_internal.id}",
    "${aws_security_group.sg_debugging.id}"
  ]
  associate_public_ip_address = false
  private_ip = "10.0.0.21"
  subnet_id = "${aws_subnet.kubernetes_subnet.id}"
  depends_on = ["aws_internet_gateway.gw"]
}

