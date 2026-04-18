data "aws_iam_group" "imported_group" {
  group_name = "grp-developers"
}

resource "aws_iam_user" "new_user" {
  name = "${var.project_name}-${var.enviroment}-user"

  tags = {
    "project"    = var.project_name
    "class"      = "05-data"
    "created_by" = var.created_by
  }
}

resource "aws_iam_user_group_membership" "add_to_group" {
  user   = aws_iam_user.new_user.name
  groups = [data.aws_iam_group.imported_group.group_name]
}

output "new_user_name" {
  value = aws_iam_user.new_user.name
}

output "new_user_arn" {
  value = aws_iam_user.new_user.arn
}
