# 참고 : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

## EC2 instance에 iam_instance_profile 할당을 위한 resource
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.prefix}-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "${var.prefix}-policy"
  role = aws_iam_role.ec2_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.instance_profile_policies
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
