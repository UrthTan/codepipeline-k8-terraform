resource "aws_iam_role" "codebuild_iam_role" {
  name               = "codebuild_iam_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.code_build_policy_document.json
}

resource "aws_iam_role_policy" "codebuild_iam_role_policy" {
  name = "codebuild_iam_role_policy"
  role = aws_iam_role.codebuild_iam_role.name
}