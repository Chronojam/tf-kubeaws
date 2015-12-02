#module "controller_instances" {
#  source = "./controller_instances"
#}

#module "worker_instances" {
#  source = "./worker_instances"
#}

module "etcd_instances" {
  source = "./etcd_instances"
  vpc_id = "${aws_vpc.kubernetes_vpc.id}"
  cluster_name = "${var.cluster_name}"
  subnet_id = "${aws_subnet.kubernetes_subnet.id}"
  keyname = "${var.key_name}"
  coreos_ami = "${var.coreos_ami}"
  instance_type = "${var.etcd_instance_type}"

  debugging_sg_id = "${aws_security_group.sg_debugging.id}"
  kubernetes_sg_id = "${aws_security_group.sg_kubernetes_internal.id}"
}
