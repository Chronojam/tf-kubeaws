resource "aws_instance" "kn0" {
  ami = "${var.coreos_ami}"
  instance_type = "${var.worker_instance_type}"
  user_data = "${var.worker_cloud_config}"
  tags = {
    role = "kubernetes_worker"
    Name = "kn0.chronojam.local"
    KubernetesCluster = "${var.cluster_name}"
  }
  key_name = "${var.key_name}"
  security_groups = [
    "${aws_security_group.sg_worker.id}",
    "${aws_security_group.sg_kubernetes_internal.id}",
    "${aws_security_group.sg_debugging.id}"
  ]
  iam_instance_profile = "${aws_iam_instance_profile.worker_profile.name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.kubernetes_subnet.id}"
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_instance" "kn1" {
  ami = "${var.coreos_ami}"
  instance_type = "${var.worker_instance_type}"
  user_data = "${var.worker_cloud_config}"
  tags = {
    role = "kubernetes_worker"
    Name = "kn1.chronojam.local"
    KubernetesCluster = "${var.cluster_name}"
  }
  key_name = "${var.key_name}"
  security_groups = [
    "${aws_security_group.sg_worker.id}",
    "${aws_security_group.sg_kubernetes_internal.id}",
    "${aws_security_group.sg_debugging.id}"
  ]
  iam_instance_profile = "${aws_iam_instance_profile.worker_profile.name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.kubernetes_subnet.id}"
  depends_on = ["aws_internet_gateway.gw"]
}
