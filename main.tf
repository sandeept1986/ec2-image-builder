# Create the EC2 IAM role to use for the image
resource "aws_iam_role" "ec2_iam_role" {
  ec2_iam_role_name = var.ec2_iam_role_name

  assume_role_policy = file("files/assumption-policy.json")
  policy = data.aws_iam_policy_document.image_builder.json
}

data "aws_region" "current" {}
data "aws_partition" "current" {}

data "aws_subnet" "this" {
  filter {
    name   = "tag:Name"
    values = ["default-public-1d"]
  }
}

data "aws_security_group" "this" {
  filter {
    name   = "tag:Name"
    values = ["default-sec-group"]
  }
}
