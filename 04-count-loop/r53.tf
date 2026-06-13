resource "aws_route53_record" "roboshop" {
  count = length(var.instances)
  zone_id = var.zone_id
  name    = "${var.instances[count.index]}-${var.environment}.${var.domain_name}"  # mongodb-dev.daws90s.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.roboshop[count.index].private_ip]
}


resource "aws_route53_record" "frontend" {
  count = contains(var.instances, "frontend") ? 1 : 0
  zone_id = var.zone_id
  name    = "${var.project}-${var.environment}.${var.domain_name}"  # roboshop-dev.daws90s.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.roboshop[index(var.instances, "frontend")].public_ip]
}