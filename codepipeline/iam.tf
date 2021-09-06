resource "aws_iam_role" "kubectl_iam_role" {
  name               = "kubectl_iam_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.code_build_policy_document.json
}

resource "aws_iam_role" "codebuild_iam_role" {
  name               = "codebuild_iam_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.code_build_policy_document.json
}

resource "aws_iam_role_policy" "codebuild_iam_role_policy" {
  name   = "codebuild_iam_role_policy"
  role   = aws_iam_role.codebuild_iam_role.name
  policy = file("${path.module}/json-files/codebuild-policy.json")
}

resource "aws_iam_role" "codepipeline_iam_role" {
  name               = "codepipeline_iam_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.code_pipeline_policy_document.json
}

resource "aws_iam_role_policy" "codepipeline_iam_role_policy" {
  name   = "codepipeline_iam_role_policy"
  role   = aws_iam_role.codepipeline_iam_role.name
  policy = file("${path.module}/json-files/codepipeline-policy.json")
}