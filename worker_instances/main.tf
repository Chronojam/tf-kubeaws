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

resource "aws_iam_instance_profile" "worker_profile" {
    name = "worker_profile"
    roles = ["${aws_iam_role.iam_role_worker.name}"]
}

resource "aws_iam_role_policy" "worker_role_policy" {
    name = "allow_all_ec2"
    role = "${aws_iam_role.iam_role_worker.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ec2:AttachVolume"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ec2:DetachVolume"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "iam_role_worker" {
    name = "iam_role_worker"
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
