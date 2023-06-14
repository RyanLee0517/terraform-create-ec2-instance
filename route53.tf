# data "aws_acm_certificate" "awslecsa_wildcard_acm_cert" {
#   domain      = "luantd.tech"
#   statuses    = ["ISSUED"]
#   most_recent = true
# }

# data "aws_route53_zone" "hosted_zone" {
#   name = local.domain
# }

# resource "aws_route53_record" "cf_dns" {
#   zone_id = data.aws_route53_zone.hosted_zone.zone_id
#   name    = "jenkins.${local.domain}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.jenkins.public_ip]
# }