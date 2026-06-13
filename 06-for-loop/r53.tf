resource "aws_route53_record" "roboshop" {
  for_each = aws_instance.roboshop
  zone_id = var.zone_id
  name    = "${each.key}-${var.environment}.${var.domain_name}"  # mongodb-dev.daws90s.fun
  type    = "A"
  ttl     = 1
  records = [each.value.private_ip]
}


resource "aws_route53_record" "frontend" {
  count = contains(keys(var.instances), "frontend") ? 1 : 0
  zone_id = var.zone_id
  name    = "${var.project}-${var.environment}.${var.domain_name}"  # roboshop-dev.daws90s.fun
  type    = "A"
  ttl     = 1
  records = [lookup(aws_instance.roboshop, "frontend").public_ip]
}