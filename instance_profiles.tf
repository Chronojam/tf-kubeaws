resource "aws_iam_instance_profile" "controller_profile" {
    name = "controller_profile"
    roles = ["${aws_iam_role.iam_role_controller.name}"]
}

resource "aws_iam_instance_profile" "worker_profile" {
    name = "worker_profile"
    roles = ["${aws_iam_role.iam_role_worker.name}"]
}