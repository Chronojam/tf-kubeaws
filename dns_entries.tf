resource "aws_route53_zone" "private" {
  name = "etcd-cluster.local"
  vpc_id = "${aws_vpc.kubernetes_vpc.id}"
}

resource "aws_route53_record" "etcd0" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name = "etcd0.etcd-cluster.local"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.etcd0.private_ip}"]
}

resource "aws_route53_record" "etcd1" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name = "etcd1.etcd-cluster.local"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.etcd1.private_ip}"]
}

### ETCD DISCOVERY ###
resource "aws_route53_record" "etcddiscovery" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name = "_etcd-server._tcp.etcd-cluster.local"
  type = "SRV"
  ttl = "300"
  records = [
    "1 0 2380 etcd0.etcd-cluster.local",
    "1 0 2380 etcd1.etcd-cluster.local"
  ]
}