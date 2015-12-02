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
