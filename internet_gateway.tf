resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.kubernetes_vpc.id}"
}

resource "aws_route_table" "r" {
    vpc_id = "${aws_vpc.kubernetes_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "main"
        KubernetesCluster = "${var.cluster_name}"
    }
}

resource "aws_route_table_association" "a" {
    subnet_id = "${aws_subnet.kubernetes_subnet.id}"
    route_table_id = "${aws_route_table.r.id}"
}