# The name of our cluster
variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "coreos_ami" {}
variable "instance_type" {}

# Private key name
variable "keyname" {}

# Global security groups.
variable "debugging_sg_id" {}
variable "kubernetes_sg_id" {}

resource "aws_iam_instance_profile" "controller_profile" {
    name = "controller_profile"
    roles = ["${aws_iam_role.iam_role_controller.name}"]
}

resource "aws_iam_role" "iam_role_controller" {
    name = "iam_role_controller"
    path = "/"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
              "sts:AssumeRole"
            ],
            "Principal": {
              "Service": [
                "ec2.amazonaws.com"
              ]
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "controller_role_policy" {
    name = "allow_all_ec2"
    role = "${aws_iam_role.iam_role_controller.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "elasticloadbalancing:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
