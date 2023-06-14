variable "vpc_id" {
  type        = string
  default     = "vpc-074e2df47a3ed4983"
  description = "Default VPC ID"
}

variable "iam_managed_policy_arns" {
  type        = list(string)
  description = "IAM managed policies to be attached to ec2 role"
  default     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}