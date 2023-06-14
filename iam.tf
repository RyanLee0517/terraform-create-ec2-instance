resource "aws_iam_role" "access_ec2_terminal" {
  name = "access_ec2_terminal"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AccessEC2ViaSSM"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = toset(var.iam_managed_policy_arns)
  role       = aws_iam_role.access_ec2_terminal.name
  policy_arn = each.key
}

resource "aws_iam_instance_profile" "access_ec2_terminal" {
  name = "access_ec2_terminal"
  role = aws_iam_role.access_ec2_terminal.name
}
