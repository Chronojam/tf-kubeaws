resource "aws_iam_instance_profile" "controller_profile" {
    name = "controller_profile"
    roles = ["${aws_iam_role.iam_role_controller.name}"]
}
