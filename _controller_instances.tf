resource "aws_instance" "km0" {
  ami = "${var.coreos_ami}"
  instance_type = "${var.controller_instance_type}"
  user_data = "${var.controller_cloud_config}"
  tags = {
    role = "kubernetes_controller"
    Name = "km0.chronojam.local"
    KubernetesCluster = "${var.cluster_name}"
  }
  key_name = "${var.key_name}"
  security_groups = [
    "${aws_security_group.sg_controller.id}",
    "${aws_security_group.sg_kubernetes_internal.id}",
    "${aws_security_group.sg_debugging.id}"
  ]
  iam_instance_profile = "${aws_iam_instance_profile.controller_profile.name}"
  associate_public_ip_address = false
  private_ip = "10.0.0.50"
  subnet_id = "${aws_subnet.kubernetes_subnet.id}"
  depends_on = ["aws_internet_gateway.gw"]
}
