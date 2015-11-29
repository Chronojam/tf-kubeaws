resource "aws_subnet" "kubernetes_subnet" {
    vpc_id = "${aws_vpc.kubernetes_vpc.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    tags {
        Name = "kubernetes_subnet"
        KubernetesCluster = "${var.cluster_name}"
    }
}