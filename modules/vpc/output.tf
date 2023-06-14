output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "VPC ID"
}

output "public_subnet" {
  value       = aws_subnet.public_subnet.id
  description = "Publib subnet ID"
}