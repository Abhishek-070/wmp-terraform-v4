resource "aws_instance" "instance" {
  for_each = var.components
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids= ["sg-0a4cc58f87a256401"]

  tags = {
    Name = each.key
  }
}

resource "aws_route53_record" "dns" {
  for_each = var.components
  zone_id = "Z04759742TOEKPTLQKQGL"
  name    = "${each.key}-dev"
  type    = "A"
  ttl     = "30"
  records = [ aws_instance.instance[each.key].private_ip]
}

variable "components"{
  default = {
    frontend = ""
    postgresql = ""
    auth-service = ""
    portfolio-service = ""
    analytics-service = ""
  }

}