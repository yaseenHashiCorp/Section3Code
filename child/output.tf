output "web_instance_ip" {
    value = aws_instance.web.public_ip
}

output "web_instance_public_dns"{
value = aws_instance.web.public_dns
}