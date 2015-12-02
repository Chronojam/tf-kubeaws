resource "aws_route53_record" "etcddiscovery" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name = "_etcd-server._tcp.${var.etcd_domain_name}"
  type = "SRV"
  ttl = "300"
  records = [
    "1 0 2380 etcd_10_0_0_20.${var.etcd_domain_name}",
    "1 0 2380 etcd_10_0_0_21.${var.etcd_domain_name}"
  ]
}
